#!/usr/bin/env python3
# 运行说明：
# - 请从 `results/` 目录运行本脚本以确保相对导入正确。例如：
#     cd results
#     python script/extract_data.py --csv --sqlite
# - 单独导出 CSV：
#     python script/extract_data.py --csv
# - 仅填充 SQLite 数据库（需要 `data_layer` 可用）：
#     python script/extract_data.py --sqlite
# - 注意：填充 SQLite 需安装脚本依赖并确保 `results/script/agent/data_layer.py` 可导入。
# - 推荐使用系统 Python（与仓库 README 一致）。如遇导入错误，检查当前工作目录或使用 `python -m pip install -r requirements.txt`（若存在）。
#
# 说明结束。
# 注意：本分支/版本已禁用绘图（matplotlib/numpy），脚本仅导出 `data.csv` 和 `detector_spectra.csv`。
# pyright: reportMissingImports=false, reportMissingModuleSource=false
"""
Extract MAT_fuel_MDENS (mass densities) and MAT_fuel_ADENS (atomic densities),
CONVERSION_RATIO, and reaction rates from SERPENT simulation output files
and consolidate into a single CSV for analysis and SQLite Data Lake.

Supports two output modes:
1. CSV (legacy) - compatible with existing analysis scripts
2. SQLite Data Lake - optimized for AI agent queries
"""

import re
import csv
import sys
from pathlib import Path
from typing import List, Dict, Tuple, Optional
import math

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).parent))

IMPORT_ERROR_MSG = ""

try:
    # Preferred when running this file directly from results/script.
    from agent.data_layer import DataLake, CaseSummary, FISSILE_ISOTOPES
    HAS_DATALAYER = True
except ImportError as exc_direct:
    try:
        # Fallback for package-style execution from workspace root.
        from results.script.agent.data_layer import DataLake, CaseSummary, FISSILE_ISOTOPES
        HAS_DATALAYER = True
    except ImportError as exc_pkg:
        HAS_DATALAYER = False
        IMPORT_ERROR_MSG = f"{exc_direct}; {exc_pkg}"
        print(
            "Warning: data_layer import failed, SQLite Data Lake will not be populated. "
            f"Details: {IMPORT_ERROR_MSG}"
        )

# Configuration
BASE_DIR = Path(__file__).resolve().parent.parent
DATA_RAW = BASE_DIR / "data_raw" / "V1"
OUT_DIR = BASE_DIR / "data_processed" / "V1"
OUT_CSV = OUT_DIR / "data.csv"
OUT_SPECTRA_DIR = OUT_DIR / "neutron_spectra"
# Version tag for subfolder structure (V1, V2, etc.)
VERSION = "V1"

# Energy group boundaries for neutron spectrum (in eV)
# Based on user-provided 7-group structure
ENERGY_GROUPS = [
    (1e-11, 4e-9),      # Group 1
    (4e-9, 1e-8),       # Group 2
    (1e-8, 1e-7),       # Group 3
    (1e-7, 6.25e-7),    # Group 4
    (6.25e-7, 9.06e-4), # Group 5
    (9.06e-4, 3e-3),    # Group 6
    (3e-3, 2e+1),       # Group 7
]

# Group labels for plotting
ENERGY_GROUP_LABELS = [f'G{i+1}' for i in range(len(ENERGY_GROUPS))]

# Isotopes to extract both MDENS and ADENS for
TARGET_ISOTOPES = [
    'U233', 'U235', 'U238', 'Th232', 'Pa233', 'Pu239', 'Pu241',
    'Pu240', 'Pu242', 'Am241', 'Am243', 'Sm149', 'Xe135'
]

# Fixed power density used by the cases, taken from the Serpent input deck.
POWER_DENSITY_MW_PER_KGHM = 3.8e-2

# Assembly/fuel geometry constants (used to convert densities -> absolute mass)
# These default values match the generator defaults / A001 case:
# fuel rods per assembly, fuel pellet radius (cm), active height (cm), assembly mass (kg)
FUEL_RODS = 264
FUEL_R_CM = 0.410
ACTIVE_HEIGHT_CM = 365.0
ASSEMBLY_MASS_KG = 498.7


def normalize_iso_key(name: str) -> str:
    """Normalize isotope-like key names for resilient matching.

    Examples:
    - iAm241 -> AM241
    - Am-242m -> AM242M
    - xe135 -> XE135
    """
    key = name.strip().upper()
    if key.startswith('I') and len(key) > 1 and key[1].isalpha():
        key = key[1:]
    return re.sub(r'[^A-Z0-9]', '', key)


