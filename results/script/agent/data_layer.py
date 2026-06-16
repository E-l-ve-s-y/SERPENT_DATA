#!/usr/bin/env python3
"""
Data Layer - SQLite Data Lake with Streaming Support
=====================================================
Provides efficient data storage and streaming access for Serpent simulation results.
Avoids loading entire CSV into memory by using SQLite + chunked reading.

Usage:
    from data_layer import DataLake, stream_case, filter_cases
"""

import sqlite3
import json
import mmap
from pathlib import Path
from typing import Iterator, Optional, List, Dict, Any, Tuple
from dataclasses import dataclass, field
from contextlib import contextmanager
import pandas as pd
import numpy as np

# Constants
DB_PATH = Path(__file__).parent.parent.parent / "data_processed" / "V1" / "data_lake.db"
CACHE_DIR = Path(__file__).parent.parent / ".cache"
CHUNK_SIZE = 5  # burnup steps per chunk

# Target isotopes for thorium-based fuel analysis
TARGET_ISOTOPES = [
    'U233', 'U235', 'U238', 'Th232', 'Pa233', 'Pu239', 'Pu241',
    'Am241', 'Am242', 'Am243', 'Am244', 'Am245', 'Sm149', 'Xe135'
]

# Fissile isotopes for FIR calculation
FISSILE_ISOTOPES = ['U233', 'U235', 'Pu239', 'Pu241']


@dataclass
class CaseSummary:
    """Case summary metadata"""
    case_id: str
    group_letter: str
    keff_0: float
    keff_final: float
    cr_0: float
    cr_final: float
    fir_0: float
    fir_final: float
    max_burnup: float
    n_steps: int
    file_size_mb: float
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    def to_dict(self) -> dict:
        return {
            'case_id': self.case_id,
            'group_letter': self.group_letter,
            'keff_0': self.keff_0,
            'keff_final': self.keff_final,
            'cr_0': self.cr_0,
            'cr_final': self.cr_final,
            'fir_0': self.fir_0,
            'fir_final': self.fir_final,
            'max_burnup': self.max_burnup,
            'n_steps': self.n_steps,
            'file_size_mb': self.file_size_mb,
            'metadata': json.dumps(self.metadata)
        }
    
    @classmethod
    def from_dict(cls, d: dict) -> 'CaseSummary':
        d = d.copy()
        if 'metadata' in d and isinstance(d['metadata'], str):
            d['metadata'] = json.loads(d['metadata'])
        return cls(**{k: v for k, v in d.items() if k in cls.__dataclass_fields__})


