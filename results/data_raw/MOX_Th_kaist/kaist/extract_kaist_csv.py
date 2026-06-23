"""
extract_kaist_csv.py
=====================

Extract KAIST MOX-Th Serpent burnup simulation data to categorized CSV files.

Walks 22 case folders and emits 8 CSV files into csv_data/:
- cases_index.csv: Master case metadata
- burnup.csv: Per-material burnup values
- isotopes_adens.csv: Isotope atomic densities (long format)
- isotopes_mdens.csv: Isotope mass densities (long format)
- reactivity.csv: Keff, conversion ratio, reactivity
- reaction_rates.csv: Fission/capture rates for key isotopes
- neutron_spectra.csv: 70-group neutron spectra from DET1
- detector_reaction_rates.csv: Detector tallies (DETu235_fiss, etc.)
"""

import re
import csv
import math
from pathlib import Path
from typing import List, Dict, Optional, Tuple, Any

BASE_DIR = Path(r"D:\serpent_data\results\data_raw\MOX_Th_kaist\kaist")
CSV_DIR = BASE_DIR / "csv_data"

_NUMBER_RE = re.compile(r"[+-]?\d+\.?\d*(?:[Ee][+-]?\d+)?")


def _numbers(text: str) -> List[float]:
    """Extract all floating-point numbers from text."""
    return [float(x) for x in _NUMBER_RE.findall(text)]


def _read_file(path: Path) -> str:
    """Read file content with tolerant encoding."""
    return path.read_text(encoding="utf-8", errors="ignore")


def _extract_block(text: str, name: str) -> Optional[str]:
    """
    Extract content of a block: {name} = [ ... ];
    Returns the block content as string, or None if not found.
    """
    m = re.search(rf"{re.escape(name)}\s*=\s*\[(.*?)\]\s*;", text, re.S)
    return m.group(1) if m else None


def _parse_names_block(text: str) -> List[str]:
    """
    Parse the NAMES = [...] block from dep.m.
    Returns list of isotope names (stripped).
    """
    block = _extract_block(text, "NAMES")
    if not block:
        return []
    names = []
    for m in re.finditer(r"'([^']+)'", block):
        names.append(m.group(1).strip())
    return names


def _parse_isotope_dens_block(block: str, names: List[str], n_steps: int) -> Dict[str, List[float]]:
    """
    Parse ADENS/MDENS block into dict {isotope: [values per step]}.
    Each row has n_steps values, followed by % comment with isotope name.
    """
    result = {}
    lines = [line for line in block.splitlines() if "%" in line]
    for line in lines:
        data_part, _, comment_part = line.partition("%")
        nums = _numbers(data_part)
        if len(nums) != n_steps:
            continue
        iso_name = comment_part.strip().split()[0] if comment_part.strip() else ""
        if iso_name:
            result[iso_name] = nums
    return result


def _read_res_idx_blocks(text: str, var_name: str) -> List[List[float]]:
    """
    Extract all idx blocks for a variable like ANA_KEFF or TH232_CAPT.
    Returns list of [value1, value2, ...] per idx occurrence.
    Handles both 2-value (ANA_KEFF) and 4-value (*_FISS/*_CAPT) blocks.
    """
    pattern = re.compile(
        rf"^{re.escape(var_name)}\s*\(\s*idx\s*,\s*\[\s*\d+:\s*\d+\s*\]\s*\)\s*=\s*\[(.*?)\]\s*;",
        re.S | re.M
    )
    results = []
    for m in pattern.finditer(text):
        nums = _numbers(m.group(1))
        results.append(nums)
    return results


def _deduplicate_first_values(values: List[List[float]]) -> List[float]:
    """
    Deduplicate consecutive identical first values (Serpent repeats values).
    Returns list of unique first values preserving order.
    """
    out = []
    for v in values:
        first = v[0] if v else None
        if first is not None and (not out or out[-1] != first):
            out.append(first)
    return out


def _deduplicate_blocks(blocks: List[List[float]]) -> List[List[float]]:
    """
    Deduplicate consecutive identical blocks (Serpent repeats each step twice).
    Only compares the first value of each block for dedup.
    Returns the full value lists, not just first values.
    """
    out = []
    for b in blocks:
        if not b:
            continue
        if not out or b[0] != out[-1][0]:
            out.append(b)
    return out