def isotope_aliases(iso: str) -> set[str]:
    """Return normalized aliases accepted for a target isotope label."""
    norm = normalize_iso_key(iso)
    aliases = {norm}
    return aliases


def find_isotope_series(data_map: Dict[str, List[float]], iso: str) -> Optional[List[float]]:
    """Find isotope series by exact key, prefix key, or normalized aliases."""
    if iso in data_map:
        return data_map[iso]

    aliases = isotope_aliases(iso)
    for key, vals in data_map.items():
        normalized = normalize_iso_key(key)
        if normalized in aliases:
            return vals
        for alias in aliases:
            if normalized.startswith(alias):
                return vals
    return None


def burnup_to_efpd(burnup_mwd_kg_hm: Optional[float]) -> Optional[float]:
    """Convert burnup in MWd/kgHM to effective full power days (EFPD)."""
    if burnup_mwd_kg_hm is None:
        return None
    return burnup_mwd_kg_hm / POWER_DENSITY_MW_PER_KGHM

# Reaction rates to extract from .sss_res.m
# Note: TH232 and U233 rates are not available in the source files
FISS_RATES = ['U235_FISS', 'U238_FISS', 'PU239_FISS', 'PU240_FISS', 'PU241_FISS']
CAPT_RATES = ['U235_CAPT', 'U238_CAPT', 'PU239_CAPT', 'PU240_CAPT', 'PU241_CAPT', 'XE135_CAPT', 'XE135M_CAPT']

RE_MDENS_BLOCK = re.compile(r"MAT_fuel_MDENS\s*=\s*\[", re.I)
RE_ADENS_BLOCK = re.compile(r"MAT_fuel_ADENS\s*=\s*\[", re.I)
RE_BURNUP = re.compile(r"MAT_fuel_BURNUP\s*=\s*\[([^\]]+)\];", re.I)
RE_BLOCK_END = re.compile(r"\];")
RE_CONV = re.compile(r"CONVERSION_RATIO\s*\(idx[\s\S]*?\)\s*=\s*\[\s*([0-9Ee+\-\.]+)\s+([0-9Ee+\-\.]+)\s*\];")
RE_ANA_KEFF = re.compile(r"ANA_KEFF\s*\(idx[\s\S]*?\)\s*=\s*\[\s*([0-9Ee+\-\.]+)\s+([0-9Ee+\-\.]+)\s*\]")
RE_RATE = re.compile(r"(\w+_(?:FISS|CAPT))\s*\(idx,\s*\[1:\s*4\]\)\s*=\s*\[\s*([0-9Ee+\-\.]+)\s+")

def parse_names(lines: List[str]) -> List[str]:
    """Extract NAMES from the MATLAB file"""
    names = []
    inside = False
    for ln in lines:
        if ln.strip().startswith('NAMES') and '=' in ln:
            inside = True
        if inside:
            if '];' in ln:
                inside = False
                break
            m = re.search(r"'([^']+)'", ln)
            if m:
                names.append(m.group(1).strip())
    return names

def parse_mat_block(lines: List[str], start_idx: int) -> List[str]:
    """Return block lines between the opening [ and the closing ];"""
    out = []
    for ln in lines[start_idx:]:
        out.append(ln.rstrip('\n'))
        if RE_BLOCK_END.search(ln):
            break
    return out

def parse_mdens_rows(block_lines: List[str]) -> List[List[float]]:
    """Parse MAT_fuel_MDENS block into rows of numbers"""
    rows = []
    for ln in block_lines:
        ln = ln.strip()
        if not ln or ln.startswith('MAT_fuel_MDENS'):
            continue
        if ln.startswith('];'):
            break
        parts = ln.split('%')
        nums_part = parts[0]
        nums_part = nums_part.strip().lstrip('[').rstrip(']')
        nums = [float(x) for x in re.findall(r'[+-]?[0-9]*\.?[0-9]+(?:[Ee][+-]?\d+)?', nums_part)]
        if nums:
            rows.append(nums)
    return rows

def parse_matlab_array_simple(text: str, name: str) -> List[float]:
    """Extract simple MATLAB array like MAT_fuel_BURNUP = [ values ]; """
    m = RE_BURNUP.search(text)
    if m:
        values_str = m.group(1)
        nums = re.findall(r'[+-]?[0-9]*\.?[0-9]+(?:[Ee][+-]?\d+)?', values_str)
        return [float(x) for x in nums]
    return []

