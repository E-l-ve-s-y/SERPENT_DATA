import re
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

# ==========================================================
# 路径
# ==========================================================

base_dir = Path(
    r"C:\Users\lsy05\serpent_data\results\data_raw\spectrum_scan"
)

output_dir = Path(
    r"C:\Users\lsy05\serpent_data\results\analysis\spectrum_scan"
)

output_dir.mkdir(parents=True, exist_ok=True)

# ==========================================================
# 工况
# ==========================================================

cases = {
    "ρ=0.40": "A008_d040",
    "ρ=0.50": "A008_d050",
    "ρ=0.60": "A008_d060",
    "ρ=0.70": "A008_d070",
    "ρ=0.76": "A008_d076"
}

# ==========================================================
# 提取全部燃耗步数据
# ==========================================================

def extract_all_values(text, variable):

    pattern = (
        rf"{variable}"
        r".*?=\s*\[\s*"
        r"([Ee0-9+\-.]+)"
    )

    matches = re.findall(pattern, text, re.S)

    return np.array([float(x) for x in matches])


# ==========================================================
# 颜色映射
# ==========================================================

cmap = plt.cm.viridis

# ==========================================================
# 开始绘图
# ==========================================================

plt.figure(figsize=(8, 6))

for label, case in cases.items():

    file = base_dir / case / f"{case}.sss_res.m"

    with open(file, "r") as f:
        text = f.read()

    cr = extract_all_values(
        text,
        "CONVERSION_RATIO"
    )

    keff = extract_all_values(
        text,
        "ANA_KEFF"
    )

    n = min(len(cr), len(keff))

    cr = cr[:n]
    keff = keff[:n]

    # ======================================================
    # 画轨迹线
    # ======================================================

    plt.plot(
        cr,
        keff,
        linewidth=1.2,
        alpha=0.6
    )

    # ======================================================
    # 按燃耗顺序着色
    # ======================================================

    burnup_index = np.arange(n)

    scatter = plt.scatter(
        cr,
        keff,
        c=burnup_index,
        cmap=cmap,
        s=45,
        zorder=3
    )

    # ======================================================
    # 起点和终点
    # ======================================================

    plt.scatter(
        cr[0],
        keff[0],
        marker='s',
        s=100,
        edgecolors='black',
        linewidths=1.0,
        label=f"{label} (BU=0)"
    )

    plt.scatter(
        cr[-1],
        keff[-1],
        marker='*',
        s=180,
        edgecolors='black',
        linewidths=1.0
    )

# ==========================================================
# Colorbar
# ==========================================================

cbar = plt.colorbar(scatter)

cbar.set_label(
    "Burnup Step\n(BU=0 → BU=50 MWd/kgHM)"
)

# ==========================================================
# 图形设置
# ==========================================================

plt.xlabel("Conversion Ratio")

plt.ylabel(r"$k_{eff}$")

plt.title(
    r"$k_{eff}$ vs Conversion Ratio During Burnup"
)

plt.grid(True)

plt.legend(
    fontsize=9,
    loc='best'
)

plt.tight_layout()

# ==========================================================
# 保存
# ==========================================================

plt.savefig(
    output_dir /
    "keff_vs_conversion_ratio_burnup.png",
    dpi=600,
    bbox_inches='tight'
)

plt.show()