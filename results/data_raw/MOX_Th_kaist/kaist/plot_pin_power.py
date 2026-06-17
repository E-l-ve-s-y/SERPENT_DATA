"""
plot_pin_power.py
=================

1/8-assembly pin-power distribution plot for KAIST MOX-Th reactors.

Pipeline
--------
1. Parse all ``PPW_POW`` blocks from ``*_res.m`` (one block per burnup step).
2. Each block has 1156 floats in the order
       (fast_val, fast_err, thermal_val, thermal_err) per pin.
   Taking the "odd 1-based" entries (the values) gives 578 floats, which
   are then grouped into 289 adjacent pairs (one fast + one thermal) and
   summed to obtain the total power of each of the 289 pins.
3. Reshape to a 17x17 grid, then take the 1/8 view: the lower-triangular
   half of the 9x9 upper-left quadrant. Zero-power cells (water rods) are
   detected automatically and rendered as black squares.
4. Normalise so the *average fuel pin power is 1*; compute the relative
   error of each fuel pin against 1.
5. Save one PNG per (case, burnup step) and one consolidated CSV per case.

Output
------
results/analysis/MOX_Th_kaist/kaist/Pin_power/{case}/
    {case}_bstep{NN}_1_8_pin_power.png     (per burnup step)
    {case}_pin_power_1_8.csv               (all steps, long format)
"""

from __future__ import annotations

import re
from pathlib import Path
from typing import List, Tuple

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib import colormaps
from matplotlib.patches import Rectangle

from kaist_utils import (
    BASE_DIR,
    OUTPUT_DIR,
    discover_cases,
    ensure_dir,
    read_global_burnup,
)

# ------------------------------------------------------------------ constants
GRID_SIZE = 17                              # 17x17 assembly
N_PINS = GRID_SIZE * GRID_SIZE              # 289
ELEMENTS_PER_LINE = 1156                    # PPW_POW length
QUAD_SIZE = (GRID_SIZE + 1) // 2            # 9  (upper-left 1/4 quadrant)
PIN_POWER_THRESHOLD = 1e-30                 # below this -> water rod

# regex helpers
_PPW_POW_RE = re.compile(
    r"^PPW_POW\s*\(idx,\s*\[1:\s*1156\]\)\s*=\s*\[\s*(.*?)\]\s*;",
    re.S | re.M,
)
_NUM_RE = re.compile(r"[+-]?\d+\.?\d*(?:[Ee][+-]?\d+)?")


# ------------------------------------------------------------------ parsing
def parse_ppw_pow_blocks(text: str) -> List[np.ndarray]:
    """Extract every PPW_POW array from a ``*_res.m`` text. Each is length 1156."""
    blocks: List[np.ndarray] = []
    for m in _PPW_POW_RE.finditer(text):
        nums = np.array([float(x) for x in _NUM_RE.findall(m.group(1))])
        if nums.size == ELEMENTS_PER_LINE:
            blocks.append(nums)
    return blocks


def extract_pin_powers(ppw_pow: np.ndarray) -> np.ndarray:
    """
    1156-element array -> 289-element array of total pin power (fast + thermal).

    The 1156 elements are stored in 4-tuples per pin:
        (fast_val, fast_err, thermal_val, thermal_err).
    ``ppw_pow[::2]`` picks out the values (the "odd 1-based" columns),
    which then alternate (fast, thermal) per pin.
    """
    values = ppw_pow[::2]                              # 578 floats
    if values.size != 2 * N_PINS:
        raise ValueError(f"unexpected value count: {values.size}")
    return values.reshape(N_PINS, 2).sum(axis=1)       # 289 sums


