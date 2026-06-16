"""
kaist_utils.py
==============

Utilities for reading KAIST MOX-Th Serpent results.

Data sources
------------
*_res.m       : keff, conversion ratio
*_dep.m       : global burnup (BU), isotope inventories
*_detN.m      : 70-group neutron spectra

Design choice
-------------
The entire project uses the global burnup axis (BU) defined in *_dep.m.
Material-specific MAT_xxx_BURNUP arrays are ignored.
"""

import re
from pathlib import Path
import numpy as np

# =============================================================================
# Paths
# =============================================================================
BASE_DIR = Path(r"C:\Users\lsy05\serpent_data\results\data_raw\MOX_Th_kaist\kaist")
OUTPUT_DIR = Path(r"C:\Users\lsy05\serpent_data\results\analysis\MOX_Th_kaist\kaist")

# =============================================================================
# Target isotopes
# =============================================================================
TARGET_ISOTOPES = [
    "Th232", "Pa233", "U233", "U234", "U235", "U236", "U237", "U238",
    "Np237", "Np239", "Pu238", "Pu239", "Pu240", "Pu241", "Pu242",
    "Am241", "Am243", "Xe135", "Sm149", "Cs137", "Nd143",
]

# =============================================================================
# Internal helpers
# =============================================================================
_NUMBER_RE = re.compile(r"[+-]?\d+\.?\d*(?:[Ee][+-]?\d+)?")

def _numbers(text):
    """Extract all floating-point numbers from text."""
    return [float(x) for x in _NUMBER_RE.findall(text)]

def _read_file(case, pattern, base_dir=BASE_DIR):
    """Return the content of the first file matching pattern in case directory."""
    matches = list((Path(base_dir) / case).glob(pattern))
    if not matches:
        raise FileNotFoundError(f"no {pattern} found in {case}")
    return matches[0].read_text(encoding="utf-8", errors="ignore")

def _extract_block(text, prefix, suffix=None):
    """
    Extract content of a block of the form: {prefix}[_{suffix}]? = [ ... ];
    Returns the block content as string, or None if not found.
    """
    name = prefix if prefix.startswith("MAT_") else f"MAT_{prefix}"
    if suffix:
        name = f"{name}_{suffix}"
    m = re.search(rf"{re.escape(name)}\s*=\s*\[(.*?)\]\s*;", text, re.S)
    return m.group(1) if m else None

def _read_first_values_per_block(text, var_name):
    """
    Extract first value from repeated Serpent blocks like:
        ANA_KEFF(idx,[1:6]) = [ first ... ]
    Returns array of unique consecutive values (removes duplicates).
    """
    pattern = re.compile(
        rf"^{re.escape(var_name)}\s*\(idx,\s*\[\d+:\s*\d+\]\)\s*=\s*\[\s*"
        r"(?P<first>[+-]?\d+\.?\d*(?:[Ee][+-]?\d+)?)",
        re.M
    )
    vals = [float(m.group("first")) for m in pattern.finditer(text)]
    if not vals:
        raise ValueError(f"{var_name} not found")
    # retain only first occurrence of each new value (preserve order)
    out = []
    for v in vals:
        if not out or out[-1] != v:
            out.append(v)
    return np.array(out)

# =============================================================================
# dep.m
# =============================================================================
def _read_dep_text(case):
    return _read_file(case, "*_dep.m")

def read_global_burnup(case):
    """Read the global burnup axis 'BU = [ ... ]' from *_dep.m."""
    text = _read_dep_text(case)
    m = re.search(r"^BU\s*=\s*\[(.*?)\]\s*;", text, re.S | re.M)
    if not m:
        raise ValueError(f"BU block not found in {case}")
    burnup = np.array(_numbers(m.group(1)))
    if burnup.size == 0:
        raise ValueError(f"empty BU block in {case}")
    return burnup

def list_materials(case):
    """Return material names (without MAT_ prefix) present in *_dep.m."""
    text = _read_dep_text(case)
    return sorted({
        m.group(1)
        for m in re.finditer(r"^MAT_([A-Za-z0-9_\-]+)_(?:BURNUP|ADENS|MDENS)\b", text, re.M)
    })

