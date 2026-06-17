"""
plot_neutron_spectrum.py
========================

For each *_detN.m file in every case folder, overlay the 70-group
DET1 spectrum from all cases on a single log-x plot, plus the
thermal / resonance / fast fractions in a text summary.

The per-detector view is split into three family-specific plots
(M87, M70, M43) that mirror the colour scheme used in
plot_th232_capture_response.py: Blues for M43, Greens for M70,
Oranges for M87 (lightest shade = lowest Th fraction, darkest =
highest).  Each detector / kind combination therefore produces
three PNGs (M87 / M70 / M43) instead of one combined plot.

Output: results/analysis/MOX_Th_kaist/kaist/Neutron_spectra/
"""

import re
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

from kaist_utils import OUTPUT_DIR, discover_cases, ensure_dir, read_spectrum

# Family -> colormap name.  Same convention as plot_th232_capture_response.py
# and plot_reactivity_breeding_tradeoff.py: M43=Blues, M70=Greens, M87=Oranges.
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
    highest, matching the gradient convention in the other plots.
    """
    cmap = plt.colormaps[FAMILY_COLORMAPS[family]]
    members = sorted(
        [c for c in cases if get_family(c) == family],
        key=lambda c: int(c.split("-")[1]),
    )
    n = max(1, len(members) - 1)
    return {c: cmap(0.3 + 0.6 * i / n) for i, c in enumerate(members)}


# Process detector 0..25
DETECTORS = range(0, 26)
# Energy region boundaries (MeV)
THERMAL_LIMIT = 6.25e-7   # 0.625 eV
FAST_LIMIT = 1.0e-1        # 100 keV


def fractions(phi_u, E_mid):
    """Return (thermal, resonance, fast) percentages."""
    thermal = phi_u[E_mid < THERMAL_LIMIT].sum()
    resonance = phi_u[(E_mid >= THERMAL_LIMIT) & (E_mid < FAST_LIMIT)].sum()
    fast = phi_u[E_mid >= FAST_LIMIT].sum()
    total = thermal + resonance + fast
    if total == 0:
        return 0.0, 0.0, 0.0
    return 100 * thermal / total, 100 * resonance / total, 100 * fast / total


def plot_detector(det_num, results, out_dir):
    """Save family-split normalized and absolute comparison plots for one detector.

    For each of (normalized, absolute), generate one PNG per family
    (M87, M70, M43) using the family colormap gradient.  Old combined
    PNGs from previous runs are removed by `cleanup_old_plots()` in
    `main()`.
    """
    if not results:
        return

    for kind, key, ylabel in [
        ("normalized", "flux_norm", "Normalized flux per lethargy"),
        ("absolute", "phi_u", "Flux per lethargy (absolute)"),
    ]:
        for fam in ["M87", "M70", "M43"]:
            palette = family_palette(fam, results.keys())
            if not palette:
                continue
            fig, ax = plt.subplots(figsize=(10, 6))
            for case, color in palette.items():
                data = results[case]
                ax.semilogx(data["E_mid"], data[key], marker="o", markersize=3,
                            linewidth=1.2, color=color, label=case)
            ax.set_xlabel("Energy (MeV)")
            ax.set_ylabel(ylabel)
            ax.set_title(f"DET{det_num} - {kind} neutron spectrum ({fam} family)")
            ax.grid(True, which="both", alpha=0.3)
            ax.legend(loc="best", fontsize=8)
            fig.tight_layout()
            out_path = out_dir / f"{kind}_detector_{det_num}_{fam}.png"
            fig.savefig(out_path, dpi=300, bbox_inches="tight")
            plt.close(fig)


def cleanup_old_plots(out_dir):
    """Remove combined PNGs from the previous (pre-split) plot layout.

    The new layout is `{kind}_detector_{n}_{fam}.png`; the old layout was
    `{kind}_detector_{n}.png` (no family suffix).  Anything that does not
    match the new family-suffix pattern is considered obsolete.
    """
    removed = 0
    for prefix in ("normalized_detector_", "absolute_detector_"):
        for old_path in out_dir.glob(f"{prefix}*.png"):
            if not re.search(r"_M\d+\.png$", old_path.name):
                old_path.unlink()
                removed += 1
    if removed:
        print(f"  Cleaned up {removed} old combined PNG(s)")


def main():
    out_dir = ensure_dir(OUTPUT_DIR / "Neutron_spectra")
    cleanup_old_plots(out_dir)
    log_path = Path(__file__).resolve().parent / "neutron_spectrum.log"
    cases = discover_cases()
    print(f"Discovered {len(cases)} cases: {cases}")

    # Tee prints to a log file
    log_fh = log_path.open("w", encoding="utf-8")
    original_stdout = sys.stdout
    sys.stdout = log_fh
    try:
        print(f"cases: {cases}")
        print(f"detectors: DET{min(DETECTORS)} - DET{max(DETECTORS)}")
        print(f"output: {out_dir}\n")

        all_fractions = {}
        for det_num in DETECTORS:
            results = {}
            for case in cases:
                spec = read_spectrum(case, det_num, "DET1")
                if spec is not None:
                    results[case] = spec
            if not results:
                print(f"DET{det_num}: no data, skip")
                continue
            print(f"DET{det_num}: {len(results)} cases -> plotting")
            plot_detector(det_num, results, out_dir)
            all_fractions[det_num] = {c: fractions(d["phi_u"], d["E_mid"]) for c, d in results.items()}

        # Region-fraction summary
        with (out_dir / "spectrum_summary.txt").open("w", encoding="utf-8") as f:
            f.write("Thermal / Resonance / Fast fractions (%) per detector and case\n")
            f.write("=" * 80 + "\n")
            for det_num, results in all_fractions.items():
                f.write(f"\nDET{det_num}\n{'-'*60}\n")
                f.write(f"{'case':<12}{'thermal':>12}{'resonance':>14}{'fast':>12}\n")
                for case, (t, r, fa) in results.items():
                    f.write(f"{case:<12}{t:>11.2f}%{r:>13.2f}%{fa:>11.2f}%\n")
        print(f"\nSummary: {out_dir / 'spectrum_summary.txt'}")
    finally:
        sys.stdout = original_stdout
        log_fh.close()

    print(f"Done. Log: {log_path}")


if __name__ == "__main__":
    main()