def _get_family_info(case: str) -> Tuple[str, Optional[int], str]:
    """
    Extract family, th_content_pct, case_type from case name.
    Returns: (family, th_content_pct, case_type)
    """
    # MOX reference cases: mox1, mox43, mox70, mox87
    if case.startswith("mox"):
        return ("MOX", None, "reference_mox")
    # Family cases: M43-5, M43-10, ... M87-30
    m = re.match(r"^M(\d+)-(\d+)$", case)
    if m:
        family = f"M{m.group(1)}"
        th_pct = int(m.group(2))
        return (family, th_pct, "family")
    return ("UNKNOWN", None, "unknown")


def discover_cases() -> List[str]:
    """Return all case folders containing *_dep.m."""
    return sorted([
        entry.name
        for entry in BASE_DIR.iterdir()
        if entry.is_dir() and any(entry.glob("*_dep.m"))
    ])


def list_materials(dep_text: str) -> List[str]:
    """Return material names (without MAT_ prefix) present in *_dep.m."""
    return sorted({
        m.group(1)
        for m in re.finditer(r"^MAT_([A-Za-z0-9_\-]+)_(?:BURNUP|ADENS|MDENS)\b", dep_text, re.M)
    })


def read_global_burnup(dep_text: str) -> List[float]:
    """Read the global burnup axis 'BU = [ ... ]' from *_dep.m."""
    m = re.search(r"^BU\s*=\s*\[(.*?)\]\s*;", dep_text, re.S | re.M)
    if not m:
        return []
    return _numbers(m.group(1))


def read_material_burnup(dep_text: str, material: str) -> List[float]:
    """Read MAT_{material}_BURNUP block."""
    block = _extract_block(dep_text, f"MAT_{material}_BURNUP")
    if not block:
        return []
    return _numbers(block)


def read_material_adens(dep_text: str, material: str, names: List[str], n_steps: int) -> Dict[str, List[float]]:
    """Read MAT_{material}_ADENS block and parse isotopes."""
    block = _extract_block(dep_text, f"MAT_{material}_ADENS")
    if not block:
        return {}
    return _parse_isotope_dens_block(block, names, n_steps)


def read_material_mdens(dep_text: str, material: str, names: List[str], n_steps: int) -> Dict[str, List[float]]:
    """Read MAT_{material}_MDENS block and parse isotopes."""
    block = _extract_block(dep_text, f"MAT_{material}_MDENS")
    if not block:
        return {}
    return _parse_isotope_dens_block(block, names, n_steps)


def read_detector_file(case: str, det_num: int) -> Optional[str]:
    """Read *_det{N}.m file content, return None if missing."""
    det_files = list((BASE_DIR / case).glob(f"*_det{det_num}.m"))
    if det_files:
        return _read_file(det_files[0])
    return None


def parse_det_block(text: str, block_name: str) -> Optional[List[List[float]]]:
    """
    Parse a DET block (e.g., DET1, DETu235_fiss1).
    Returns list of rows, each row is [idx, e_group, ..., flux, rel_err].
    """
    block = _extract_block(text, block_name)
    if not block:
        return None
    rows = []
    for line in block.splitlines():
        nums = _numbers(line)
        if len(nums) >= 2:
            rows.append(nums)
    return rows


def parse_det_energy_block(text: str, block_name: str) -> Optional[List[Tuple[float, float]]]:
    """
    Parse a DET energy block (e.g., DET1E, DETu235_fiss1E).
    Returns list of (E_min, E_max) pairs in MeV.
    """
    block = _extract_block(text, block_name)
    if not block:
        return None
    pairs = []
    for line in block.splitlines():
        nums = _numbers(line)
        if len(nums) >= 2:
            pairs.append((nums[0], nums[1]))
    return pairs


def discover_detector_tallies(text: str) -> List[str]:
    """
    Discover all DETxxx tally block names in a detector file.
    Excludes DET1 (handled separately as flux spectrum) and DETxxxE (energy companions).
    Returns sorted list of tally base names (without E suffix).
    """
    names = set()
    # Match DETxxx = [ blocks (start of block), excluding those followed by E
    for m in re.finditer(r"^(DET\w+)\s*=\s*\[", text, re.M):
        name = m.group(1)
        if name == "DET1" or name.endswith("E"):
            continue
        names.add(name)
    return sorted(names)