def extract_from_dep(path: Path) -> Tuple[Dict[str, List[float]], Dict[str, List[float]], List[float]]:
    """Extract MAT_fuel_MDENS, MAT_fuel_ADENS, and MAT_fuel_BURNUP from _dep.m file"""
    text = path.read_text(encoding='utf-8', errors='ignore').splitlines()
    full_text = '\n'.join(text)
    names = parse_names(text)
    
    # Extract burnup values
    burnup_vals = parse_matlab_array_simple(full_text, 'MAT_fuel_BURNUP')
    
    # Extract MDENS
    mdens_start = None
    for i, ln in enumerate(text):
        if RE_MDENS_BLOCK.search(ln):
            mdens_start = i
            break
    mdens_map: Dict[str, List[float]] = {}
    if mdens_start is not None:
        mdens_block = parse_mat_block(text, mdens_start)
        mdens_rows = parse_mdens_rows(mdens_block)
        comment_names_md = extract_comment_names(mdens_block)
        mapping_names = comment_names_md if len(comment_names_md) == len(mdens_rows) else names[:len(mdens_rows)]
        for nm, row in zip(mapping_names, mdens_rows):
            nm = nm.replace("\n", '').strip()
            mdens_map[nm] = row
    
    # Extract ADENS
    adens_start = None
    for i, ln in enumerate(text):
        if RE_ADENS_BLOCK.search(ln):
            adens_start = i
            break
    adens_map: Dict[str, List[float]] = {}
    if adens_start is not None:
        adens_block = parse_mat_block(text, adens_start)
        adens_rows = parse_mdens_rows(adens_block)
        comment_names_ad = extract_comment_names(adens_block)
        mapping_names = comment_names_ad if len(comment_names_ad) == len(adens_rows) else names[:len(adens_rows)]
        for nm, row in zip(mapping_names, adens_rows):
            nm = nm.replace("\n", '').strip()
            adens_map[nm] = row
    
    return mdens_map, adens_map, burnup_vals

def extract_comment_names(block_lines: List[str]) -> List[str]:
    """Extract isotope names from MATLAB comments in the data block"""
    comment_names = []
    for ln in block_lines:
        if '%' in ln:
            tail = ln.split('%')[-1].strip()
            if tail:
                comment_names.append(tail)
    return comment_names

def extract_conv_and_rates_from_res(path: Path) -> Tuple[List[float], List[float], Dict[str, List[float]]]:
    """Extract CONVERSION_RATIO, ANA_KEFF, and reaction rates from .sss_res.m file"""
    text = path.read_text(encoding='utf-8', errors='ignore')
    
    # Extract CONVERSION_RATIO values
    conv_vals = [float(m.group(1)) for m in RE_CONV.finditer(text)]
    # dedupe preserving order with tolerance
    unique_conv = []
    for v in conv_vals:
        if not unique_conv or abs(unique_conv[-1] - v) > 1e-12:
            unique_conv.append(v)
    unique_conv = unique_conv[:26]

    # Extract ANA_KEFF values
    ana_vals = [float(m.group(1)) for m in RE_ANA_KEFF.finditer(text)]
    unique_ana = []
    for v in ana_vals:
        if not unique_ana or abs(unique_ana[-1] - v) > 1e-12:
            unique_ana.append(v)
    unique_ana = unique_ana[:26]
    
    # Extract reaction rates
    rates: Dict[str, List[float]] = {}
    for match in RE_RATE.finditer(text):
        name = match.group(1)
        value = float(match.group(2))
        if name not in rates:
            rates[name] = []
        rates[name].append(value)
    
    # Keep at most 26 values for each rate
    for name in rates:
        rates[name] = rates[name][:26]
    
    return unique_conv, unique_ana, rates

