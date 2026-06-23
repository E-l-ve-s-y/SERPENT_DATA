"""
plot_th232_macroscopic_capture.py
=================================

Compute and plot the macroscopic Th-232(n,gamma) capture rate for
each kaist case at BOC.

Workflow
--------
1.  Reuse `read_capture_sum(case)` from the microscopic script to get
    the 70-group microscopic capture response (per source particle,
    per lethargy) from the th232_capN detector whose `dm` tag equals
    the case name.
2.  Read the Th-232 atomic number density (atoms/barn/cm) at the
    same burnup step from `MAT_<case>_ADENS` in the case's *_dep.m
    output.  The Th-232 row is identified by its trailing `% Th232`
    comment (Serpent's `iTh232 = 1` index).
3.  Multiply the microscopic response by the atomic density to
    obtain the macroscopic capture rate (1/cm per lethargy).
4.  Plot using the same family-by-family style as the microscopic
    script: M43 / M70 / M87 absolute panels with a shared y-range
    and per-family colormap gradient (Blues / Greens / Oranges),
    plus the normalized fractional-contribution and cumulative
    views and a per-energy-region CSV table.

Output: results/analysis/MOX_Th_kaist/kaist/Th232_capture_macroscopic/
"""

import re
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from pathlib import Path

from kaist_utils import BASE_DIR, OUTPUT_DIR, discover_cases, ensure_dir

# Reuse parser helpers and the microscopic-rate reader from the sibling
# script so the detector selection logic (capN matched by dm=<case>)
# stays in one place.
from plot_th232_capture_response import (
    read_capture_sum,
    get_family,
    family_palette,
    THERMAL_LIMIT,
    EPITHERMAL_LIMIT,
    RESONANCE_LIMIT,
    FAMILY_COLORMAPS,
    _style_log_xaxis,
)

# ---------------------------------------------------------------------------
# Atomic-density reader
# ---------------------------------------------------------------------------
def _read_text(path):
    return path.read_text(encoding="utf-8", errors="ignore")


def _block(text, name):
    m = re.search(rf"^{re.escape(name)}\s*=\s*\[(.*?)\]\s*;", text, re.S | re.M)
    return m.group(1) if m else None


def _numbers(s):
    return [float(x) for x in re.findall(r"[+-]?\d+\.?\d*(?:[Ee][+-]?\d+)?", s)]


def read_th232_adens(case, burnup_step=0):
    """Return Th-232 atomic number density (atoms/barn/cm) at the
    given burnup step (0-indexed) from `MAT_<case>_ADENS` in the
    case's *_dep.m file.

    The Th-232 row is the first data row of `MAT_<case>_ADENS`
    (Serpent's `i902320 = 1; iTh232 = 1;` index) and is identified
    by its trailing `% Th232` comment.  `burnup_step=0` reads the
    BOC value (first column), which matches the snapshot stored in
    the case's *_det0.m output.
    """
    dep_file = next(iter((BASE_DIR / case).glob("*_dep.m")), None)
    if dep_file is None:
        return None
    text = _read_text(dep_file)

    adens_block = _block(text, f"MAT_{case}_ADENS")
    if adens_block is None:
        print(f"  Warning: MAT_{case}_ADENS not found in {case} dep.m")
        return None

    for line in adens_block.splitlines():
        # Exact trailing comment match so we don't accidentally pick
        # up Th-233 / Th-234 / Pa-232 / etc.
        if not line.rstrip().endswith("% Th232"):
            continue
        data_part = line.split("%", 1)[0]
        nums = _numbers(data_part)
        if burnup_step < 0 or burnup_step >= len(nums):
            print(
                f"  Warning: burnup_step={burnup_step} out of range "
                f"for {case} Th-232 row (len={len(nums)})"
            )
            return None
        return nums[burnup_step]

    print(f"  Warning: Th-232 row not found in MAT_{case}_ADENS")
    return None


def read_macroscopic_capture(case, burnup_step=0):
    """Return (E_mid, macroscopic_response) for the case at the given
    burnup step.

    macroscopic = microscopic * N_Th232

    The microscopic response is the 70-group detector output for
    th232_capN matched to this case; N_Th232 is the Th-232 atomic
    number density from the dep.m output.  The resulting macroscopic
    rate is in 1/cm per lethargy, normalised the same way as the
    microscopic detector.
    """
    micro = read_capture_sum(case)
    if micro is None:
        return None
    E_mid, micro_R = micro

    adens = read_th232_adens(case, burnup_step=burnup_step)
    if adens is None:
        return None

    macro_R = micro_R * adens
    return E_mid, macro_R


# ---------------------------------------------------------------------------
# Energy-region bookkeeping (identical to the microscopic script)
# ---------------------------------------------------------------------------
def get_region_fractions(E_mid, response):
    total = response.sum()
    if total == 0:
        return {"Thermal": 0.0, "Epithermal": 0.0, "Resonance": 0.0, "Fast": 0.0}
    return {
        "Thermal": 100 * response[E_mid < THERMAL_LIMIT].sum() / total,
        "Epithermal": 100 * response[(E_mid >= THERMAL_LIMIT) & (E_mid < EPITHERMAL_LIMIT)].sum() / total,
        "Resonance": 100 * response[(E_mid >= EPITHERMAL_LIMIT) & (E_mid < RESONANCE_LIMIT)].sum() / total,
        "Fast": 100 * response[E_mid >= RESONANCE_LIMIT].sum() / total,
    }


