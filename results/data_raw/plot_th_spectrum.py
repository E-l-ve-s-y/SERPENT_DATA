import re
import numpy as np
import matplotlib.pyplot as plt
import os
from pathlib import Path
from datetime import datetime

# ==================================================
# 用户配置区
# ==================================================

BASE_DIR = Path(
    r"C:\Users\lsy05\serpent_data\results\data_raw\MOX_Th_kaist\kaist"
)

GROUP = "M43"

DETECTORS = [
    0,
    5,
    10,
    15,
    19,
    25
]

# ==================================================
# 自动发现工况
# ==================================================

FOLDERS = []

for folder in BASE_DIR.iterdir():

    if not folder.is_dir():
        continue

    if folder.name.startswith(GROUP):

        FOLDERS.append(folder.name)

FOLDERS = sorted(
    FOLDERS,
    key=lambda x: int(x.split("-")[1])
)

# 自动加入基准工况

for folder in BASE_DIR.iterdir():

    if not folder.is_dir():
        continue

    if folder.name.lower() == "mox1":

        FOLDERS.insert(0, folder.name)

        break

print("\n发现工况：")

for item in FOLDERS:

    print(item)

# ==================================================
# 输出目录
# ==================================================

OUTPUT_DIR = (
    BASE_DIR.parents[1]
    / "analysis"
    / GROUP
)

OUTPUT_DIR.mkdir(
    parents=True,
    exist_ok=True
)

# ==================================================
# 显示名称
# ==================================================

DISPLAY_NAMES = {}

for name in FOLDERS:

    if name.lower() == "mox1":

        DISPLAY_NAMES[name] = "Reference"

    else:

        DISPLAY_NAMES[name] = name

# ==================================================
# 颜色
# ==================================================

colors = plt.cm.tab10.colors

# ==================================================
# 读取Serpent DET文件
# ==================================================

def read_serpent_det_file(file_path):

    with open(
        file_path,
        "r",
        encoding="utf-8",
        errors="ignore"
    ) as f:

        text = f.read()

    det1_match = re.search(
        r"DET1\s*=\s*\[(.*?)\];",
        text,
        re.S
    )

    det1e_match = re.search(
        r"DET1E\s*=\s*\[(.*?)\];",
        text,
        re.S
    )

    if det1_match is None:

        raise ValueError("DET1 not found")

    if det1e_match is None:

        raise ValueError("DET1E not found")

    DET1 = np.loadtxt(
        det1_match.group(1).splitlines()
    )

    DET1E = np.loadtxt(
        det1e_match.group(1).splitlines()
    )

    n_groups = len(DET1E)

    n_rows = DET1.shape[0]

    n_cols = DET1.shape[1]

    if n_rows == n_groups:

        phi_u = DET1[:,10]

    elif n_rows % n_groups == 0:

        n_sets = n_rows // n_groups

        reshaped = DET1.reshape(
            n_groups,
            n_sets,
            n_cols
        )

        DET1_sum = np.sum(
            reshaped,
            axis=1
        )

        phi_u = DET1_sum[:,10]

    else:

        raise ValueError(
            f"DET1 rows={n_rows}, groups={n_groups}"
        )

    E_mid = DET1E[:,2]

    flux_norm = phi_u / np.max(phi_u)

    return E_mid, phi_u, flux_norm

# ==================================================
# 读取一个探测器的所有工况
# ==================================================

def analyze_detector(detector_num):

    results = {}

    print(
        f"\n===== DET{detector_num} ====="
    )

    for folder in FOLDERS:

        folder_path = (
            BASE_DIR / folder
        )

        det_files = list(
            folder_path.glob(
                f"*det{detector_num}.m"
            )
        )

        if not det_files:

            print(
                f"{folder}: 文件不存在"
            )

            continue

        file_path = det_files[0]

        try:

            E_mid, phi_u, flux_norm = (
                read_serpent_det_file(
                    file_path
                )
            )

            results[folder] = {

                "E_mid":E_mid,

                "phi_u":phi_u,

                "flux_norm":flux_norm,

                "label":DISPLAY_NAMES[
                    folder
                ]
            }

            print(
                f"{folder}: OK"
            )

        except Exception as e:

            print(
                f"{folder}: {e}"
            )

    return results

# ==================================================
# 能区统计
# ==================================================

def print_energy_region_fractions(
    results,
    detector_num
):

    thermal_limit = 6.25e-7

    fast_limit = 1e-1

    print(
        f"\nDET{detector_num} 能区份额"
    )

    print(
        "-"*60
    )

    for case,data in results.items():

        E = data["E_mid"]

        phi = data["phi_u"]

        thermal = np.sum(
            phi[E < thermal_limit]
        )

        resonance = np.sum(
            phi[
                (E >= thermal_limit)
                &
                (E < fast_limit)
            ]
        )

        fast = np.sum(
            phi[E >= fast_limit]
        )

        total = (
            thermal
            + resonance
            + fast
        )

        print(
            f"{case:10s}"
            f" Thermal={thermal/total*100:6.2f}%"
            f" Resonance={resonance/total*100:6.2f}%"
            f" Fast={fast/total*100:6.2f}%"
        )

# ==================================================
# 绘图
# ==================================================

def plot_detector(
    results,
    detector_num
):

    if not results:

        return

    # -------------------------
    # Normalized
    # -------------------------

    plt.figure(
        figsize=(10,8)
    )

    for i,(case,data) in enumerate(
        results.items()
    ):

        plt.semilogx(
            data["E_mid"],
            data["flux_norm"],
            marker='o',
            ms=3,
            lw=1.5,
            label=data["label"],
            color=colors[
                i % len(colors)
            ]
        )

    plt.xlabel(
        "Energy (MeV)"
    )

    plt.ylabel(
        "Normalized Flux"
    )

    plt.title(
        f"{GROUP} DET{detector_num}"
    )

    plt.grid(True)

    plt.legend()

    plt.tight_layout()

    plt.savefig(
        OUTPUT_DIR /
        f"DET{detector_num}_normalized.png",
        dpi=300
    )

    plt.close()

    # -------------------------
    # Absolute
    # -------------------------

    plt.figure(
        figsize=(10,8)
    )

    for i,(case,data) in enumerate(
        results.items()
    ):

        plt.semilogx(
            data["E_mid"],
            data["phi_u"],
            marker='o',
            ms=3,
            lw=1.5,
            label=data["label"],
            color=colors[
                i % len(colors)
            ]
        )

    plt.xlabel(
        "Energy (MeV)"
    )

    plt.ylabel(
        "Flux per lethargy"
    )

    plt.title(
        f"{GROUP} DET{detector_num}"
    )

    plt.grid(True)

    plt.legend()

    plt.tight_layout()

    plt.savefig(
        OUTPUT_DIR /
        f"DET{detector_num}_absolute.png",
        dpi=300
    )

    plt.close()

# ==================================================
# 主程序
# ==================================================

def main():

    print(
        "\n开始分析..."
    )

    print(
        f"GROUP = {GROUP}"
    )

    print(
        f"输出目录 = {OUTPUT_DIR}"
    )

    for det_num in DETECTORS:

        results = analyze_detector(
            det_num
        )

        if not results:

            continue

        print_energy_region_fractions(
            results,
            det_num
        )

        plot_detector(
            results,
            det_num
        )

    print(
        "\n分析完成"
    )

    print(
        f"结果保存在：\n{OUTPUT_DIR}"
    )

if __name__ == "__main__":

    main()