def walk_and_extract():
    """Walk through all data folders and extract data"""
    rows = []  # list of dicts for each BURN_STEP

    # Load cases metadata (if available) so we can include it in the CSV
    cases_file = DATA_RAW / 'cases.csv'
    cases_map: Dict[str, Dict[str, str]] = {}
    if cases_file.exists():
        with cases_file.open(encoding='utf-8', newline='') as cf:
            reader = csv.DictReader(cf)
            for r in reader:
                cid = r.get('case_id') or r.get('case')
                if cid:
                    cases_map[cid] = r
    
    for folder in sorted(DATA_RAW.iterdir()):
        if not folder.is_dir():
            continue
        case = folder.name
        dep_file = folder / f"{case}.sss_dep.m"
        res_file = folder / f"{case}.sss_res.m"
        
        mdens_map: Dict[str, List[float]] = {}
        adens_map: Dict[str, List[float]] = {}
        burnup_vals: List[float] = []
        conv_vals: List[float] = []
        ana_keff_vals: List[float] = []
        rates_map: Dict[str, List[float]] = {}
        
        if dep_file.exists():
            mdens_map, adens_map, burnup_vals = extract_from_dep(dep_file)
        
        if res_file.exists():
            conv_vals, ana_keff_vals, rates_map = extract_conv_and_rates_from_res(res_file)
        
        # Ensure all lists are same length (26 values max)
        n_steps = max(len(burnup_vals),
                     len(conv_vals),
                     len(ana_keff_vals),
                     max((len(mdens_map.get(iso, [])) for iso in TARGET_ISOTOPES), default=0),
                     max((len(rates_map.get(rate, [])) for rate in FISS_RATES + CAPT_RATES), default=0))
        n_steps = min(n_steps, 26)
        
        # Pad all lists to n_steps if needed
        if len(burnup_vals) < n_steps:
            burnup_vals.extend([None] * (n_steps - len(burnup_vals)))
        
        if len(conv_vals) < n_steps:
            conv_vals.extend([None] * (n_steps - len(conv_vals)))

        if len(ana_keff_vals) < n_steps:
            ana_keff_vals.extend([None] * (n_steps - len(ana_keff_vals)))
        
        for iso in TARGET_ISOTOPES:
            # Pad MDENS
            mdens_series = find_isotope_series(mdens_map, iso)
            if mdens_series is None:
                mdens_map[iso] = [None] * n_steps
            else:
                if len(mdens_series) < n_steps:
                    mdens_series.extend([None] * (n_steps - len(mdens_series)))
                mdens_map[iso] = mdens_series

            # Pad ADENS
            adens_series = find_isotope_series(adens_map, iso)
            if adens_series is None:
                adens_map[iso] = [None] * n_steps
            else:
                if len(adens_series) < n_steps:
                    adens_series.extend([None] * (n_steps - len(adens_series)))
                adens_map[iso] = adens_series
        
        for rate in FISS_RATES + CAPT_RATES:
            if rate not in rates_map:
                rates_map[rate] = [None] * n_steps
            elif len(rates_map[rate]) < n_steps:
                rates_map[rate].extend([None] * (n_steps - len(rates_map[rate])))
        
        # Create rows for each burn step
        for step in range(n_steps):
            keff = ana_keff_vals[step] if step < len(ana_keff_vals) else None
            # Calculate reactivity: rho (pcm) = (keff - 1) / keff * 1e5
            reactivity = ((keff - 1) / keff * 1e5) if keff and keff != 0 else None
            burnup_mwd_kg_hm = burnup_vals[step] if step < len(burnup_vals) else None
            row = {
                'BURN_STEP': step,
                'case': case,
                'burnup_MWd_kgHM': burnup_mwd_kg_hm,
                'EFPD': burnup_to_efpd(burnup_mwd_kg_hm),
                'ANA_KEFF': keff,
                'reactivity_pcm': reactivity,
                'conversion_ratio': conv_vals[step] if step < len(conv_vals) else None,
            }
            # Merge case-level metadata from cases.csv (if present)
            meta = cases_map.get(case)
            if meta:
                # Keep the same column names as in cases.csv (except case_id)
                for key in ('layout_base', 'Th_level', 'Pu_level', 'U235_enrichment', 'U233_enrichment'):
                    row[key] = meta.get(key)
            else:
                for key in ('layout_base', 'Th_level', 'Pu_level', 'U235_enrichment', 'U233_enrichment'):
                    row[key] = None
            # Add MDENS columns (mass density, g/cm3)
            for iso in TARGET_ISOTOPES:
                col_name = f'Mdens_{iso}'
                if iso in mdens_map and step < len(mdens_map[iso]):
                    row[col_name] = mdens_map[iso][step]
                else:
                    row[col_name] = None
            # Add ADENS columns (atomic density, atoms/barn/cm)
            for iso in TARGET_ISOTOPES:
                col_name = f'Adens_{iso}'
                if iso in adens_map and step < len(adens_map[iso]):
                    row[col_name] = adens_map[iso][step]
                else:
                    row[col_name] = None
            # Add FISS rate columns
            for rate in FISS_RATES:
                if rate in rates_map and step < len(rates_map[rate]):
                    row[rate] = rates_map[rate][step]
                else:
                    row[rate] = None
            # Add CAPT rate columns
            for rate in CAPT_RATES:
                if rate in rates_map and step < len(rates_map[rate]):
                    row[rate] = rates_map[rate][step]
                else:
                    row[rate] = None
            rows.append(row)
    
    # Write output CSV
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    # Only include the specific columns requested by the user, in this order.
    fieldnames = [
        'BURN_STEP','case','layout_base','Th_level','Pu_level','U235_enrichment','U233_enrichment',
        'burnup_MWd_kgHM','EFPD','ANA_KEFF','reactivity_pcm','conversion_ratio'
    ]
    # Mdens (mass densities)
    fieldnames += [f'Mdens_{iso}' for iso in TARGET_ISOTOPES]
    # Adens (atomic densities)
    fieldnames += [f'Adens_{iso}' for iso in TARGET_ISOTOPES]
    # Mass (kg)
    fieldnames += [f'Mass_{iso}_kg' for iso in TARGET_ISOTOPES]
    # Fission and capture reaction rates
    fieldnames += FISS_RATES
    fieldnames += CAPT_RATES
    
    # Unit comment mapping
    units = {
        'BURN_STEP': 'step (dimensionless)',
        'case': 'case label',
        'burnup_MWd_kgHM': 'MWd/kgHM',
        'EFPD': 'day',
        'ANA_KEFF': 'dimensionless',
        'reactivity_pcm': 'pcm',
        'conversion_ratio': 'dimensionless',
        'layout_base': 'layout',
        'Th_level': 'fraction',
        'Pu_level': 'fraction',
        'U235_enrichment': 'fraction',
        'U233_enrichment': 'fraction'
    }
    units.update({f'Mdens_{iso}': 'g/cm3' for iso in TARGET_ISOTOPES})
    units.update({f'Adens_{iso}': 'atoms/barn/cm' for iso in TARGET_ISOTOPES})
    units.update({f'Mass_{iso}_kg': 'kg' for iso in TARGET_ISOTOPES})
    units.update({rate: '1/s' for rate in FISS_RATES + CAPT_RATES})
    
    with OUT_CSV.open('w', newline='', encoding='utf-8') as f:
        # Write unit header as first line comment
        unit_comment = '# ' + ' | '.join([f'{col}: {units.get(col, "")}' for col in fieldnames])
        f.write(unit_comment + '\n')
        
        # Before writing, compute absolute masses from Mdens (g/cm3)
        # assembly fuel volume (cm3)
        assembly_fuel_volume_cm3 = FUEL_RODS * math.pi * (FUEL_R_CM ** 2) * ACTIVE_HEIGHT_CM

        for r in rows:
            for iso in TARGET_ISOTOPES:
                key = f'Mdens_{iso}'
                mass_key = f'Mass_{iso}_kg'
                try:
                    mdens = r.get(key, None)
                    if mdens is None or mdens == '':
                        r[mass_key] = ''
                    else:
                        # mdens in g/cm3 -> grams = mdens * volume_cm3
                        grams = float(mdens) * assembly_fuel_volume_cm3
                        r[mass_key] = grams / 1000.0
                except Exception:
                    r[mass_key] = ''

        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)
    
    print(f"Wrote {OUT_CSV} with {len(rows)} rows and {len(fieldnames)} columns")