# ------------------------------------------------------------------ geometry
def make_one_eighth_view(pin_powers: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
    """
    17x17 pin-power grid -> (9x9 grid, 9x9 fuel mask) for the 1/8 view.

    The 1/8 view is the lower-triangular (row >= col) of the 9x9
    lower-right quadrant of the 17x17 grid, i.e. rows/cols 8..16
    (1-based: 9..17). Cells above the local diagonal are masked;
    cells in the lower-triangular that have ~zero power (water rods)
    are also masked.
    """
    full = pin_powers.reshape(GRID_SIZE, GRID_SIZE)
    quad = full[GRID_SIZE - QUAD_SIZE:, GRID_SIZE - QUAD_SIZE:].astype(float).copy()
    above = np.triu(np.ones((QUAD_SIZE, QUAD_SIZE), dtype=bool), k=1)
    quad[above] = np.nan
    fuel_mask = (~np.isnan(quad)) & (quad > PIN_POWER_THRESHOLD)
    return quad, fuel_mask


def normalize(grid: np.ndarray, fuel_mask: np.ndarray) -> Tuple[np.ndarray, float]:
    """Divide all cells by the average of fuel cells (NaN-safe)."""
    avg = float(np.nanmean(grid[fuel_mask]))
    return grid / avg, avg


def relative_error_pct(norm_grid: np.ndarray, fuel_mask: np.ndarray) -> np.ndarray:
    """(normalised - 1) * 100, restricted to fuel cells (others = NaN)."""
    rel = (norm_grid - 1.0) * 100.0
    rel[~fuel_mask] = np.nan
    return rel


# ------------------------------------------------------------------ plotting
def _annotate(ax, grid, fuel_mask, *, fmt, cmap, vmin, vmax, fontsize=8):
    """Draw the 9x9 1/8 view with cell annotations."""
    # Cells outside the 1/8 view (upper-triangular, stored as NaN) are rendered
    # as the cmap's "bad" colour -> white. Water-rod cells (inside the 1/8
    # view but with zero power) are still drawn as black so the assembly
    # geometry stays legible.
    #
    # NOTE: matplotlib's ``imshow(..., aspect=...)`` follows the same convention
    # as ``set_aspect`` — it is the **y/x ratio** (height/width), not the other
    # way around. To get cells that are *wider* than tall (width:height = 4:3),
    # we pass 3/4 (= 0.75).
    cmap = cmap.with_extremes(bad="white")
    im = ax.imshow(grid, cmap=cmap, vmin=vmin, vmax=vmax, aspect=3 / 4)
    for i in range(QUAD_SIZE):
        for j in range(QUAD_SIZE):
            if np.isnan(grid[i, j]):
                # upper-triangular: leave the imshow to paint it white
                continue
            if not fuel_mask[i, j]:
                # water rod (zero power, inside the 1/8 view)
                ax.add_patch(Rectangle((j - 0.5, i - 0.5), 1, 1,
                                       facecolor="black", edgecolor="grey",
                                       linewidth=0.4))
            else:
                ax.text(j, i, fmt.format(grid[i, j]), ha="center", va="center",
                        color="black", fontsize=fontsize)
    ax.set_xticks(range(QUAD_SIZE))
    ax.set_yticks(range(QUAD_SIZE))
    ax.set_xticklabels(range(1, QUAD_SIZE + 1))
    ax.set_yticklabels(range(1, QUAD_SIZE + 1))
    return im


def plot_step(
    grid_norm: np.ndarray,
    grid_err: np.ndarray,
    fuel_mask: np.ndarray,
    *,
    case: str,
    bstep: int,
    burnup: float,
    out_path: Path,
) -> None:
    # Width grew because each cell is now 4:3 (wider than tall); bump width
    # proportionally so the two side-by-side subplots stay balanced.
    fig, (ax_n, ax_e) = plt.subplots(1, 2, figsize=(18, 8))

    fuel_vals = grid_norm[fuel_mask]
    v_lo, v_hi = float(np.nanmin(fuel_vals)), float(np.nanmax(fuel_vals))
    e_vals = grid_err[fuel_mask]
    e_abs = float(np.nanmax(np.abs(e_vals)))
    e_lo, e_hi = -e_abs, e_abs

    im_n = _annotate(ax_n, grid_norm, fuel_mask,
                     fmt="{:.4f}", cmap=colormaps["jet"],
                     vmin=v_lo, vmax=v_hi)
    ax_n.set_title(f"{case} - step {bstep:02d} (BU={burnup:.2f} MWd/kgHM)\n"
                   f"1/8 normalised pin power (fuel-rod avg = 1)")
    fig.colorbar(im_n, ax=ax_n, fraction=0.046, pad=0.04, label="Normalised power")

    im_e = _annotate(ax_e, grid_err, fuel_mask,
                     fmt="{:.3f}%", cmap=colormaps["RdYlBu_r"],
                     vmin=e_lo, vmax=e_hi)
    ax_e.set_title("Relative error vs 1.000")
    fig.colorbar(im_e, ax=ax_e, fraction=0.046, pad=0.04, label="Relative error (%)")

    n_fuel = int(fuel_mask.sum())
    fig.suptitle(
        f"Fuel pins: {n_fuel}/{N_PINS}   "
        f"Max: {v_hi:.4f}   Min: {v_lo:.4f}   Avg: 1.0000",
        y=-0.01, fontsize=9,
    )
    fig.tight_layout()
    fig.savefig(out_path, dpi=200, bbox_inches="tight")
    plt.close(fig)


# ------------------------------------------------------------------ per-case
def process_case(case: str, out_root: Path) -> None:
    case_dir = BASE_DIR / case
    res_files = sorted(case_dir.glob("*_res.m"))
    if not res_files:
        print(f"  [skip] {case}: no *_res.m")
        return

    text = res_files[0].read_text(encoding="utf-8", errors="ignore")
    blocks = parse_ppw_pow_blocks(text)
    if not blocks:
        print(f"  [skip] {case}: no PPW_POW block parsed")
        return

    try:
        burnup = read_global_burnup(case)
    except Exception as e:
        print(f"  [warn] {case}: cannot read burnup ({e}); using step index")
        burnup = np.arange(len(blocks), dtype=float)

    n_steps = min(len(blocks), len(burnup))
    out_case = ensure_dir(out_root / case)

    # Fuel mask is constant across steps for a fixed assembly geometry.
    _, fuel_mask = make_one_eighth_view(extract_pin_powers(blocks[0]))
    n_fuel = int(fuel_mask.sum())
    print(f"  {case}: {n_steps} step(s), {n_fuel} fuel pins in 1/8 view")

    rows: list[dict] = []
    for i in range(n_steps):
        pins = extract_pin_powers(blocks[i])
        grid, _ = make_one_eighth_view(pins)
        norm, _ = normalize(grid, fuel_mask)
        rel_err = relative_error_pct(norm, fuel_mask)
        bu = float(burnup[i])

        png_path = out_case / f"{case}_bstep{i:02d}_1_8_pin_power.png"
        plot_step(norm, rel_err, fuel_mask,
                  case=case, bstep=i, burnup=bu, out_path=png_path)

        for r in range(QUAD_SIZE):
            for c in range(QUAD_SIZE):
                if not fuel_mask[r, c]:
                    continue
                rows.append({
                    "case": case,
                    "bstep": i,
                    "burnup_MWd_kgHM": bu,
                    "row_1of8": r + 1,
                    "col_1of8": c + 1,
                    "power_raw": grid[r, c],
                    "power_normalized": norm[r, c],
                    "rel_error_pct": rel_err[r, c],
                })

    if rows:
        df = pd.DataFrame(rows)
        csv_path = out_case / f"{case}_pin_power_1_8.csv"
        df.to_csv(csv_path, index=False, float_format="%.6f")
        print(f"  {case} CSV: {csv_path.name} ({len(df)} rows)")


# ------------------------------------------------------------------ main
def main() -> None:
    out_root = ensure_dir(OUTPUT_DIR / "Pin_power")
    cases = discover_cases()
    print(f"Discovered {len(cases)} case(s): {cases}")
    for case in cases:
        print(f"\n=== {case} ===")
        try:
            process_case(case, out_root)
        except Exception as e:
            print(f"  [FAIL] {case}: {e}")
    print("\nAll done.")


if __name__ == "__main__":
    main()