class DataLake:
    """
    Data Lake - Efficient storage and retrieval of Serpent simulation results.
    
    Uses SQLite for metadata and case-level summaries,
    with optional Parquet caching for fast DataFrame access.
    """
    
    def __init__(self, db_path: Optional[Path] = None, cache_dir: Optional[Path] = None):
        self.db_path = db_path or DB_PATH
        self.cache_dir = cache_dir or CACHE_DIR
        self.cache_dir.mkdir(exist_ok=True)
        
        self._init_schema()
    
    def _init_schema(self):
        """Initialize SQLite database schema"""
        with self._get_conn() as conn:
            # Cases metadata table
            conn.execute("""
                CREATE TABLE IF NOT EXISTS cases (
                    case_id TEXT PRIMARY KEY,
                    group_letter TEXT NOT NULL,
                    keff_0 REAL,
                    keff_final REAL,
                    cr_0 REAL,
                    cr_final REAL,
                    fir_0 REAL,
                    fir_final REAL,
                    max_burnup REAL,
                    n_steps INTEGER,
                    file_size_mb REAL,
                    metadata TEXT
                )
            """)
            
            # Burnup steps data table (indexed by case)
            conn.execute("""
                CREATE TABLE IF NOT EXISTS burnup_steps (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    case_id TEXT NOT NULL,
                    step INTEGER NOT NULL,
                    burnup REAL,
                    keff REAL,
                    reactivity_pcm REAL,
                    conversion_ratio REAL,
                    fir REAL,
                    -- Mass densities (g/cm3)
                    Mdens_U233 REAL, Mdens_U235 REAL, Mdens_U238 REAL,
                    Mdens_Th232 REAL, Mdens_Pa233 REAL, Mdens_Pu239 REAL,
                    Mdens_Pu241 REAL, Mdens_Am241 REAL, Mdens_Am242 REAL,
                    Mdens_Am243 REAL, Mdens_Am244 REAL, Mdens_Am245 REAL,
                    Mdens_Sm149 REAL, Mdens_Xe135 REAL,
                    -- Atomic densities (atoms/barn/cm)
                    Adens_U233 REAL, Adens_U235 REAL, Adens_U238 REAL,
                    Adens_Th232 REAL, Adens_Pa233 REAL, Adens_Pu239 REAL,
                    Adens_Pu241 REAL, Adens_Am241 REAL, Adens_Am242 REAL,
                    Adens_Am243 REAL, Adens_Am244 REAL, Adens_Am245 REAL,
                    Adens_Sm149 REAL, Adens_Xe135 REAL,
                    -- Reaction rates (1/s)
                    U235_FISS REAL, U238_FISS REAL, PU239_FISS REAL,
                    PU240_FISS REAL, PU241_FISS REAL,
                    U235_CAPT REAL, U238_CAPT REAL, PU239_CAPT REAL,
                    PU240_CAPT REAL, PU241_CAPT REAL, XE135_CAPT REAL, XE135M_CAPT REAL,
                    UNIQUE(case_id, step)
                )
            """)
            
            # Create indexes for fast queries
            conn.execute("CREATE INDEX IF NOT EXISTS idx_case ON burnup_steps(case_id)")
            conn.execute("CREATE INDEX IF NOT EXISTS idx_group ON cases(group_letter)")
            conn.execute("CREATE INDEX IF NOT EXISTS idx_keff ON cases(keff_0)")
            conn.execute("CREATE INDEX IF NOT EXISTS idx_burnup ON cases(max_burnup)")
            
            conn.commit()
    
    @contextmanager
    def _get_conn(self):
        """Context manager for database connection"""
        conn = sqlite3.connect(str(self.db_path))
        conn.row_factory = sqlite3.Row
        try:
            yield conn
        finally:
            conn.close()
    
    def insert_case(self, summary: CaseSummary, steps_data: List[dict]):
        """Insert a case with its burnup steps"""
        with self._get_conn() as conn:
            # Insert case summary
            conn.execute(
                """INSERT OR REPLACE INTO cases 
                   (case_id, group_letter, keff_0, keff_final, cr_0, cr_final,
                    fir_0, fir_final, max_burnup, n_steps, file_size_mb, metadata)
                   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
                (summary.case_id, summary.group_letter, summary.keff_0, summary.keff_final,
                 summary.cr_0, summary.cr_final, summary.fir_0, summary.fir_final,
                 summary.max_burnup, summary.n_steps, summary.file_size_mb,
                 json.dumps(summary.metadata))
            )
            
            # Insert burnup steps. Only include columns that exist in the table.
            existing_cols = [r['name'] for r in conn.execute("PRAGMA table_info(burnup_steps)").fetchall()]
            for step_data in steps_data:
                insert_cols = ['case_id', 'step']
                for k in step_data.keys():
                    if k in ('case_id', 'step'):
                        continue
                    if k in existing_cols:
                        insert_cols.append(k)

                placeholders = ','.join(['?'] * len(insert_cols))
                vals = [summary.case_id, step_data.get('step', 0)] + [step_data.get(c) for c in insert_cols if c not in ('case_id', 'step')]

                conn.execute(
                    f"INSERT OR REPLACE INTO burnup_steps ({','.join(insert_cols)}) VALUES ({placeholders})",
                    vals
                )
            
            conn.commit()
    
    def get_case_summary(self, case_id: str) -> Optional[CaseSummary]:
        """Get case summary metadata (fast, no step data)"""
        with self._get_conn() as conn:
            row = conn.execute(
                "SELECT * FROM cases WHERE case_id = ?", [case_id]
            ).fetchone()
            return CaseSummary.from_dict(dict(row)) if row else None
    
    def get_case_data(self, case_id: str) -> pd.DataFrame:
        """Get full case data as DataFrame"""
        with self._get_conn() as conn:
            return pd.read_sql_query(
                "SELECT * FROM burnup_steps WHERE case_id = ? ORDER BY step",
                conn, params=[case_id]
            )
    
    def stream_case(self, case_id: str, chunk_size: int = CHUNK_SIZE) -> Iterator[pd.DataFrame]:
        """Stream case data in chunks (memory-efficient)"""
        with self._get_conn() as conn:
            for chunk in pd.read_sql_query(
                "SELECT * FROM burnup_steps WHERE case_id = ? ORDER BY step",
                conn, params=[case_id], chunksize=chunk_size
            ):
                yield chunk
    
    def filter_cases(
        self,
        groups: Optional[List[str]] = None,
        keff_range: Optional[Tuple[float, float]] = None,
        cr_range: Optional[Tuple[float, float]] = None,
        fir_range: Optional[Tuple[float, float]] = None,
        burnup_range: Optional[Tuple[float, float]] = None,
        limit: int = None
    ) -> List[str]:
        """Filter cases by multiple criteria (SQL-based, memory-efficient)"""
        conditions = []
        params = []
        
        if groups:
            placeholders = ','.join(['?'] * len(groups))
            conditions.append(f"group_letter IN ({placeholders})")
            params.extend(groups)
        
        if keff_range:
            conditions.append("keff_0 BETWEEN ? AND ?")
            params.extend(keff_range)
        
        if cr_range:
            conditions.append("cr_0 BETWEEN ? AND ?")
            params.extend(cr_range)
        
        if fir_range:
            conditions.append("fir_0 BETWEEN ? AND ?")
            params.extend(fir_range)
        
        if burnup_range:
            conditions.append("max_burnup BETWEEN ? AND ?")
            params.extend(burnup_range)
        
        where = " AND ".join(conditions) if conditions else "1=1"
        query = f"SELECT case_id FROM cases WHERE {where}"
        if limit:
            query += f" LIMIT {limit}"
        
        with self._get_conn() as conn:
            return [row['case_id'] for row in conn.execute(query, params)]
    
    def get_all_summaries(self) -> List[CaseSummary]:
        """Get all case summaries"""
        with self._get_conn() as conn:
            return [
                CaseSummary.from_dict(dict(row))
                for row in conn.execute("SELECT * FROM cases ORDER BY case_id")
            ]
    
    def get_group_statistics(self) -> pd.DataFrame:
        """Get statistics by group"""
        with self._get_conn() as conn:
            return pd.read_sql_query("""
                SELECT 
                    group_letter,
                    COUNT(*) as n_cases,
                    AVG(keff_0) as avg_keff_0,
                    AVG(keff_final) as avg_keff_final,
                    AVG(cr_0) as avg_cr_0,
                    AVG(cr_final) as avg_cr_final,
                    AVG(fir_0) as avg_fir_0,
                    AVG(fir_final) as avg_fir_final,
                    AVG(max_burnup) as avg_max_burnup
                FROM cases
                GROUP BY group_letter
                ORDER BY group_letter
            """, conn)
    
    def get_isotope_statistics(self, isotope: str) -> pd.DataFrame:
        """Get isotope mass density statistics across all cases"""
        if isotope not in TARGET_ISOTOPES:
            raise ValueError(f"Unknown isotope: {isotope}")
        
        with self._get_conn() as conn:
            return pd.read_sql_query(f"""
                SELECT 
                    case_id,
                    group_letter,
                    step,
                    burnup,
                    Mdens_{isotope} as mass_density,
                    Adens_{isotope} as atomic_density
                FROM burnup_steps bs
                JOIN cases c ON bs.case_id = c.case_id
                WHERE Mdens_{isotope} IS NOT NULL
                ORDER BY case_id, step
            """, conn)
    
    def count(self) -> int:
        """Count total cases"""
        with self._get_conn() as conn:
            return conn.execute("SELECT COUNT(*) FROM cases").fetchone()[0]


def stream_large_file(filepath: str, buffer_size: int = 1024 * 1024) -> Iterator[str]:
    """
    Memory-efficient streaming of large files using mmap.
    
    Args:
        filepath: Path to file to stream
        buffer_size: Read buffer size in bytes
    
    Yields:
        Lines from the file one at a time
    """
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        # Try to use mmap for faster random access
        try:
            with mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ) as mm:
                while True:
                    line = mm.readline()
                    if not line:
                        break
                    yield line.decode('utf-8', errors='ignore')
        except (ValueError, OSError):
            # Fallback for files that can't be memory-mapped
            f.seek(0)
            while True:
                line = f.readline()
                if not line:
                    break
                yield line


def parse_matlab_stream(filepath: Path, blocks_to_extract: List[str]) -> Iterator[Tuple[str, List[dict]]]:
    """
    Stream-parse MATLAB file, yielding specific data blocks.
    
    Args:
        filepath: Path to .m file
        blocks_to_extract: List of block names to extract (e.g., ['MAT_fuel_MDENS', 'MAT_fuel_BURNUP'])
    
    Yields:
        (block_name, list of parsed data rows)
    """
    current_block = []
    block_name = None
    in_block = False
    
    for line in stream_large_file(str(filepath)):
        # Check for start of target block
        for target in blocks_to_extract:
            if f'{target} = [' in line or f'{target}=' in line:
                in_block = True
                block_name = target
                current_block = [line]
                break
        
        # Collect block lines
        if in_block:
            current_block.append(line)
            if line.strip().startswith('];'):
                # Parse and yield block
                parsed = _parse_mdens_block(current_block)
                yield block_name, parsed
                in_block = False
                current_block = []
                block_name = None


def _parse_mdens_block(lines: List[str]) -> List[dict]:
    """Parse MAT_fuel_MDENS/ADENS block into structured data"""
    data = []
    current_row = []
    
    for line in lines:
        line = line.strip()
        if not line or line.startswith('%') or line.startswith('MAT_') or line.startswith('];'):
            continue
        
        # Extract comment (isotope name)
        comment = ""
        if '%' in line:
            parts = line.split('%', 1)
            comment = parts[1].strip() if len(parts) > 1 else ""
            line = parts[0]
        
        # Parse numbers
        numbers = []
        for part in line.replace('[', ' ').replace(']', ' ').split():
            try:
                numbers.append(float(part))
            except ValueError:
                continue
        
        if numbers:
            data.append({'isotope': comment, 'values': numbers})
    
    return data


def load_cases_metadata(raw_data_dir: Path) -> Iterator[dict]:
    """Load case metadata from raw data directories"""
    for case_dir in sorted(raw_data_dir.iterdir()):
        if not case_dir.is_dir():
            continue
        
        case_id = case_dir.name
        if not case_id[0] in 'ABCD' or len(case_id) != 4:
            continue
        
        # Calculate directory size
        total_size = sum(f.stat().st_size for f in case_dir.glob('*') if f.is_file())
        
        yield {
            'case_id': case_id,
            'group_letter': case_id[0],
            'file_size_mb': total_size / (1024 * 1024)
        }


# Example usage
if __name__ == '__main__':
    dl = DataLake()
    print(f"DataLake initialized at: {dl.db_path}")
    print(f"Total cases: {dl.count()}")
    
    if dl.count() > 0:
        # Show group statistics
        stats = dl.get_group_statistics()
        print("\nGroup Statistics:")
        print(stats.to_string())