def aggregate_tally_by_egroup(rows: List[List[float]]) -> List[List[float]]:
    """
    Aggregate spatially-resolved tally rows by energy group.

    SERPENT DET block column layout (12 cols):
        col 0:  row index (1, 2, ...)
        col 1:  energy group index (1..70)
        col 2..9: spatial ID columns (axial, radial, fuel rod, etc.)
        col 10: value
        col 11: relative error

    Family cases (M43/M70/M87) have already aggregated: each block has exactly 70 rows
    with the spatial columns all set to 1.
    mox* cases are spatially-resolved: 70 e_groups × N rods (~289) = ~20k rows.

    We group by energy group (col 1) and sum values, propagating relative errors:

        sum_v    = Σ v_i
        err_var  = Σ (v_i · e_i)^2       # variance of sum (independent draws)
        sum_err  = sqrt(err_var)
        rel_err  = sum_err / sum_v

    Returns list of [e_group, sum_value, sum_rel_err] sorted by e_group.
    """
    if not rows:
        return []
    # If the tally already has <= 70 rows, assume pre-aggregated (family cases).
    if len(rows) <= 70:
        return [[r[1] if len(r) > 1 else r[0],
                 r[10] if len(r) > 10 else None,
                 r[11] if len(r) > 11 else None] for r in rows]
    # Otherwise aggregate by col[1] (energy group index, NOT col[0] which is row idx).
    from collections import defaultdict
    buckets: Dict[int, List[float]] = defaultdict(lambda: [0.0, 0.0])  # [sum_value, err_sq]
    for r in rows:
        if len(r) < 12:
            continue
        e_group = int(r[1])  # col[1] = energy group
        v = float(r[10])
        e = float(r[11])
        buckets[e_group][0] += v
        buckets[e_group][1] += (v * e) ** 2
    out = []
    for eg in sorted(buckets.keys()):
        sum_v, err_sq = buckets[eg]
        sum_err = math.sqrt(err_sq) if err_sq > 0 else 0.0
        rel_err = sum_err / sum_v if sum_v != 0 else 0.0
        out.append([float(eg), sum_v, rel_err])
    return out


