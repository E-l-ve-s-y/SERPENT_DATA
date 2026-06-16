"""
plot_reactivity_breeding_tradeoff.py
====================================

For every case folder under MOX_Th_kaist/kaist, plot keff vs.
conversion ratio during burnup, plus a small text summary.

Output: results/analysis/MOX_Th_kaist/kaist/Reactivity_breeding/
"""

import matplotlib.pyplot as plt
import numpy as np

from kaist_utils import OUTPUT_DIR, discover_cases, ensure_dir, read_res_data


def main():
    out = ensure_dir(OUTPUT_DIR / "Reactivity_breeding")
    cases = discover_cases()
    print(f"Discovered {len(cases)} cases: {cases}")

    fig, ax = plt.subplots(figsize=(9, 7))
    summary = []
    
    # 使用更鲜明的颜色循环
    colors = plt.cm.tab10(np.linspace(0, 1, len(cases)))
    # 或者使用 tab20 获得更多颜色
    # colors = plt.cm.tab20(np.linspace(0, 1, len(cases)))

    for idx, case in enumerate(cases):
        try:
            burnup, cr, keff = read_res_data(case)
        except Exception as e:
            print(f"  [skip] {case}: {e}")
            continue
        
        n = min(len(burnup), len(cr), len(keff))
        burnup, cr, keff = burnup[:n], cr[:n], keff[:n]
        if n < 2:
            continue

        color = colors[idx % len(colors)]
        
        # 每个case用不同颜色，渐变色显示burnup
        ax.plot(cr, keff, color=color, linewidth=1.5, alpha=0.7, label=case)
        
        # 散点用深浅渐变
        sc = ax.scatter(cr, keff, c=burnup, cmap="plasma", 
                       s=30, zorder=3, edgecolors=color, linewidth=0.5)
        
        # Start (圆) and end (星) markers
        ax.scatter(cr[0], keff[0], marker="o", s=100, 
                  facecolors=color, edgecolors="black", linewidths=0.8, zorder=4)
        ax.scatter(cr[-1], keff[-1], marker="*", s=150, 
                  facecolors=color, edgecolors="black", linewidths=0.8, zorder=4)

        summary.append((case, burnup[0], burnup[-1], cr[0], cr[-1], keff[0], keff[-1]))

    # keff = 1 reference
    ax.axhline(1.0, color="black", linestyle="--", linewidth=0.7, alpha=0.6)
    
    # 只使用一个colorbar（从最后一个sc获取）
    cbar = fig.colorbar(sc, ax=ax, pad=0.02)
    cbar.set_label("Burnup (MWd/kgHM)")

    ax.set_xlabel("Conversion Ratio")
    ax.set_ylabel(r"$k_{eff}$")
    ax.set_title("keff vs. Conversion Ratio during Burnup (MOX_Th_kaist)")
    ax.grid(True, alpha=0.3)
    ax.legend(loc="best", fontsize=8, ncol=2)  # ncol=2让图例更紧凑
    fig.tight_layout()

    fig.savefig(out / "keff_vs_conversion_ratio_burnup.png", dpi=300, bbox_inches="tight")
    plt.close(fig)
    print(f"Saved: {out / 'keff_vs_conversion_ratio_burnup.png'}")

    # Text summary (保持不变)
    if summary:
        path = out / "reactivity_breeding_summary.txt"
        with path.open("w", encoding="utf-8") as f:
            f.write("keff vs. Conversion Ratio - End-of-cycle summary\n")
            f.write("=" * 75 + "\n")
            f.write(f"{'case':<10}{'BU0':>10}{'BUend':>10}{'CR0':>10}{'CRend':>10}{'keff0':>10}{'keff_end':>12}\n")
            f.write("-" * 75 + "\n")
            for row in summary:
                case, bu0, bue, cr0, cre, k0, ke = row
                f.write(f"{case:<10}{bu0:>10.3f}{bue:>10.3f}{cr0:>10.4f}{cre:>10.4f}{k0:>10.4f}{ke:>12.4f}\n")
        print(f"Saved: {path}")


if __name__ == "__main__":
    main()