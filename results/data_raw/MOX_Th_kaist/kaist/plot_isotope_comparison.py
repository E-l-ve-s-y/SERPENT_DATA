"""
plot_isotope_comparison.py
==========================

Cross-case comparison of atomic-density evolution for the Th-MOX
fuel cycle.  For each target isotope, a single figure overlays the
burnup-driven trajectory of every case folder (M43 family, M87
family, mox1 baseline).  The mox1 baseline is drawn as a black
dashed reference; the Th-fraction cases are colour-coded so that
the gradient reflects the Th loading.

Output: results/analysis/MOX_Th_kaist/kaist/Isotope_comparison/
"""

import re

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from kaist_utils import (
    OUTPUT_DIR,
    TARGET_ISOTOPES,
    discover_cases,
    ensure_dir,
    get_isotope_adens,
    list_materials,
    pick_th_material,
)


# --- case classification ---------------------------------------------------

_M43 = re.compile(r"^M43-(\d+)$")
_M87 = re.compile(r"^M87-(\d+)$")


def family(case):
    if case.lower() == "mox1":
        return "mox"
    if _M43.match(case):
        return "M43"
    if _M87.match(case):
        return "M87"
    return "other"


def th_fraction(case):
    if case.lower() == "mox1":
        return 0.0
    m = _M43.match(case) or _M87.match(case)
    return float(m.group(1)) if m else -1.0


def build_colormap(cases):
    """Return a {case: colour} mapping with M43 in Blues, M87 in Oranges."""
    colours = {}
    for fam, cmap in [("M43", plt.cm.Blues), ("M87", plt.cm.Oranges)]:
        members = sorted([c for c in cases if family(c) == fam], key=th_fraction)
        n = max(1, len(members) - 1)
        for i, c in enumerate(members):
            colours[c] = cmap(0.3 + 0.6 * i / n)
    for c in cases:
        if family(c) == "mox":
            colours[c] = "black"
        elif c not in colours:
            colours[c] = "#555555"
    return colours


# --- per-isotope plotting ---------------------------------------------------

def collect_data(isotope, cases):
    """Return {case: (burnup, adens)} for one isotope across all cases."""
    out = {}
    for case in cases:
        mats = list_materials(case)
        mat = pick_th_material(case, mats)
        if mat is None:
            continue
        try:
            burnup, adens = get_isotope_adens(case, mat, isotope)
        except ValueError:
            continue
        out[case] = (burnup, adens)
    return out


def plot_isotope(isotope, data, colours, out_dir):
    if not data:
        return
    fig, ax = plt.subplots(figsize=(10, 6))
    for case, (burnup, adens) in data.items():
        ls = "--" if family(case) == "mox" else "-"
        ax.semilogy(burnup, adens, linestyle=ls, linewidth=1.4,
                    color=colours.get(case, "#444"), label=case)
    ax.set_xlabel("Burnup (MWd/kgHM)")
    ax.set_ylabel("Atomic density (atom / b-cm)")
    ax.set_title(f"{isotope} evolution across all cases (MOX_Th_kaist)")
    ax.grid(True, which="both", alpha=0.3)
    ax.legend(loc="best", fontsize=8, ncol=2)
    fig.tight_layout()
    fig.savefig(out_dir / f"isotope_comparison_{isotope}.png", dpi=300, bbox_inches="tight")
    plt.close(fig)


def main():
    out_dir = ensure_dir(OUTPUT_DIR / "Isotope_comparison")
    cases = discover_cases()
    print(f"Discovered {len(cases)} cases: {cases}")
    print(f"Target isotopes ({len(TARGET_ISOTOPES)}): {TARGET_ISOTOPES}\n")

    colours = build_colormap(cases)

    all_rows = []
    for isotope in TARGET_ISOTOPES:
        data = collect_data(isotope, cases)
        n = len(data)
        if n == 0:
            print(f"[skip] {isotope}: not in any case")
            continue
        print(f"{isotope}: {n}/{len(cases)} cases -> plotting")
        plot_isotope(isotope, data, colours, out_dir)
        for case, (burnup, adens) in data.items():
            for b, a in zip(burnup, adens):
                all_rows.append({
                    "isotope": isotope, "case": case,
                    "family": family(case), "th_fraction": th_fraction(case),
                    "burnup": float(b), "adens": float(a),
                })

    if not all_rows:
        return

    # Long-format CSV
    df_long = pd.DataFrame(all_rows)
    df_long.to_csv(out_dir / "isotope_comparison_all_long.csv", index=False)
    print(f"\nLong-format CSV: {out_dir / 'isotope_comparison_all_long.csv'}")

    # End-of-burnup pivot
    end = (df_long.sort_values("burnup")
                 .groupby(["isotope", "case"])
                 .tail(1))
    pivot = end.pivot(index="isotope", columns="case", values="adens")
    pivot = pivot[[c for c in cases if c in pivot.columns]]  # preserve case order
    pivot.to_csv(out_dir / "isotope_comparison_end_burnup_pivot.csv")
    with pd.option_context("display.float_format", lambda v: f"{v:.3e}"):
        print(f"\nEnd-of-burnup atomic density (atom / b-cm):")
        print(pivot.to_string())


if __name__ == "__main__":
    main()