def process_case(case: str) -> Dict[str, Any]:
    """
    Process a single case folder.
    Returns dict with all extracted data for this case.
    """
    case_path = BASE_DIR / case
    dep_files = list(case_path.glob("*_dep.m"))
    if not dep_files:
        return {}
    
    dep_text = _read_file(dep_files[0])
    global_bu = read_global_burnup(dep_text)
    n_steps = len(global_bu)
    names = _parse_names_block(dep_text)
    materials = list_materials(dep_text)
    
    # Check res.m
    res_files = list(case_path.glob("*_res.m"))
    has_res = len(res_files) > 0
    res_text = _read_file(res_files[0]) if has_res else ""
    
    # Count detector files
    det_files = sorted([
        int(re.search(r"_det(\d+)\.m$", f.name).group(1))
        for f in case_path.glob("*_det*.m")
        if re.search(r"_det\d+\.m$", f.name)
    ])
    n_det = len(det_files)
    
    # Extract family info
    family, th_pct, case_type = _get_family_info(case)
    
    # Extract reactivity data
    reactivity_data = []
    if has_res and res_text:
        keff_blocks = _read_res_idx_blocks(res_text, "ANA_KEFF")
        cr_blocks = _read_res_idx_blocks(res_text, "CONVERSION_RATIO")
        keff_vals = _deduplicate_first_values(keff_blocks)
        cr_vals = _deduplicate_first_values(cr_blocks)
        n_res_steps = min(len(keff_vals), len(cr_vals))
        for i in range(n_steps):
            row = {
                "step": i,
                "burnup_MWd_kgHM_global": global_bu[i] if i < n_steps else None,
                "ANA_KEFF": keff_vals[i] if i < n_res_steps else None,
                "CONVERSION_RATIO": cr_vals[i] if i < n_res_steps else None,
            }
            keff = row["ANA_KEFF"]
            if keff is not None and keff != 0:
                row["reactivity_pcm"] = (keff - 1) / keff * 1e5
            else:
                row["reactivity_pcm"] = None
            reactivity_data.append(row)
    else:
        # No res.m - fill with empty values
        for i in range(n_steps):
            reactivity_data.append({
                "step": i,
                "burnup_MWd_kgHM_global": global_bu[i],
                "ANA_KEFF": None,
                "CONVERSION_RATIO": None,
                "reactivity_pcm": None,
            })
    
    # Extract reaction rates
    reaction_rate_vars = [
        "TH232_CAPT", "U235_FISS", "U238_FISS", "PU239_FISS", "PU240_FISS", "PU241_FISS",
        "U235_CAPT", "U238_CAPT", "PU239_CAPT", "PU240_CAPT", "PU241_CAPT",
        "XE135_CAPT", "XE135M_CAPT"
    ]
    reaction_rates_data = []
    if has_res and res_text:
        # Collect all rate blocks
        rate_data = {}
        for var in reaction_rate_vars:
            blocks = _read_res_idx_blocks(res_text, var)
            rate_data[var] = _deduplicate_blocks(blocks) if blocks else []
        
        n_res_steps = min([len(rate_data[v]) for v in reaction_rate_vars if rate_data[v]] + [n_steps])
        n_res_steps = min(n_res_steps, n_steps)
        
        for i in range(n_steps):
            row = {
                "step": i,
                "burnup_MWd_kgHM_global": global_bu[i] if i < n_steps else None,
            }
            for var in reaction_rate_vars:
                blocks = rate_data.get(var, [])
                if i < len(blocks) and blocks[i]:
                    vals = blocks[i]
                    row[f"{var}_value"] = vals[0] if len(vals) > 0 else None
                    row[f"{var}_rel_err"] = vals[1] if len(vals) > 1 else None
                    row[f"{var}_fraction"] = vals[2] if len(vals) > 2 else None
                    row[f"{var}_fraction_rel_err"] = vals[3] if len(vals) > 3 else None
                else:
                    row[f"{var}_value"] = None
                    row[f"{var}_rel_err"] = None
                    row[f"{var}_fraction"] = None
                    row[f"{var}_fraction_rel_err"] = None
            reaction_rates_data.append(row)
    else:
        for i in range(n_steps):
            row = {"step": i, "burnup_MWd_kgHM_global": global_bu[i]}
            for var in reaction_rate_vars:
                row[f"{var}_value"] = None
                row[f"{var}_rel_err"] = None
                row[f"{var}_fraction"] = None
                row[f"{var}_fraction_rel_err"] = None
            reaction_rates_data.append(row)
    
    # Extract burnup per material
    burnup_data = []
    for mat in materials:
        mat_bu = read_material_burnup(dep_text, mat)
        for i, bu in enumerate(mat_bu):
            burnup_data.append({
                "case": case,
                "material": mat,
                "step": i,
                "burnup_MWd_kgHM": bu,
            })
    
    # Extract isotope densities
    isotopes_adens_data = []
    isotopes_mdens_data = []
    for mat in materials:
        adens = read_material_adens(dep_text, mat, names, n_steps)
        mdens = read_material_mdens(dep_text, mat, names, n_steps)
        for iso in names:
            if iso in adens:
                for i, val in enumerate(adens[iso]):
                    isotopes_adens_data.append({
                        "case": case,
                        "material": mat,
                        "step": i,
                        "isotope": iso,
                        "adens_atoms_per_barn_cm": val,
                    })
            if iso in mdens:
                for i, val in enumerate(mdens[iso]):
                    isotopes_mdens_data.append({
                        "case": case,
                        "material": mat,
                        "step": i,
                        "isotope": iso,
                        "mdens_g_per_cm3": val,
                    })
    
    # Extract neutron spectra from detectors
    neutron_spectra_data = []
    detector_rates_data = []

    for det_num in det_files:
        det_text = read_detector_file(case, det_num)
        if not det_text:
            continue

        # DET1 flux spectrum
        det1_rows = parse_det_block(det_text, "DET1")
        det1_energy = parse_det_energy_block(det_text, "DET1E")
        if det1_rows and det1_energy:
            for row_idx, row in enumerate(det1_rows):
                if row_idx < len(det1_energy):
                    e_min_mev, e_max_mev = det1_energy[row_idx]
                    # Values in DET1E are already in MeV (range 1e-9 to 2e+1 MeV;
                    # consistent with kaist_utils.THERMAL_LIMIT_MeV = 6.25e-7 MeV)
                    e_mid_mev = math.sqrt(e_min_mev * e_max_mev) if e_min_mev > 0 and e_max_mev > 0 else None
                    flux = row[10] if len(row) > 10 else None
                    rel_err = row[11] if len(row) > 11 else None
                    neutron_spectra_data.append({
                        "case": case,
                        "detector": det_num,
                        "energy_group_idx": int(row[0]) if row else row_idx + 1,
                        "E_min_MeV": e_min_mev,
                        "E_max_MeV": e_max_mev,
                        "E_mid_MeV": e_mid_mev,
                        "flux": flux,
                        "rel_err": rel_err,
                    })

        # Dynamically discover all DETxxx tally blocks (e.g., DETu235_fiss1, DETu238_cap, etc.)
        # mox* cases use no suffix (DETu235_fiss); family cases use 1/2/3 suffix
        tally_names = discover_detector_tallies(det_text)
        for tally in tally_names:
            tally_rows = parse_det_block(det_text, tally)
            tally_energy = parse_det_energy_block(det_text, f"{tally}E")
            if tally_rows:
                # Aggregate spatially-resolved tallies (mox* cases) to 70 energy groups.
                # Family cases are already aggregated.
                agg_rows = aggregate_tally_by_egroup(tally_rows)
                for row_idx, agg_row in enumerate(agg_rows):
                    e_min_mev = None
                    e_max_mev = None
                    if tally_energy and row_idx < len(tally_energy):
                        e_min_mev, e_max_mev = tally_energy[row_idx]
                    detector_rates_data.append({
                        "case": case,
                        "detector": det_num,
                        "tally_name": tally,
                        "energy_group_idx": int(agg_row[0]),
                        "E_min_MeV": e_min_mev,
                        "E_max_MeV": e_max_mev,
                        "value": agg_row[1],
                        "rel_err": agg_row[2],
                    })
    
    # Count res steps
    n_steps_res = n_steps
    if has_res and res_text:
        keff_blocks = _read_res_idx_blocks(res_text, "ANA_KEFF")
        n_steps_res = len(_deduplicate_first_values(keff_blocks))
    
    return {
        "case": case,
        "family": family,
        "th_content_pct": th_pct,
        "case_type": case_type,
        "n_materials": len(materials),
        "materials_csv": ",".join(materials),
        "has_res": has_res,
        "n_burn_steps": n_steps,
        "n_detector_files": n_det,
        "n_steps_res": n_steps_res,
        "burnup_data": burnup_data,
        "isotopes_adens_data": isotopes_adens_data,
        "isotopes_mdens_data": isotopes_mdens_data,
        "reactivity_data": reactivity_data,
        "reaction_rates_data": reaction_rates_data,
        "neutron_spectra_data": neutron_spectra_data,
        "detector_rates_data": detector_rates_data,
    }


