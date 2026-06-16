#!/usr/bin/env python3
"""Extract 70-group detector data + Keff/CR from the spectrum-scan cases.

File format discovered from A008 (data_raw/V1/A008):
  - One .sss_det<N>.m file per burnup step (det0 = BOL, det1..detN = steps)
  - Each file contains ALL detectors for that burnup step
  - Detector blocks look like:  DET<name> = [ <rows> ];
  - Each row has 12 columns:  idx, group, other_ids..., value, rel_err
    - col 1 (0-indexed) is the group index (1..n_groups)
    - col 10 is the detector value (flux, reaction rate, ...)
    - col 11 is the relative statistical error
  - For each group there are ~290 rows (one per active cycle); we take the
    MEAN across cycles, matching the convention used by extract_data.py.

Outputs (under data_processed/spectrum_scan/):
  1. spectrum_70g_long.csv  - long format, one row per (case, burnup_step,
                              detector, group)
  2. keff_cr_evolution.csv  - one row per (case, burnup_step)
  3. cases_meta.csv         - one row per case

Run from the results/ directory:
    python script/spectrum_scan/extract_spectrum_scan.py
"""

from __future__ import annotations

import re
import sys
from pathlib import Path
from typing import Optional

import numpy as np
import pandas as pd

_HERE = Path(__file__).resolve().parent
if str(_HERE) not in sys.path:
    sys.path.insert(0, str(_HERE))

from shem70 import (  # noqa: E402
    SHEM70_ENERGIES_EV,
    REGION_LABELS,
)

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
SCRIPT_DIR = Path(__file__).resolve().parent
RESULTS_DIR = SCRIPT_DIR.parent.parent
DATA_RAW = RESULTS_DIR / "data_raw" / "spectrum_scan"
OUT_DIR = RESULTS_DIR / "data_processed" / "spectrum_scan"
OUT_DIR.mkdir(parents=True, exist_ok=True)

# Detectors we expect in the .sss input (matches generate_inputs.py)
EXPECTED_DETECTORS = [
    "flux_70g",
    "u235_fiss_70g",
    "u233_fiss_70g",
    "u238_cap_70g",
    "pu239_fiss_70g",
    "th232_cap_70g",
    "pa233_cap_70g",
]

# Keff/CR regex (same shape as extract_data.py uses)
RE_ANA_KEFF = re.compile(
    r"ANA_KEFF\s*\(idx[\s\S]*?\)\s*=\s*\[\s*([0-9Ee+\-\.]+)\s+([0-9Ee+\-\.]+)\s*\]"
)
RE_CONV = re.compile(
    r"CONVERSION_RATIO\s*\(idx[\s\S]*?\)\s*=\s*\[\s*([0-9Ee+\-\.]+)\s+([0-9Ee+\-\.]+)\s*\];"
)
RE_BURNUP = re.compile(r"MAT_fuel_BURNUP\s*=\s*\[([^\]]+)\];", re.I)

# Serpent output power density from the .sss deck
POWER_DENSITY_MW_PER_KGHM = 3.8e-2

# Number of energy groups in the SHEM-70 structure
N_GROUPS = len(SHEM70_ENERGIES_EV) - 1


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
def water_density_from_case_id(case_id: str) -> float:
    """e.g. A008_d076 -> 0.76513, A008_d070 -> 0.70, A008_d040 -> 0.40."""
    suffix = case_id.split("_d", 1)[1]
    if suffix == "076":
        return 0.76513
    return float(suffix) / 100.0


def list_case_dirs() -> list[Path]:
    if not DATA_RAW.exists():
        return []
    return sorted([p for p in DATA_RAW.iterdir() if p.is_dir()])


def parse_detector_block(block_text: str, n_groups: int) -> dict[int, tuple[float, float, int]]:
    """Parse a DET<name> = [ ... ]; block.

    Returns:  { group_idx (1-based) : (mean_value, mean_rel_err, n_cycles) }
    Empty dict if the block contains no usable rows.
    """
    sums: dict[int, float] = {}
    err_sums: dict[int, float] = {}
    counts: dict[int, int] = {}

    for line in block_text.splitlines():
        line = line.strip()
        if not line or line.startswith("%") or line.startswith("#"):
            continue
        parts = line.split()
        if len(parts) < 12:
            continue
        try:
            # col 1 = group index, col 10 = value, col 11 = rel error
            group = int(parts[1])
            val = float(parts[10])
            err = float(parts[11])
        except (ValueError, IndexError):
            continue
        if not (1 <= group <= n_groups):
            continue
        sums[group] = sums.get(group, 0.0) + val
        err_sums[group] = err_sums.get(group, 0.0) + err
        counts[group] = counts.get(group, 0) + 1

    out: dict[int, tuple[float, float, int]] = {}
    for g, s in sums.items():
        n = counts[g]
        out[g] = (s / n, err_sums[g] / n, n)
    return out


