import re
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pathlib import Path

# ============================================================
# 根目录
# ============================================================

root = Path(
    r"C:\Users\lsy05\serpent_data\results\data_raw\spectrum_scan"
)

output_dir = Path(
    r"C:\Users\lsy05\serpent_data\results\analysis\spectrum_scan"
)

output_dir.mkdir(parents=True, exist_ok=True)

# ============================================================
# 文件路径
# ============================================================

files = {
    "ρ=0.40":
        root / "A008_d040" / "A008_d040.sss_det0.m",

    "ρ=0.50":
        root / "A008_d050" / "A008_d050.sss_det0.m",

    "ρ=0.60":
        root / "A008_d060" / "A008_d060.sss_det0.m",

    "ρ=0.70":
        root / "A008_d070" / "A008_d070.sss_det0.m",

    "ρ=0.76":
        root / "A008_d076" / "A008_d076.sss_det0.m"
}

# ============================================================
# Serpent detector reader
# ============================================================

def read_detector(text, det_name):

    pattern = rf"{det_name}\s*=\s*\[(.*?)\];"

    match = re.search(pattern, text, re.S)

    if match is None:
        raise ValueError(f"Cannot find {det_name}")

    return np.loadtxt(match.group(1).splitlines())


# ============================================================
# 将 20230 行转换成 70 群
# ============================================================

def collapse_detector(det, ngroups=70, npins=289):

    # Serpent detector mean value
    mean = det[:, 10]

    # reshape
    mean = mean.reshape(ngroups, npins)

    # 每个能群对289个pin求和
    group_response = mean.sum(axis=1)

    return group_response

# ============================================================
# 计算各能区贡献
# ============================================================

def analyze_energy_regions(Emid, response):

    total = response.sum()

    thermal = response[Emid < 5e-7].sum()

    epithermal = response[
        (Emid >= 5e-7) &
        (Emid < 1e-4)
    ].sum()

    resonance = response[
        (Emid >= 1e-4) &
        (Emid < 1e-1)
    ].sum()

    fast = response[
        Emid >= 1e-1
    ].sum()

    return {
        "Thermal":
            100 * thermal / total,

        "Epithermal":
            100 * epithermal / total,

        "Resonance":
            100 * resonance / total,

        "Fast":
            100 * fast / total
    }

# ============================================================
# 图1 Absolute Capture Spectrum
# ============================================================

plt.figure(figsize=(8,6))

for label, file in files.items():

    print("Reading:", file)

    with open(file, "r") as f:
        text = f.read()

    det = read_detector(text, "DETth232_cap")

    ene = read_detector(text, "DETth232_capE")

    response = collapse_detector(det)

    Emin = ene[:,0]
    Emax = ene[:,1]

    Emid = np.sqrt(Emin * Emax)

    plt.semilogx(
        Emid,
        response,
        marker='o',
        linewidth=1.5,
        label=label
    )

    result = analyze_energy_regions(
    Emid,
    response
    )

    print(label)

    for k,v in result.items():

        print(
            f"{k:12s}: {100*v:.2f}%"
        )

plt.xlabel("Energy (MeV)")
plt.ylabel("Th-232 Capture Response")
plt.title("Th-232 Capture Spectrum")

plt.grid(True, which='both')
plt.legend()

plt.tight_layout()

savefile = output_dir / "Th232_capture_response.png"
plt.savefig(savefile)

plt.show()

# ============================================================
# 图2 Fractional Contribution
# ============================================================

plt.figure(figsize=(8,6))

for label, file in files.items():

    with open(file, "r") as f:
        text = f.read()

    det = read_detector(text, "DETth232_cap")

    ene = read_detector(text, "DETth232_capE")

    response = collapse_detector(det)

    fraction = response / response.sum()

    Emin = ene[:,0]
    Emax = ene[:,1]

    Emid = np.sqrt(Emin * Emax)

    plt.semilogx(
        Emid,
        fraction,
        marker='o',
        linewidth=1.5,
        label=label
    )

plt.xlabel("Energy (MeV)")
plt.ylabel("Fraction of Total Th Capture")
plt.title("Normalized Th-232 Capture Contribution")

plt.grid(True, which='both')
plt.legend()

plt.tight_layout()

savefile = output_dir / "Th232_capture_fraction.png"
plt.savefig(savefile)

plt.show()

# ============================================================
# 图3 Cumulative Th232 Capture Contribution
# ============================================================

plt.figure(figsize=(8,6))

for label, file in files.items():

    with open(file, "r") as f:
        text = f.read()

    det = read_detector(text, "DETth232_cap")

    ene = read_detector(text, "DETth232_capE")

    response = collapse_detector(det)

    cumulative = np.cumsum(response)

    cumulative /= cumulative[-1]

    Emin = ene[:,0]
    Emax = ene[:,1]

    Emid = np.sqrt(Emin * Emax)

    plt.semilogx(
        Emid,
        cumulative,
        linewidth=2,
        label=label
    )

plt.xlabel("Energy (MeV)")
plt.ylabel("Cumulative Fraction")

plt.title(
    "Cumulative Th-232 Capture Contribution"
)

plt.grid(True, which='both')

plt.legend()

plt.tight_layout()

plt.savefig(
    output_dir /
    "Th232_capture_cumulative.png",
    dpi=300
)

plt.show()

# ============================================================
# Contribution Table
# ============================================================

table_data = {}

for label, file in files.items():

    with open(file, "r") as f:
        text = f.read()

    det = read_detector(
        text,
        "DETth232_cap"
    )

    ene = read_detector(
        text,
        "DETth232_capE"
    )

    response = collapse_detector(det)

    Emin = ene[:,0]
    Emax = ene[:,1]

    Emid = np.sqrt(Emin * Emax)

    result = analyze_energy_regions(
        Emid,
        response
    )

    table_data[label] = result

# ============================================================
# DataFrame
# ============================================================

df = pd.DataFrame(table_data)

df = df.loc[
    [
        "Thermal",
        "Epithermal",
        "Resonance",
        "Fast"
    ]
]

df.index.name = (
    "Contribution to Th-232 Capture (%)"
)

print("\n")
print(df.round(2))

# ============================================================
# 保存为CSV
# ============================================================

csv_file = (
    output_dir /
    "Th232_capture_contribution_table.csv"
)

df.round(2).to_csv(csv_file)

print(
    "\nSaved:",
    csv_file
)

print("Finished.")
print(output_dir)