"""
plot_isotope_evolution.py
==========================

For every case folder, plot the burnup-driven evolution of
Th232, Pa233, U233 and the thorium conversion efficiency.  Also
write a per-case end-of-burnup summary CSV.

Output: results/analysis/MOX_Th_kaist/kaist/Isotope_evolution/
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from kaist_utils import (
    OUTPUT_DIR,
    discover_cases,
    ensure_dir,
    get_isotope_adens,
    list_materials,
    pick_th_material,
    read_global_burnup,
)


# Isotopes to draw on the per-case evolution plot
PER_CASE_ISOTOPES = ["Th232", "Pa233", "U233"]
SUMMARY_ISOTOPES = ["Th232", "U233", "U235", "U238",
                    "Pu239", "Pu240", "Pu241", "Pu242",
                    "Xe135", "Sm149"]


def plot_single_isotope(case, mat, isotope, out_dir):
    burnup, adens = get_isotope_adens(case, mat, isotope)
    fig, ax = plt.subplots(figsize=(8, 5))
    ax.plot(burnup, adens, marker="o", linewidth=1.6)
    ax.set_xlabel("Burnup (MWd/kgHM)")
    ax.set_ylabel("Atomic density (atom / b-cm)")
    ax.set_title(f"{isotope} in {case} ({mat})")
    ax.grid(True, alpha=0.3)
    fig.tight_layout()
    fig.savefig(out_dir / f"{isotope}_{case}.png", dpi=300, bbox_inches="tight")
    plt.close(fig)


def plot_conversion_efficiency(case, mat, out_dir):
    burnup, th = get_isotope_adens(case, mat, "Th232")
    _, pa = get_isotope_adens(case, mat, "Pa233")
    _, u = get_isotope_adens(case, mat, "U233")
    n = min(len(burnup), len(th), len(pa), len(u))
    th_n = th[:n]
    eta = np.full(n, np.nan)
    valid = th_n > 0
    eta[valid] = (u[:n][valid] + pa[:n][valid]) / th_n[valid]

    fig, ax = plt.subplots(figsize=(8, 5))
    ax.plot(burnup[:n], eta, marker="o", linewidth=2.0, color="C3")
    ax.set_xlabel("Burnup (MWd/kgHM)")
    ax.set_ylabel(r"$(N_{U233}+N_{Pa233})/N_{Th232}$")
    ax.set_title(f"Th conversion efficiency - {case}")
    ax.grid(True, alpha=0.3)
    fig.tight_layout()
    fig.savefig(out_dir / f"Th_conversion_efficiency_{case}.png", dpi=300, bbox_inches="tight")
    plt.close(fig)
    return float(eta[-1]) if np.isfinite(eta[-1]) else float("nan")


def collect_final_state(case, mat):
    """Build a per-case end-of-burnup row."""
    row = {"case": case, "material": mat}
    for iso in SUMMARY_ISOTOPES:
        try:
            _, ad = get_isotope_adens(case, mat, iso)
            row[iso] = float(ad[-1])
        except ValueError:
            row[iso] = float("nan")
    # burnup from the material's own BURNUP array
    row["burnup_end"] = float(read_global_burnup(case)[-1])
    # conversion index
    try:
        _, th = get_isotope_adens(case, mat, "Th232")
        _, pa = get_isotope_adens(case, mat, "Pa233")
        _, u = get_isotope_adens(case, mat, "U233")
        row["eta_end"] = float((u[-1] + pa[-1]) / th[-1]) if th[-1] > 0 else float("nan")
    except ValueError:
        row["eta_end"] = float("nan")
    return row


def main():
    out_dir = ensure_dir(OUTPUT_DIR / "Isotope_evolution")
    cases = discover_cases()
    print(f"Discovered {len(cases)} cases: {cases}\n")

    summary_rows = []
    for case in cases:
        mats = list_materials(case)
        mat = pick_th_material(case, mats)
        if mat is None:
            print(f"[skip] {case}: no Th-bearing material ({mats})")
            continue
        print(f"== {case} -> {mat} ==")
        case_out = ensure_dir(out_dir / case)
        for iso in PER_CASE_ISOTOPES:
            plot_single_isotope(case, mat, iso, case_out)
        eta = plot_conversion_efficiency(case, mat, case_out)
        print(f"  eta_end = {eta:.4e}")
        summary_rows.append(collect_final_state(case, mat))

    if summary_rows:
        df = pd.DataFrame(summary_rows)
        df.to_csv(out_dir / "isotope_evolution_final_burnup.csv", index=False)
        print(f"\nEnd-of-burnup summary: {out_dir / 'isotope_evolution_final_burnup.csv'}")
        with pd.option_context("display.float_format", lambda v: f"{v:.3e}"):
            print(df.to_string(index=False))


if __name__ == "__main__":
    main()
