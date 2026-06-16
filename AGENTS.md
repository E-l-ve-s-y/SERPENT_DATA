# Serpent Data Analysis Navigator

## Quick Start

Run everything from `results/` with the system Python.

```powershell
cd results
python script/extract_data.py
python script/analyze_data.py
```

## Project Structure

```
serpent_data/
├── results/
│   ├── data_raw/           # Raw SERPENT output files
│   │   └── V1/             # Version 1: A001-D027 case folders + cases.csv
│   ├── data_processed/     # Extracted CSV, SQLite DB, detector spectra
│   │   └── V1/             # Version 1: data.csv, data_lake.db, detector_spectra.csv
│   ├── analysis/           # Plots output by analysis scripts
│   │   └── V1/             # Version 1: all analysis subfolders (CR, KEFF, etc.)
│   └── script/             # All Python scripts
│       ├── extract_data.py
│       ├── analyze_data.py
│       ├── plot_CR_evolution.py
│       ├── plot_neutron_spectra.py
│       └── agent/          # AI agent layer
│           ├── data_layer.py
│           ├── cache_layer.py
│           ├── agents.py
│           └── orchestrator.py
```

## Entry Points

| Script | Purpose | Output |
|--------|---------|--------|
| `script/extract_data.py` | Parse `.sss_dep.m`, `.sss_res.m`, detector files | `data_processed/data.csv`, `data_lake.db`, `detector_spectra.csv` |
| `script/analyze_data.py` | Generate per-case plots (keff/FIR/CR, mass evolution) | `analysis/plots/{case}/` |
| `script/plot_CR_evolution.py` | CR group analysis | `analysis/CR/` |
| `script/plot_neutron_spectra.py` | Neutron spectrum plots from detector data | `analysis/Neutron_spectra/` |

## Critical Working Directory Rule

**All scripts must run from `results/` directory.** Relative imports like `from agent.data_layer import ...` will fail if run from elsewhere.

```powershell
cd results  # Must be here
python script/extract_data.py
```

## Case ID Conventions

- Format: `{Group}{Number}` where Group ∈ {A, B, C, D}, Number ∈ {001-027}
- Examples: A001, B012, D027
- Filter by group: `dl.filter_cases(groups=['A', 'B'])`

## Data File Conventions

### CSV Files
- Header row: Leading `#` comment with column units (e.g., `# BURN_STEP: step | case: case label | ...`)
- Read with: `pd.read_csv(path, comment='#')`

### MATLAB Output Files (.m)
- Read with: `encoding='utf-8', errors='ignore'`
- Key blocks: `MAT_fuel_MDENS`, `MAT_fuel_ADENS`, `MAT_fuel_BURNUP`, `CONVERSION_RATIO`, `ANA_KEFF`

### SQLite Data Lake
- Path: `results/data_processed/data_lake.db`
- Tables: `cases` (summary metadata), `burnup_steps` (time-series data)

## Important Column Names

| Column | Description |
|--------|-------------|
| `burnup_MWd_kgHM` | Burnup in MWd/kg heavy metal |
| `EFPD` | Effective Full Power Days |
| `ANA_KEFF` | k-effective (keff) |
| `reactivity_pcm` | Reactivity in pcm |
| `conversion_ratio` | Conversion Ratio (CR) |
| `Mdens_{Isotope}` | Mass density (g/cm³) |
| `Adens_{Isotope}` | Atomic density (atoms/barn/cm) |
| `Mass_{Isotope}_kg` | Absolute mass (kg) |
| `{Isotope}_FISS` | Fission rate (1/s) |
| `{Isotope}_CAPT` | Capture rate (1/s) |

## Target Isotopes

U233, U235, U238, Th232, Pa233, Pu239, Pu240, Pu241, Pu242, Am241, Am243, Sm149, Xe135

## Fissile Isotopes (for FIR)

U233, U235, Pu239, Pu241

## Output Conventions

- **Console**: One-line per case, e.g., `Processing D020, pictures have saved`
- **Logs**: Timestamped to `analysis/log/` (analyze_data.py, plot_CR_evolution.py)
- **Plots**: Per-case subdirectories under output root

## DataLayer API (for agents)

```python
from results.script.agent.data_layer import DataLake

dl = DataLake()  # Uses default path: results/data_processed/data_lake.db

# Query case summaries
summary = dl.get_case_summary("A001")
case_data = dl.get_case_data("A001")  # Returns DataFrame

# Filter cases
case_ids = dl.filter_cases(groups=['A', 'B'], keff_range=(1.0, 1.3))
stats = dl.get_group_statistics()
```

## Common Pitfalls

1. **Import errors**: Always run from `results/`, not workspace root
2. **Missing data_layer**: Located at `agent/data_layer.py`, not `data_layer.py` at script root
3. **CSV reading**: Must use `comment='#'` or comment lines appear as data
4. **.m file encoding**: Use `encoding='utf-8', errors='ignore'` - files may have mixed encoding
5. **Detector files**: May have spaces, `copy` suffix, or both (e.g., `A001.sss_det1 copy.m`)

## 7-Group Neutron Spectrum Energy Boundaries

| Group | Energy Range (eV) |
|-------|-------------------|
| G1 | 1e-11 - 4e-9 |
| G2 | 4e-9 - 1e-8 |
| G3 | 1e-8 - 1e-7 |
| G4 | 1e-7 - 6.25e-7 |
| G5 | 6.25e-7 - 9.06e-4 |
| G6 | 9.06e-4 - 3e-3 |
| G7 | 3e-3 - 20 |