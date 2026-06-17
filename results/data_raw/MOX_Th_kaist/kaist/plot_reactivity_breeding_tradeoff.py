"""
plot_reactivity_breeding_tradeoff.py
====================================

For every case folder under MOX_Th_kaist/kaist, plot keff vs.
conversion ratio during burnup, plus a small text summary.

The keff-vs-CR view is split into three family-specific plots
(M87, M70, M43) that share the same axes ranges and the same
burnup colour-scale so the plots are directly comparable across
families.  Each family uses its own colormap gradient
(Blues for M43, Greens for M70, Oranges for M87).

Output: results/analysis/MOX_Th_kaist/kaist/Reactivity_breeding/
"""

import re

import matplotlib.pyplot as plt
import numpy as np

from kaist_utils import OUTPUT_DIR, discover_cases, ensure_dir, read_res_data

# Family -> colormap name.  Same convention as plot_th232_capture_response.py
# and plot_isotope_comparison.py: M43=Blues, M87=Oranges; M70=Greens is the
# natural third in matplotlib's standard sequential family.
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
    highest - matching the gradient convention in the other plots.
    """
    cmap = plt.colormaps[FAMILY_COLORMAPS[family]]
    members = sorted(
        [c for c in cases if get_family(c) == family],
        key=lambda c: int(c.split("-")[1]),
    )
    n = max(1, len(members) - 1)
    return {c: cmap(0.3 + 0.6 * i / n) for i, c in enumerate(members)}


def collect_case_data(cases):
    """Return {case: (burnup, cr, keff)} for all valid cases."""
    data = {}
    for case in cases:
        try:
            burnup, cr, keff = read_res_data(case)
        except Exception as e:
            print(f"  [skip] {case}: {e}")
            continue
        n = min(len(burnup), len(cr), len(keff))
        if n < 2:
            continue
        data[case] = (burnup[:n], cr[:n], keff[:n])
    return data


def global_axes_limits(data, pad_frac=0.05):
    """Return (xlim, ylim) covering all cases with fractional padding."""
    cr_all = np.concatenate([cr for _, cr, _ in data.values()])
    keff_all = np.concatenate([keff for _, _, keff in data.values()])
    xmin, xmax = float(cr_all.min()), float(cr_all.max())
    ymin, ymax = float(keff_all.min()), float(keff_all.max())
    xpad = pad_frac * (xmax - xmin) if xmax > xmin else 0.01
    ypad = pad_frac * (ymax - ymin) if ymax > ymin else 0.01
    return (xmin - xpad, xmax + xpad), (ymin - ypad, ymax + ypad)


def global_burnup_range(data):
    """Return (vmin, vmax) for the burnup colour scale (plasma)."""
    bu_all = np.concatenate([bu for bu, _, _ in data.values()])
    return (float(bu_all.min()), float(bu_all.max()))


def plot_family(family, data, xlim, ylim, bu_range, out_dir):
    """Generate one keff-vs-CR plot for a single family.

    Returns the path to the saved PNG, or None if the family has no cases.
    """
    members = [c for c in data if get_family(c) == family]
    if not members:
        print(f"  [skip] No cases for family {family}")
        return None

    palette = family_palette(family, data.keys())

    fig, ax = plt.subplots(figsize=(9, 7))
    sc_last = None
    for case in members:
        burnup, cr, keff = data[case]
        color = palette[case]

        ax.plot(cr, keff, color=color, linewidth=1.5, alpha=0.7, label=case)
        sc_last = ax.scatter(
            cr, keff, c=burnup, cmap="plasma",
            s=30, zorder=3, edgecolors=color, linewidth=0.5,
            vmin=bu_range[0], vmax=bu_range[1],
        )
        # Start (circle) and end (star) markers
        ax.scatter(cr[0], keff[0], marker="o", s=100,
                   facecolors=color, edgecolors="black", linewidths=0.8, zorder=4)
        ax.scatter(cr[-1], keff[-1], marker="*", s=150,
                   facecolors=color, edgecolors="black", linewidths=0.8, zorder=4)

    # keff = 1 reference
    ax.axhline(1.0, color="black", linestyle="--", linewidth=0.7, alpha=0.6)

    if sc_last is not None:
        cbar = fig.colorbar(sc_last, ax=ax, pad=0.02)
        cbar.set_label("Burnup (MWd/kgHM)")

    ax.set_xlim(*xlim)
    ax.set_ylim(*ylim)
    ax.set_xlabel("Conversion Ratio")
    ax.set_ylabel(r"$k_{eff}$")
    ax.set_title(f"keff vs. Conversion Ratio during Burnup - {family} family")
    ax.grid(True, alpha=0.3)
    ax.legend(loc="best", fontsize=8, ncol=2)
    fig.tight_layout()

    out_path = out_dir / f"keff_vs_conversion_ratio_burnup_{family}.png"
    fig.savefig(out_path, dpi=300, bbox_inches="tight")
    plt.close(fig)
    print(f"  Saved: {out_path.name}")
    return out_path


def write_summary(summary, out_dir):
    """Write the end-of-cycle text summary (unchanged from the original)."""
    if not summary:
        return
    path = out_dir / "reactivity_breeding_summary.txt"
    with path.open("w", encoding="utf-8") as f:
        f.write("keff vs. Conversion Ratio - End-of-cycle summary\n")
        f.write("=" * 75 + "\n")
        f.write(f"{'case':<10}{'BU0':>10}{'BUend':>10}{'CR0':>10}{'CRend':>10}{'keff0':>10}{'keff_end':>12}\n")
        f.write("-" * 75 + "\n")
        for row in summary:
            case, bu0, bue, cr0, cre, k0, ke = row
            f.write(f"{case:<10}{bu0:>10.3f}{bue:>10.3f}{cr0:>10.4f}{cre:>10.4f}{k0:>10.4f}{ke:>12.4f}\n")
    print(f"Saved: {path}")


def main():
    out = ensure_dir(OUTPUT_DIR / "Reactivity_breeding")
    cases = discover_cases()
    print(f"Discovered {len(cases)} cases: {cases}")

    data = collect_case_data(cases)
    if not data:
        print("No valid case data found.")
        return

    # Global axes limits and burnup range so all three family plots are
    # visually comparable on a common scale.
    xlim, ylim = global_axes_limits(data)
    bu_range = global_burnup_range(data)
    print(f"  Shared xlim (CR): {xlim}")
    print(f"  Shared ylim (keff): {ylim}")
    print(f"  Shared burnup range: {bu_range}")

    # One plot per family, in the order the user specified: M87, M70, M43.
    for fam in ["M87", "M70", "M43"]:
        plot_family(fam, data, xlim, ylim, bu_range, out)

    # Text summary (unchanged)
    summary = [
        (case, bu[0], bu[-1], cr[0], cr[-1], k[0], k[-1])
        for case, (bu, cr, k) in data.items()
    ]
    write_summary(summary, out)


if __name__ == "__main__":
    main()