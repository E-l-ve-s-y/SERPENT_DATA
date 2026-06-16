import re
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

# ==================================================
# 路径
# ==================================================

base_dir = Path(
    r"C:\Users\lsy05\serpent_data\results\data_raw\MOX_Th_kaist\kaist"
)

# ==================================================
# 只分析M87
# ==================================================

selected_cases = []

for folder in base_dir.iterdir():

    if not folder.is_dir():
        continue

    if folder.name.startswith("M43"):

        selected_cases.append(folder)

selected_cases = sorted(selected_cases)

print("发现工况：")

for c in selected_cases:

    print(c.name)

# ==================================================
# 提取变量
# ==================================================

def extract_all_values(text, variable):

    pattern = (
        rf"{variable}"
        r".*?=\s*\[\s*"
        r"([Ee0-9+\-.]+)"
    )

    matches = re.findall(
        pattern,
        text,
        re.S
    )

    return np.array(
        [float(x) for x in matches]
    )

# ==================================================
# DEP读取
# ==================================================

def read_array(text, var_name):

    pattern = rf"{var_name}\s*=\s*\[(.*?)\];"

    match = re.search(
        pattern,
        text,
        re.S
    )

    if match is None:

        raise ValueError(
            f"{var_name} not found"
        )

    return np.fromstring(
        match.group(1),
        sep=" "
    )


# ==================================================
# 提取核素原子密度
# ==================================================

def get_isotope_adens(
    text,
    isotope_name
):

    burnup = read_array(
        text,
        "MAT_fuel_BURNUP"
    )

    pattern = (
        r"MAT_fuel_ADENS"
        r"\s*=\s*\[(.*?)\];"
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

    for line in block.splitlines():

        if f"% {isotope_name}" in line:

            values = np.fromstring(
                line.split("%")[0],
                sep=" "
            )

            return burnup, values

    raise ValueError(
        f"{isotope_name} not found"
    )

# ==================================================
# 绘图
# ==================================================

plt.figure(figsize=(8,6))

cmap = plt.cm.viridis

scatter = None

for case_dir in selected_cases:

    # 自动寻找res文件

    res_files = list(
        case_dir.glob("*_res.m")
    )

    if not res_files:

        res_files = list(
            case_dir.glob("*.sss_res.m")
        )

    if not res_files:

        print(
            f"跳过 {case_dir.name}"
        )
        continue

    res_file = res_files[0]

    print(
        f"读取 {res_file.name}"
    )

    with open(
        res_file,
        "r",
        encoding="utf-8",
        errors="ignore"
    ) as f:

        text = f.read()

    cr = extract_all_values(
        text,
        "CONVERSION_RATIO"
    )

    keff = extract_all_values(
        text,
        "ANA_KEFF"
    )

    n = min(
        len(cr),
        len(keff)
    )

    cr = cr[:n]

    keff = keff[:n]

    plt.plot(
        cr,
        keff,
        linewidth=1.5,
        alpha=0.8
    )

    scatter = plt.scatter(
        cr,
        keff,
        c=np.arange(n),
        cmap=cmap,
        s=40
    )

    plt.scatter(
        cr[0],
        keff[0],
        marker='s',
        s=80,
        label=case_dir.name
    )

    plt.scatter(
        cr[-1],
        keff[-1],
        marker='*',
        s=150
    )

    dep_files = list(
        case_dir.glob("*_dep.m")
    )

    if not dep_files:

        dep_files = list(
            case_dir.glob("*.sss_dep.m")
        )

    if not dep_files:

        print(
            f"{case_dir.name} 无dep文件"
        )

        continue

    dep_file = dep_files[0]

# ==================================================
# 图形
# ==================================================

plt.xlabel(
    "Conversion Ratio"
)

plt.ylabel(
    r"$k_{eff}$"
)

plt.title(
    "M87 Series"
)

plt.grid(True)

plt.legend()

if scatter:

    cbar = plt.colorbar(
        scatter
    )

    cbar.set_label(
        "Burnup Step"
    )

plt.tight_layout()

plt.show()