"""
plot_neutron_spectrum.py
========================

For each *_detN.m file in every case folder, overlay the 70-group
DET1 spectrum from all cases on a single log-x plot, plus the
thermal / resonance / fast fractions in a text summary.

Output: results/analysis/MOX_Th_kaist/kaist/Neutron_spectra/
"""

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

from kaist_utils import OUTPUT_DIR, discover_cases, ensure_dir, read_spectrum


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
    """Save normalized and absolute comparison plots for one detector."""
    if not results:
        return

    for kind, key, ylabel in [
        ("normalized", "flux_norm", "Normalized flux per lethargy"),
        ("absolute", "phi_u", "Flux per lethargy (absolute)"),
    ]:
        fig, ax = plt.subplots(figsize=(10, 6))
        for case, data in results.items():
            ax.semilogx(data["E_mid"], data[key], marker="o", markersize=3,
                        linewidth=1.2, label=case)
        ax.set_xlabel("Energy (MeV)")
        ax.set_ylabel(ylabel)
        ax.set_title(f"DET{det_num} - {kind} neutron spectrum (MOX_Th_kaist)")
        ax.grid(True, which="both", alpha=0.3)
        ax.legend(loc="best", fontsize=8)
        fig.tight_layout()
        fig.savefig(out_dir / f"{kind}_detector_{det_num}.png", dpi=300, bbox_inches="tight")
        plt.close(fig)


def main():
    out_dir = ensure_dir(OUTPUT_DIR / "Neutron_spectra")
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
