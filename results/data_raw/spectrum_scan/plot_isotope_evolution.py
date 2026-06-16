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
# 读取数组
# ==========================================================

def read_array(text, var_name):

    pattern = rf"{var_name}\s*=\s*\[(.*?)\];"

    match = re.search(pattern, text, re.S)

    if match is None:
        raise ValueError(f"Cannot find {var_name}")

    data = np.fromstring(
        match.group(1),
        sep=' '
    )

    return data


# ==========================================================
# 提取指定核素ADENS
# ==========================================================

def get_isotope_adens(text, isotope_name):

    burnup = read_array(
        text,
        "MAT_fuel_BURNUP"
    )

    pattern = (
        r"MAT_fuel_ADENS\s*=\s*\[(.*?)\];"
    )

    match = re.search(
        pattern,
        text,
        re.S
    )

    if match is None:
        raise ValueError(
            "MAT_fuel_ADENS not found"
        )

    block = match.group(1)

    lines = block.splitlines()

    target_line = None

    for line in lines:

        if f"% {isotope_name}" in line:

            target_line = line

            break

    if target_line is None:

        raise ValueError(
            f"{isotope_name} not found"
        )

    target_line = target_line.split("%")[0]

    adens = np.fromstring(
        target_line,
        sep=' '
    )

    return burnup, adens


# ==========================================================
# 绘制单个核素
# ==========================================================

def plot_isotope(isotope):

    plt.figure(figsize=(8,6))

    for label, case in cases.items():

        dep_file = (
            base_dir /
            case /
            f"{case}.sss_dep.m"
        )

        with open(dep_file, "r") as f:
            text = f.read()

        burnup, adens = get_isotope_adens(
            text,
            isotope
        )

        plt.plot(
            burnup,
            adens,
            marker='o',
            linewidth=1.8,
            label=label
        )

    plt.xlabel(
        "Burnup (MWd/kgHM)"
    )

    plt.ylabel(
        "Atomic Density (atom/b-cm)"
    )

    plt.title(
        f"{isotope} Atomic Density Evolution"
    )

    plt.grid(True)

    plt.legend()

    plt.tight_layout()

    plt.savefig(
        output_dir /
        f"{isotope}_adens_vs_burnup.png",
        dpi=300
    )

    plt.show()

    print(
        isotope,
        len(burnup),
        len(adens)
    )

# ==========================================================
# Th -> U233 转化效率
# η = (U233 + Pa233) / Th232
# ==========================================================

def plot_th_conversion_efficiency():

    plt.figure(figsize=(8,6))

    for label, case in cases.items():

        dep_file = (
            base_dir /
            case /
            f"{case}.sss_dep.m"
        )

        with open(dep_file, "r") as f:
            text = f.read()

        burnup, th232 = get_isotope_adens(
            text,
            "Th232"
        )

        _, pa233 = get_isotope_adens(
            text,
            "Pa233"
        )

        _, u233 = get_isotope_adens(
            text,
            "U233"
        )

        eta = (
            u233 + pa233
        ) / th232

        plt.plot(
            burnup,
            eta,
            marker='o',
            linewidth=2,
            label=label
        )

    plt.xlabel(
        "Burnup (MWd/kgHM)"
    )

    plt.ylabel(
        r"$(N_{U233}+N_{Pa233})/N_{Th232}$"
    )

    plt.title(
        "Thorium Conversion Efficiency"
    )

    plt.grid(True)

    plt.legend()

    plt.tight_layout()

    plt.savefig(
        output_dir /
        "Th_conversion_efficiency.png",
        dpi=300
    )

    plt.show()

# ==========================================================
# 主程序
# ==========================================================

plot_isotope("Th232")

plot_isotope("Pa233")

plot_isotope("U233")

plot_th_conversion_efficiency()

print("\nFinal Burnup Conversion Index")

for label, case in cases.items():

    dep_file = (
        base_dir /
        case /
        f"{case}.sss_dep.m"
    )

    with open(dep_file) as f:
        text = f.read()

    _, th232 = get_isotope_adens(text,"Th232")
    _, pa233 = get_isotope_adens(text,"Pa233")
    _, u233  = get_isotope_adens(text,"U233")

    eta = (u233 + pa233)/th232

    print(
        f"{label:8s}  "
        f"{eta[-1]:.6f}"
    )

print("Finished.")