def populate_data_lake(raw_data_dir: Path, db_path: Optional[Path] = None):
    """
    Populate the SQLite Data Lake with extracted data.
    
    This function extracts data from raw Serpent output files and stores
    them in a SQLite database optimized for AI agent queries.
    
    Args:
        raw_data_dir: Path to raw data directories
        db_path: Optional path for SQLite database
    """
    if not HAS_DATALAYER:
        print("Data layer not available. Skipping Data Lake population.")
        return
    
    print("=" * 60)
    print("Populating SQLite Data Lake")
    print("=" * 60)
    
    # Initialize data lake
    dl = DataLake(db_path=db_path)
    
    total_cases = 0
    for folder in sorted(raw_data_dir.iterdir()):
        if not folder.is_dir():
            continue
        
        case_id = folder.name
        if not case_id[0] in 'ABCD' or len(case_id) != 4:
            continue
        
        print(f"Processing {case_id}...", end=" ")
        sys.stdout.flush()
        
        # Extract data using existing functions
        dep_file = folder / f"{case_id}.sss_dep.m"
        res_file = folder / f"{case_id}.sss_res.m"
        
        mdens_map, adens_map, burnup_vals = {}, {}, []
        conv_vals, ana_keff_vals, rates_map = [], [], {}
        
        if dep_file.exists():
            mdens_map, adens_map, burnup_vals = extract_from_dep(dep_file)
        
        if res_file.exists():
            conv_vals, ana_keff_vals, rates_map = extract_conv_and_rates_from_res(res_file)
        
        # Build steps data
        n_steps = min(len(burnup_vals), 26)
        steps_data = []
        
        for step in range(n_steps):
            keff = ana_keff_vals[step] if step < len(ana_keff_vals) else None
            reactivity = ((keff - 1) / keff * 1e5) if keff and keff != 0 else None
            burnup = burnup_vals[step] if step < len(burnup_vals) else None
            cr = conv_vals[step] if step < len(conv_vals) else None
            
            # Calculate FIR
            fissile_mass = sum(
                find_isotope_series(mdens_map, iso)[step] if 
                find_isotope_series(mdens_map, iso) and step < len(find_isotope_series(mdens_map, iso))
                else 0
                for iso in FISSILE_ISOTOPES
            )
            fissile_initial = sum(
                find_isotope_series(mdens_map, iso)[0] if 
                find_isotope_series(mdens_map, iso) and len(find_isotope_series(mdens_map, iso)) > 0
                else 0
                for iso in FISSILE_ISOTOPES
            )
            fir = fissile_mass / fissile_initial if fissile_initial != 0 else None
            
            step_data = {
                'step': step,
                'burnup': burnup,
                'keff': keff,
                'reactivity_pcm': reactivity,
                'conversion_ratio': cr,
                'fir': fir
            }
            
            # Add isotope mass densities
            for iso in TARGET_ISOTOPES:
                vals = find_isotope_series(mdens_map, iso)
                if vals and step < len(vals):
                    step_data[f'Mdens_{iso}'] = vals[step]
            
            # Add isotope atomic densities
            for iso in TARGET_ISOTOPES:
                vals = find_isotope_series(adens_map, iso)
                if vals and step < len(vals):
                    step_data[f'Adens_{iso}'] = vals[step]
            
            # Add reaction rates
            for rate in FISS_RATES + CAPT_RATES:
                if rate in rates_map and step < len(rates_map[rate]):
                    step_data[rate] = rates_map[rate][step]
            
            steps_data.append(step_data)
        
        # Calculate case summary
        keff_0 = ana_keff_vals[0] if ana_keff_vals else None
        keff_f = ana_keff_vals[-1] if ana_keff_vals else None
        cr_0 = conv_vals[0] if conv_vals else None
        cr_f = conv_vals[-1] if conv_vals else None
        
        # Calculate FIR_0 and FIR_final
        fissile_initial = sum(
            find_isotope_series(mdens_map, iso)[0] if 
            find_isotope_series(mdens_map, iso) and len(find_isotope_series(mdens_map, iso)) > 0
            else 0
            for iso in FISSILE_ISOTOPES
        )
        fissile_final = sum(
            find_isotope_series(mdens_map, iso)[-1] if 
            find_isotope_series(mdens_map, iso) and len(find_isotope_series(mdens_map, iso)) > 0
            else 0
            for iso in FISSILE_ISOTOPES
        )
        fir_0 = 1.0 if fissile_initial != 0 else None
        fir_f = fissile_final / fissile_initial if fissile_initial != 0 else None
        
        # Calculate directory size
        file_size = sum(f.stat().st_size for f in folder.glob('*') if f.is_file())
        
        summary = CaseSummary(
            case_id=case_id,
            group_letter=case_id[0],
            keff_0=keff_0,
            keff_final=keff_f,
            cr_0=cr_0,
            cr_final=cr_f,
            fir_0=fir_0,
            fir_final=fir_f,
            max_burnup=burnup_vals[-1] if burnup_vals else 0,
            n_steps=n_steps,
            file_size_mb=file_size / (1024 * 1024)
        )
        
        # Insert into data lake
        dl.insert_case(summary, steps_data)
        total_cases += 1
        print(f"[OK] (keff={keff_0:.3f}, CR={cr_0:.3f})")
    
    print(f"\n{'=' * 60}")
    print(f"Data Lake populated with {total_cases} cases")
    print(f"Database location: {dl.db_path}")
    print(f"Database size: {dl.db_path.stat().st_size / (1024*1024):.2f} MB")
    print(f"{'=' * 60}")