def write_csv(filename: str, header: List[str], rows: List[Dict], key_order: List[str]):
    """Write rows to CSV file with given header."""
    path = CSV_DIR / filename
    with open(path, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f, lineterminator="\n", quoting=csv.QUOTE_MINIMAL)
        writer.writerow(header)
        for row in rows:
            out_row = []
            for key in key_order:
                val = row.get(key)
                if val is None:
                    out_row.append("")
                elif isinstance(val, float):
                    out_row.append(val)
                else:
                    out_row.append(val)
            writer.writerow(out_row)
    return len(rows)


def main():
    """Main entry point."""
    CSV_DIR.mkdir(parents=True, exist_ok=True)
    
    cases = discover_cases()
    print(f"Found {len(cases)} cases")
    
    # Accumulate data
    cases_index_rows = []
    burnup_rows = []
    isotopes_adens_rows = []
    isotopes_mdens_rows = []
    reactivity_rows = []
    reaction_rates_rows = []
    neutron_spectra_rows = []
    detector_rates_rows = []
    
    for case in cases:
        data = process_case(case)
        if not data:
            continue
        
        # Add to index
        cases_index_rows.append({
            "case": data["case"],
            "family": data["family"],
            "th_content_pct": data["th_content_pct"] if data["th_content_pct"] else "",
            "case_type": data["case_type"],
            "n_materials": data["n_materials"],
            "materials_csv": data["materials_csv"],
            "has_res": data["has_res"],
            "n_burn_steps": data["n_burn_steps"],
            "n_detector_files": data["n_detector_files"],
            "n_steps_res": data["n_steps_res"],
        })
        
        # Add other data
        burnup_rows.extend(data["burnup_data"])
        isotopes_adens_rows.extend(data["isotopes_adens_data"])
        isotopes_mdens_rows.extend(data["isotopes_mdens_data"])
        
        # Add case to reactivity/reaction_rates
        for row in data["reactivity_data"]:
            row["case"] = case
            reactivity_rows.append(row)
        for row in data["reaction_rates_data"]:
            row["case"] = case
            reaction_rates_rows.append(row)
        
        neutron_spectra_rows.extend(data["neutron_spectra_data"])
        detector_rates_rows.extend(data["detector_rates_data"])
        
        print(f"Processing {case} -> materials={data['n_materials']}, det={data['n_detector_files']}, has_res={data['has_res']}")
    
    # Write CSVs
    counts = {}
    
    # 1. cases_index.csv
    header = ["case", "family", "th_content_pct", "case_type", "n_materials",
              "materials_csv", "has_res", "n_burn_steps", "n_detector_files", "n_steps_res"]
    counts["cases_index.csv"] = write_csv("cases_index.csv", header, cases_index_rows, header)
    
    # 2. burnup.csv
    header = ["case", "material", "step", "burnup_MWd_kgHM"]
    counts["burnup.csv"] = write_csv("burnup.csv", header, burnup_rows, header)
    
    # 3. isotopes_adens.csv
    header = ["case", "material", "step", "isotope", "adens_atoms_per_barn_cm"]
    counts["isotopes_adens.csv"] = write_csv("isotopes_adens.csv", header, isotopes_adens_rows, header)
    
    # 4. isotopes_mdens.csv
    header = ["case", "material", "step", "isotope", "mdens_g_per_cm3"]
    counts["isotopes_mdens.csv"] = write_csv("isotopes_mdens.csv", header, isotopes_mdens_rows, header)
    
    # 5. reactivity.csv
    header = ["case", "step", "burnup_MWd_kgHM_global", "ANA_KEFF", "CONVERSION_RATIO", "reactivity_pcm"]
    counts["reactivity.csv"] = write_csv("reactivity.csv", header, reactivity_rows, header)
    
    # 6. reaction_rates.csv
    rate_vars = [
        "TH232_CAPT", "U235_FISS", "U238_FISS", "PU239_FISS", "PU240_FISS", "PU241_FISS",
        "U235_CAPT", "U238_CAPT", "PU239_CAPT", "PU240_CAPT", "PU241_CAPT",
        "XE135_CAPT", "XE135M_CAPT"
    ]
    header = ["case", "step", "burnup_MWd_kgHM_global"]
    for var in rate_vars:
        header.extend([f"{var}_value", f"{var}_rel_err", f"{var}_fraction", f"{var}_fraction_rel_err"])
    counts["reaction_rates.csv"] = write_csv("reaction_rates.csv", header, reaction_rates_rows, header)
    
    # 7. neutron_spectra.csv
    header = ["case", "detector", "energy_group_idx", "E_min_MeV", "E_max_MeV", "E_mid_MeV", "flux", "rel_err"]
    counts["neutron_spectra.csv"] = write_csv("neutron_spectra.csv", header, neutron_spectra_rows, header)
    
    # 8. detector_reaction_rates.csv
    header = ["case", "detector", "tally_name", "energy_group_idx", "E_min_MeV", "E_max_MeV", "value", "rel_err"]
    counts["detector_reaction_rates.csv"] = write_csv("detector_reaction_rates.csv", header, detector_rates_rows, header)
    
    # Print summary
    print("\nCSV extraction complete:")
    for fn, cnt in counts.items():
        print(f"  {fn}: {cnt} rows")


if __name__ == "__main__":
    main()