def extract_case_detectors(case_dir: Path) -> pd.DataFrame:
    """Long-format DataFrame for one case.

    Reads all <case>.sss_det<N>.m files in the directory, parses each
    DET<name>_70g block, and emits one row per (burnup_step, detector, group).
    """
    case = case_dir.name
    density = water_density_from_case_id(case)
    det_files = sorted(case_dir.glob(f"{case}.sss_det*.m"))
    # Filter out the SSS_res / _dep .m files (they don't have det prefix)
    det_files = [p for p in det_files if re.search(r"det\d+\.m$", p.name)]
    # If a 'copy' duplicate exists, drop the copy
    det_files = [p for p in det_files if "copy" not in p.name]

    rows: list[dict] = []
    for det_file in det_files:
        m = re.search(r"det(\d+)\.m$", det_file.name)
        if not m:
            continue
        bstep = int(m.group(1))
        text = det_file.read_text(encoding="utf-8", errors="ignore")

        for det_name in EXPECTED_DETECTORS:
            block_re = re.compile(
                rf"DET{re.escape(det_name)}\s*=\s*\[(.*?)\];",
                re.S | re.I,
            )
            mb = block_re.search(text)
            if not mb:
                continue
            parsed = parse_detector_block(mb.group(1), N_GROUPS)
            for g, (val, err, n_cyc) in parsed.items():
                rows.append({
                    "case": case,
                    "water_density": density,
                    "burnup_step": bstep,
                    "detector": det_name,
                    "group": g,
                    "energy_lo_eV": SHEM70_ENERGIES_EV[g - 1],
                    "energy_hi_eV": SHEM70_ENERGIES_EV[g],
                    "region": REGION_LABELS[g - 1],
                    "value": val,
                    "relative_error": err,
                    "n_cycles": n_cyc,
                })
    return pd.DataFrame(rows)


def extract_case_keff_cr(case_dir: Path) -> pd.DataFrame:
    """Read .sss_res.m and .sss_dep.m -> DataFrame indexed by burnup step."""
    case = case_dir.name
    density = water_density_from_case_id(case)
    res_file = case_dir / f"{case}.sss_res.m"
    dep_file = case_dir / f"{case}.sss_dep.m"

    keff_vals: list[float] = []
    conv_vals: list[float] = []
    if res_file.exists():
        text = res_file.read_text(encoding="utf-8", errors="ignore")
        keff_vals = [float(m.group(1)) for m in RE_ANA_KEFF.finditer(text)]
        conv_vals = [float(m.group(1)) for m in RE_CONV.finditer(text)]

    burnup_vals: list[float] = []
    if dep_file.exists():
        text = dep_file.read_text(encoding="utf-8", errors="ignore")
        m = RE_BURNUP.search(text)
        if m:
            burnup_vals = [float(x) for x in re.findall(
                r"[+-]?[0-9]*\.?[0-9]+(?:[Ee][+-]?\d+)?", m.group(1)
            )]

    n_steps = max(len(keff_vals), len(conv_vals), len(burnup_vals), 1)
    rows: list[dict] = []
    for i in range(n_steps):
        bu = burnup_vals[i] if i < len(burnup_vals) else None
        keff = keff_vals[i] if i < len(keff_vals) else None
        cr = conv_vals[i] if i < len(conv_vals) else None
        rows.append({
            "case": case,
            "water_density": density,
            "burnup_step": i,
            "burnup_MWd_kgHM": bu,
            "EFPD": bu / POWER_DENSITY_MW_PER_KGHM if bu is not None else None,
            "ANA_KEFF": keff,
            "reactivity_pcm": ((keff - 1.0) / keff * 1e5) if (keff and keff != 0) else None,
            "conversion_ratio": cr,
        })
    return pd.DataFrame(rows)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
def main() -> None:
    case_dirs = list_case_dirs()
    if not case_dirs:
        print(f"[WARN] No case directories under {DATA_RAW}. "
              "Run generate_inputs.py first, then run Serpent on Linux, then re-run.")
        return

    # Case metadata
    meta_rows = []
    for d in case_dirs:
        case = d.name
        n_det = len([p for p in d.glob(f"{case}.sss_det*.m")
                     if re.search(r"det\d+\.m$", p.name)])
        meta_rows.append({
            "case": case,
            "water_density_g_cm3": water_density_from_case_id(case),
            "n_burnup_steps": n_det,
        })
    meta_df = pd.DataFrame(meta_rows)
    meta_df.to_csv(OUT_DIR / "cases_meta.csv", index=False)
    print(f"[OK] cases_meta.csv -> {len(meta_df)} cases")

    # Keff / CR
    keff_frames = [extract_case_keff_cr(d) for d in case_dirs]
    keff_df = pd.concat(keff_frames, ignore_index=True)
    keff_df.to_csv(OUT_DIR / "keff_cr_evolution.csv", index=False)
    print(f"[OK] keff_cr_evolution.csv -> {len(keff_df)} rows")

    # Long-format detector data
    det_frames = [extract_case_detectors(d) for d in case_dirs]
    det_df = pd.concat(det_frames, ignore_index=True)
    if det_df.empty:
        print("[WARN] No detector rows extracted. "
              "Confirm the .sss_det*.m files contain DET<name>_70g blocks "
              "(requires Serpent to have run successfully on Linux).")
    else:
        det_df.to_csv(OUT_DIR / "spectrum_70g_long.csv", index=False)
        print(f"[OK] spectrum_70g_long.csv -> {len(det_df)} rows "
              f"({det_df.case.nunique()} cases x {det_df.burnup_step.nunique()} steps x "
              f"{det_df.detector.nunique()} detectors x {det_df.group.nunique()} groups)")


if __name__ == "__main__":
    main()