def parse_detector_flux(path: Path) -> Dict[str, float]:
    """
    Parse SERPENT detector flux file (.sss_detN.m) and extract energy-group fluxes.
    
    Returns dict with energy group keys ('G1' to 'G7') mapped to mean flux values
    per energy group across all detector points.
    """
    text = path.read_text(encoding='utf-8', errors='ignore')

    # Prefer the 7-group spectrum block when both 2g and 7g exist in the same file.
    target_label = None
    for candidate in ('DETflux_7g', 'DETflux_2g'):
        if re.search(rf'{candidate}\s*=\s*\[', text, re.I):
            target_label = candidate
            break

    if target_label is None:
        return {}

    match = re.search(rf'{target_label}\s*=\s*\[(.*?)\];', text, re.S | re.I)
    if not match:
        return {}

    block_text = match.group(1)
    lines = block_text.splitlines()

    n_groups = 7 if target_label.lower().endswith('7g') else 2
    
    # Parse data rows: format varies by group count
    # For 7g: index, e_group, ..., flux, rel_err
    # Columns: idx, e_group, many_id_cols..., flux, rel_err
    fluxes_by_group: Dict[int, List[float]] = {g: [] for g in range(1, n_groups + 1)}
    
    for line in lines:
        line = line.strip()
        if not line or line.startswith('%') or line.startswith('#'):
            continue
        
        parts = line.split()
        if len(parts) < 3:
            continue
        
        try:
            # Try to parse as float array
            nums = [float(x) for x in parts]
            if len(nums) < 3:
                continue
            
            # Determine structure based on n_groups
            # Column format: idx, e_group, ...other_ids..., flux, rel_err
            # For 7g: nums[1]=group, nums[10]=flux, nums[11]=energy
            # For 2g: nums[1]=group, nums[10]=flux
            if n_groups == 7 and len(nums) >= 11:
                # 7-group structure: nums[1] = energy group (1-7), nums[10] = flux
                e_group = int(nums[1])
                flux = nums[10]
            elif n_groups == 2 and len(nums) >= 11:
                # 2-group structure: nums[1] = energy group, nums[10] = flux
                e_group = int(nums[1])
                flux = nums[10]
            elif len(nums) >= 11:
                # Generic multi-group - assume same format
                e_group = int(nums[1])
                flux = nums[10]
            else:
                continue
            
            if 1 <= e_group <= n_groups:
                fluxes_by_group[e_group].append(flux)
        except (ValueError, IndexError):
            continue
    