def get_isotope_adens(case, mat_name, isotope):
    """
    Return (burnup, adens) arrays for given isotope in given material.
    burnup is taken from global BU.
    """
    text = _read_dep_text(case)
    block = _extract_block(text, mat_name, "ADENS")
    if block is None:
        raise ValueError(f"material {mat_name} has no ADENS block")

    burnup = read_global_burnup(case)
    target = isotope.lower()

    for line in block.splitlines():
        if "%" not in line:
            continue
        data_part, _, name_part = line.partition("%")
        iso_name = name_part.strip().split()[0].lower()
        if iso_name == target:
            adens = np.array(_numbers(data_part))
            if len(adens) != len(burnup):
                raise ValueError(
                    f"{case}/{mat_name}/{isotope}: ADENS length={len(adens)} "
                    f"!= BU length={len(burnup)}"
                )
            return burnup, adens

    raise ValueError(f"isotope {isotope} not found in {mat_name}")

# =============================================================================
# Material selection
# =============================================================================
def pick_th_material(case, materials):
    """Select the Th-bearing material. If case itself is a material, use it."""
    if case in materials:
        return case
    if "mox43" in materials:
        return "mox43"
    # fallback: exclude mox70, mox87 if possible
    fallback = [m for m in materials if m not in ("mox70", "mox87")]
    return fallback[0] if fallback else None

# =============================================================================
# res.m
# =============================================================================
def read_res_data(case):
    """
    Return (burnup, conversion_ratio, keff).
    burnup is taken from global BU.
    """
    text = _read_file(case, "*_res.m")
    cr = _read_first_values_per_block(text, "CONVERSION_RATIO")
    keff = _read_first_values_per_block(text, "ANA_KEFF")
    burnup = read_global_burnup(case)
    n = min(len(burnup), len(cr), len(keff))
    return burnup[:n], cr[:n], keff[:n]

# =============================================================================
# detN.m
# =============================================================================
def _read_det_text(case, det_num):
    return _read_file(case, f"*_det{det_num}.m")

def _read_det_block(text, name):
    m = re.search(rf"^{re.escape(name)}\s*=\s*\[(.*?)\]\s*;", text, re.S | re.M)
    return m.group(1) if m else None

def read_spectrum(case, det_num, det_name="DET1"):
    """
    Read a 70-group neutron spectrum from a detector file.
    Returns dict with keys: E_mid, phi_u, flux_norm.
    """
    try:
        text = _read_det_text(case, det_num)
    except FileNotFoundError:
        return None

    det_block = _read_det_block(text, det_name)
    ene_block = _read_det_block(text, f"{det_name}E")
    if det_block is None or ene_block is None:
        return None

    det = np.array([_numbers(line) for line in det_block.splitlines() if _numbers(line)])
    ene = np.array([_numbers(line) for line in ene_block.splitlines() if _numbers(line)])

    phi_u = det[:, 10] if det.shape[1] >= 11 else det[:, -1]
    # energy midpoints: if 3 columns, use column 2; else geometric mean
    E_mid = ene[:, 2] if ene.shape[1] >= 3 else np.sqrt(ene[:, 0] * ene[:, 1])

    flux_norm = phi_u / phi_u.max() if phi_u.max() > 0 else phi_u
    return {"E_mid": E_mid, "phi_u": phi_u, "flux_norm": flux_norm}

# =============================================================================
# Output helper
# =============================================================================
def ensure_dir(path):
    path = Path(path)
    path.mkdir(parents=True, exist_ok=True)
    return path

# =============================================================================
# Case discovery (kept at end for clarity)
# =============================================================================
def discover_cases(base_dir=BASE_DIR):
    """Return all case folders containing *_res.m."""
    return sorted([
        entry.name
        for entry in Path(base_dir).iterdir()
        if entry.is_dir() and any(entry.glob("*_res.m"))
    ])

def case_dir(case, base_dir=BASE_DIR):
    return Path(base_dir) / case