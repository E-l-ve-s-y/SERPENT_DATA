"""
plot_th232_capture_response.py
==============================

Read Th-232 capture detectors (DETth232_cap1, cap2, cap3) from each
kaist case, sum them, and plot the capture response, its fractional
contribution, and its cumulative distribution. Also write a
per-energy-region table to CSV.

The absolute response view is split into three family-specific plots
(M43, M70, M87) that share the same y-axis range so the plots are
directly comparable across families.  Each family keeps its own
colormap gradient: Blues for M43, Greens for M70, Oranges for M87.

Output: results/analysis/MOX_Th_kaist/kaist/Th232_capture/
"""

import re
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from pathlib import Path

from kaist_utils import (
    BASE_DIR,
    OUTPUT_DIR,
    discover_cases,
    ensure_dir,
)

# Energy-region boundaries (MeV)
THERMAL_LIMIT = 5e-7
EPITHERMAL_LIMIT = 1e-4
RESONANCE_LIMIT = 1e-1

# Fuel-family -> colormap name.  The three families each get a distinct
# sequential colormap so the gradient is consistent with the convention
# used in plot_isotope_comparison.py (Blues for M43, Oranges for M87);
# M70 is assigned Greens, the natural third in matplotlib's standard
# sequential family.
FAMILY_COLORMAPS = {
    "M43": "Blues",
    "M70": "Greens",
    "M87": "Oranges",
}


def get_family(case):
    """Return the fuel-family tag (M43 / M70 / M87) for a case name."""
    m = re.match(r"^(M\d+)-", case)
    return m.group(1) if m and m.group(1) in FAMILY_COLORMAPS else "other"


def family_palette(family, cases):
    """Return {case: colour} for cases in `family`, sorted by Th fraction.

    Lightest shade is assigned to the lowest Th fraction, darkest to the
    highest, matching the gradient convention in plot_isotope_comparison.py.
    """
    cmap = plt.colormaps[FAMILY_COLORMAPS[family]]
    members = sorted(
        [c for c in cases if get_family(c) == family],
        key=lambda c: int(c.split("-")[1]),
    )
    n = max(1, len(members) - 1)
    return {c: cmap(0.3 + 0.6 * i / n) for i, c in enumerate(members)}


def _read_text(path):
    return path.read_text(encoding="utf-8", errors="ignore")


def _block(text, name):
    m = re.search(rf"^{re.escape(name)}\s*=\s*\[(.*?)\]\s*;", text, re.S | re.M)
    return m.group(1) if m else None


def _numbers(s):
    return [float(x) for x in re.findall(r"[+-]?\d+\.?\d*(?:[Ee][+-]?\d+)?", s)]


def read_capture_sum(case):
    """Return (E_mid, total_response) for Th-232 capture (cap1+cap2+cap3)."""
    det_file = next(iter((BASE_DIR / case).glob("*_det0.m")), None)
    if det_file is None:
        return None
    
    text = _read_text(det_file)
    
    # Read energy grid (only once)
    ene_block = _block(text, "DETth232_cap1E")
    if ene_block is None:
        return None
    
    ene = np.array([_numbers(line) for line in ene_block.splitlines() if _numbers(line)])
    if len(ene) == 0:
        return None
    
    E_mid = ene[:, 2] if ene.shape[1] >= 3 else np.sqrt(ene[:, 0] * ene[:, 1])
    
    # Sum responses from all three capture detectors
    total_response = np.zeros_like(E_mid)
    for i in range(1, 4):  # cap1, cap2, cap3
        det_block = _block(text, f"DETth232_cap{i}")
        if det_block is None:
            print(f"  Warning: DETth232_cap{i} not found in {case}")
            continue
        det = np.array([_numbers(line) for line in det_block.splitlines() if _numbers(line)])
        if len(det) > 0:
            total_response += det[:, 10]  # column 10 = mean
    
    if np.all(total_response == 0):
        print(f"  Warning: All zero response for {case}")
        return None
    
    return E_mid, total_response


def get_region_fractions(E_mid, response):
    """Return fractions for energy regions."""
    total = response.sum()
    if total == 0:
        return {"Thermal": 0.0, "Epithermal": 0.0, "Resonance": 0.0, "Fast": 0.0}
    
    return {
        "Thermal": 100 * response[E_mid < THERMAL_LIMIT].sum() / total,
        "Epithermal": 100 * response[(E_mid >= THERMAL_LIMIT) & (E_mid < EPITHERMAL_LIMIT)].sum() / total,
        "Resonance": 100 * response[(E_mid >= EPITHERMAL_LIMIT) & (E_mid < RESONANCE_LIMIT)].sum() / total,
        "Fast": 100 * response[E_mid >= RESONANCE_LIMIT].sum() / total,
    }