# Calculate mean flux per energy group
    result: Dict[str, float] = {}
    for g, fluxes in fluxes_by_group.items():
        key = f'G{g}'
        if fluxes:
            result[key] = sum(fluxes) / len(fluxes)  # Mean flux for this group (scalar)
        else:
            result[key] = 0.0
    
    return result


def parse_detector_flux_sum(path: Path) -> Dict[str, float]:
    """
    Parse SERPENT detector flux file (.sss_detN.m) and sum fluxes by energy group.

    Returns dict with energy group keys ('G1' to 'G7') mapped to summed flux values
    across all detector points for each group.
    """
    text = path.read_text(encoding='utf-8', errors='ignore')

    # Require 7-group spectrum for this export.
    match = re.search(r'DETflux_7g\s*=\s*\[(.*?)\];', text, re.S | re.I)
    if not match:
        return {}

    block_text = match.group(1)
    lines = block_text.splitlines()

    n_groups = 7
    sums_by_group: Dict[int, float] = {g: 0.0 for g in range(1, n_groups + 1)}

    for line in lines:
        line = line.strip()
        if not line or line.startswith('%') or line.startswith('#'):
            continue

        parts = line.split()
        if len(parts) < 11:
            continue

        try:
            nums = [float(x) for x in parts]
            if len(nums) < 11:
                continue

            e_group = int(nums[1])
            flux = nums[10]
            if 1 <= e_group <= n_groups:
                sums_by_group[e_group] += flux
        except (ValueError, IndexError):
            continue

    result: Dict[str, float] = {}
    for g in range(1, n_groups + 1):
        result[f'G{g}'] = sums_by_group[g]
    return result