# ---------------------------------------------------------------------------
# Plotting - mirrors the microscopic script with macroscopic labels
# ---------------------------------------------------------------------------
def plot_response_by_family(captures, adens_table, out_dir):
    cases = list(captures.keys())

    finite_R = [R[R > 0] for _, (_, R) in captures.items() if (R > 0).any()]
    if not finite_R:
        print("  [skip] No positive response values to plot")
        return
    ymin = float(min(r.min() for r in finite_R))
    ymax = float(max(r.max() for r in finite_R))
    pad = 0.05 * (ymax - ymin)
    ylim = (max(0.0, ymin - pad), ymax + pad)
    print(f"  Shared ylim: [{ylim[0]:.3e}, {ylim[1]:.3e}]")

    for fam in ["M43", "M70", "M87"]:
        palette = family_palette(fam, cases)
        if not palette:
            print(f"  [skip] No cases for family {fam}")
            continue

        fig, ax = plt.subplots(figsize=(9, 6))
        for case, color in palette.items():
            E, R = captures[case]
            n_th = adens_table.get(case, float("nan"))
            label = f"{case}  (N_Th232={n_th:.3e})"
            ax.semilogx(E, R, marker='o', markersize=4, linewidth=1.4,
                        color=color, label=label)
        ax.set_ylim(*ylim)
        ax.set_xlabel("Energy (MeV)")
        ax.set_ylabel("Th-232 macroscopic capture rate (1/cm per lethargy)")
        ax.set_title(f"Total Th-232 macroscopic capture spectrum - {fam} family (BOC)")
        _style_log_xaxis(ax)
        ax.legend(fontsize=8)
        fig.tight_layout()
        out_path = out_dir / f"Th232_macroscopic_capture_response_{fam}.png"
        fig.savefig(out_path, dpi=300, bbox_inches="tight")
        plt.close(fig)
        print(f"  Saved: {out_path.name}")


def plot_normalized(captures, out_dir):
    if not captures:
        return

    fig, ax = plt.subplots(figsize=(9, 6))
    for case, (E, R) in captures.items():
        total = R.sum()
        if total > 0:
            ax.semilogx(E, R / total, marker='o', markersize=4, linewidth=1.4, label=case)
    ax.set_xlabel("Energy (MeV)")
    ax.set_ylabel("Fraction of total Th-232 macroscopic capture")
    ax.set_title("Normalized Th-232 macroscopic capture contribution (BOC)")
    _style_log_xaxis(ax)
    ax.legend(fontsize=9)
    fig.tight_layout()
    fig.savefig(out_dir / "Th232_macroscopic_capture_fraction.png", dpi=300, bbox_inches="tight")
    plt.close(fig)

    fig, ax = plt.subplots(figsize=(9, 6))
    for case, (E, R) in captures.items():
        total = R.sum()
        if total > 0:
            ax.semilogx(E, np.cumsum(R) / total, linewidth=2.0, label=case)
    ax.set_xlabel("Energy (MeV)")
    ax.set_ylabel("Cumulative fraction")
    ax.set_title("Cumulative Th-232 macroscopic capture contribution (BOC)")
    _style_log_xaxis(ax)
    ax.legend(fontsize=9)
    fig.tight_layout()
    fig.savefig(out_dir / "Th232_macroscopic_capture_cumulative.png", dpi=300, bbox_inches="tight")
    plt.close(fig)


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------
def main(burnup_step=0):
    out_dir = ensure_dir(OUTPUT_DIR / "Th232_capture_macroscopic")
    cases = discover_cases()
    print(f"Discovered {len(cases)} cases: {cases}")
    print(f"Using burnup_step={burnup_step} (0 = BOC)")

    captures = {}
    table = {}
    adens_table = {}

    for case in cases:
        data = read_macroscopic_capture(case, burnup_step=burnup_step)
        if data is None:
            print(f"  [skip] {case}: no macroscopic Th-232 capture data")
            continue
        E_mid, response = data
        captures[case] = data
        table[case] = get_region_fractions(E_mid, response)
        adens_table[case] = read_th232_adens(case, burnup_step=burnup_step)
        print(
            f"  {case}: macroscopic total = {response.sum():.3e}  "
            f"(N_Th232={adens_table[case]:.3e})"
        )

    if not captures:
        print("No macroscopic Th-232 capture data found.")
        return

    plot_response_by_family(captures, adens_table, out_dir)
    plot_normalized(captures, out_dir)

    df = pd.DataFrame(table).T[["Thermal", "Epithermal", "Resonance", "Fast"]]
    df.index.name = "case"
    print("\nTh-232 macroscopic capture region contributions (%):")
    print(df.round(2).to_string())
    df.round(3).to_csv(out_dir / "Th232_macroscopic_capture_contribution_table.csv")
    print(f"Saved: {out_dir / 'Th232_macroscopic_capture_contribution_table.csv'}")


if __name__ == "__main__":
    main()