def plot_response_by_family(captures, out_dir):
    """Generate one absolute-response plot per family (M43, M70, M87).

    All three plots share the same y-axis range so they are directly
    comparable across families.  Each family uses its own colormap
    gradient (Blues / Greens / Oranges) with the lightest shade at the
    lowest Th fraction and the darkest at the highest.

    The x-axis is logarithmic (lethargy-style energy grid) and the
    y-axis is linear on a shared range computed across all cases.
    """
    cases = list(captures.keys())

    # Global y-range from positive response values only, in linear space.
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
            ax.semilogx(E, R, marker='o', markersize=4, linewidth=1.4,
                        color=color, label=case)
        ax.set_ylim(*ylim)
        ax.set_xlabel("Energy (MeV)")
        ax.set_ylabel("Th-232 capture response (per lethargy)")
        ax.set_title(f"Total Th-232 capture spectrum - {fam} family")
        ax.grid(True, which='both', alpha=0.3)
        ax.legend(fontsize=9)
        fig.tight_layout()
        out_path = out_dir / f"Th232_capture_response_{fam}.png"
        fig.savefig(out_path, dpi=300, bbox_inches="tight")
        plt.close(fig)
        print(f"  Saved: {out_path.name}")


def plot_normalized(captures, out_dir):
    """Generate the fractional-contribution and cumulative-distribution plots.

    These views use the normalized response (per case) so a single y-axis
    is meaningful across all cases regardless of absolute magnitude.
    """
    if not captures:
        return

    # Fractional contribution
    fig, ax = plt.subplots(figsize=(9, 6))
    for case, (E, R) in captures.items():
        total = R.sum()
        if total > 0:
            ax.semilogx(E, R/total, marker='o', markersize=4, linewidth=1.4, label=case)
    ax.set_xlabel("Energy (MeV)")
    ax.set_ylabel("Fraction of total Th-232 capture")
    ax.set_title("Normalized Th-232 capture contribution")
    ax.grid(True, which='both', alpha=0.3)
    ax.legend(fontsize=9)
    fig.tight_layout()
    fig.savefig(out_dir / "Th232_capture_fraction.png", dpi=300, bbox_inches="tight")
    plt.close(fig)

    # Cumulative distribution
    fig, ax = plt.subplots(figsize=(9, 6))
    for case, (E, R) in captures.items():
        total = R.sum()
        if total > 0:
            ax.semilogx(E, np.cumsum(R)/total, linewidth=2.0, label=case)
    ax.set_xlabel("Energy (MeV)")
    ax.set_ylabel("Cumulative fraction")
    ax.set_title("Cumulative Th-232 capture contribution")
    ax.grid(True, which='both', alpha=0.3)
    ax.legend(fontsize=9)
    fig.tight_layout()
    fig.savefig(out_dir / "Th232_capture_cumulative.png", dpi=300, bbox_inches="tight")
    plt.close(fig)


def main():
    out_dir = ensure_dir(OUTPUT_DIR / "Th232_capture")
    cases = discover_cases()
    print(f"Discovered {len(cases)} cases: {cases}")
    
    captures = {}
    table = {}
    
    for case in cases:
        data = read_capture_sum(case)
        if data is None:
            print(f"  [skip] {case}: no Th-232 capture data")
            continue
        
        E_mid, response = data
        captures[case] = data
        table[case] = get_region_fractions(E_mid, response)
        print(f"  {case}: total response = {response.sum():.3e}")
    
    if not captures:
        print("No Th-232 capture data found.")
        return
    
    plot_response_by_family(captures, out_dir)
    plot_normalized(captures, out_dir)
    
    # Save region contribution table
    df = pd.DataFrame(table).T[["Thermal", "Epithermal", "Resonance", "Fast"]]
    df.index.name = "case"
    print("\nTh-232 capture region contributions (%):")
    print(df.round(2).to_string())
    df.round(3).to_csv(out_dir / "Th232_capture_contribution_table.csv")
    print(f"Saved: {out_dir / 'Th232_capture_contribution_table.csv'}")


if __name__ == "__main__":
    main()