def extract_spectra_for_case_and_detector(case_dir: Path, det_index: int) -> Optional[Dict[str, float]]:
    """
    Extract summed 7-group spectrum for a specific detector index in a case.

    Returns:
        Dict with energy group keys ('G1'-'G7') and summed flux values,
        or None if corresponding detector file / 7-group block is not found.
    """
    case = case_dir.name
    possible_names = [
        f"{case}.sss_det{det_index}.m",
        f"{case}.sss_det{det_index} copy.m",
    ]

    for fname in possible_names:
        det_file = case_dir / fname
        if det_file.exists():
            summed = parse_detector_flux_sum(det_file)
            if summed:
                return summed
    return None


def extract_detector_spectra_all_cases(raw_dir: Path, det_min: int = 0, det_max: int = 25) -> List[Dict]:
    """
    Extract summed 7-group spectra for each case and each detector index in [det_min, det_max].

    Each row corresponds to one (case, detector) pair with group sums over all fuel rods
    (all detector points in DETflux_7g block).
    """
    rows: List[Dict] = []

    for case_dir in sorted(raw_dir.iterdir()):
        if not case_dir.is_dir():
            continue
        case = case_dir.name
        if not case[0] in 'ABCD' or len(case) != 4:
            continue

        print(f"Summing detector spectra for {case}...", end=" ", flush=True)
        found_count = 0

        for det_index in range(det_min, det_max + 1):
            summed = extract_spectra_for_case_and_detector(case_dir, det_index)
            if not summed:
                continue

            row = {'case': case, 'detector': f'det{det_index}', **summed}
            rows.append(row)
            found_count += 1

        if found_count > 0:
            print(f"[OK] ({found_count} detectors)")
        else:
            print("[FAIL] (no det0-det25 7-group detector found)")

    return rows


def write_detector_spectra_csv(detector_rows: List[Dict], out_path: Path):
    """Write per-case per-detector summed 7-group spectra to CSV."""
    if not detector_rows:
        print("No detector spectra data to write")
        return

    fieldnames = ['case', 'detector'] + [f'G{i}' for i in range(1, 8)]

    with out_path.open('w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(detector_rows)

    print(f"Wrote detector spectra to {out_path}")

def extract_spectra_for_case(case_dir: Path, det_index: int = 1) -> Optional[Dict[str, float]]:
    """
    Extract neutron spectrum for a specific detector index in a case.
    
    Args:
        case_dir: Path to case directory (e.g., data_raw/A001)
        det_index: Detector index to extract (default: 1 for 7-group spectrum)
    
    Returns:
        Dict with energy group keys ('G1'-'G7') and flux values, or None if not found
    """
    case = case_dir.name
    
    # Try different file naming patterns
    possible_names = [
        f"{case}.sss_det{det_index}.m",
        f"{case}.sss_det{det_index} copy.m",  # Some files have 'copy' suffix
    ]
    
    for fname in possible_names:
        det_file = case_dir / fname
        if det_file.exists():
            return parse_detector_flux(det_file)
    
    return None

# Generic spectra CSV writer removed; keep per-detector CSV writer `write_detector_spectra_csv`.


# Plot generation removed to simplify script and avoid plotting dependencies.


if __name__ == '__main__':
    import argparse
    
    parser = argparse.ArgumentParser(
        description='Extract Serpent simulation data to CSV and/or SQLite Data Lake'
    )
    parser.add_argument('--csv', action='store_true', default=True,
                       help='Export to CSV (default: True)')
    parser.add_argument('--sqlite', action='store_true', default=True,
                       help='Populate SQLite Data Lake (default: True)')
    parser.add_argument('--raw-dir', type=Path, 
                       default=Path(__file__).parent.parent / 'data_raw' / 'V1',
                       help='Raw data directory')
    
    args = parser.parse_args()
    
    if args.csv:
        print("Extracting data to CSV...")
        walk_and_extract()
    
    if args.sqlite and HAS_DATALAYER:
        populate_data_lake(args.raw_dir)
    elif args.sqlite:
        print("SQLite Data Lake not available (data_layer.py not found)")
    
    # NOTE: 绘图相关逻辑已禁用；脚本只导出 CSV 输出（data.csv 与 detector_spectra.csv）。
    # 导出 per-case per-detector 的 7-group 汇总谱（det0-det25）到 detector_spectra.csv
    print("\nExporting detector_spectra.csv (det0-det25, 7-group sums)...")
    detector_rows = extract_detector_spectra_all_cases(args.raw_dir, det_min=0, det_max=25)
    detector_csv = OUT_DIR / "detector_spectra.csv"
    write_detector_spectra_csv(detector_rows, detector_csv)

    print("\nSpectra extraction complete. Output: {}".format(detector_csv))
