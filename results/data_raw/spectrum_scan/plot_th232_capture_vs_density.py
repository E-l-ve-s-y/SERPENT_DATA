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
    0.40: "A008_d040",
    0.50: "A008_d050",
    0.60: "A008_d060",
    0.70: "A008_d070",
    0.76: "A008_d076"
}

# ==========================================================
# 提取变量
# ==========================================================

def get_value(text, name):

    pattern = rf"{name}.*?=\s*\[\s*([Ee0-9+.\-]+)"

    match = re.findall(pattern, text, re.DOTALL)

    if match:
        return float(match[0])

    raise ValueError(name)

# ==========================================================
# 读取数据
# ==========================================================

rho = []
thcapt = []

for density, case in cases.items():

    file = base_dir / case / f"{case}.sss_res.m"

    with open(file, "r") as f:
        text = f.read()

    value = get_value(text, "TH232_CAPT")

    rho.append(density)
    thcapt.append(value)

# ==========================================================
# 绘图
# ==========================================================

plt.figure(figsize=(7,5))

plt.plot(rho, thcapt, marker='o')

plt.xlabel("Water Density (g/cm$^3$)")
plt.ylabel("TH232_CAPT")
plt.title("Total Th-232 Capture Rate vs Water Density")

plt.grid(True)

plt.tight_layout()

plt.savefig(
    output_dir / "Th232_capture_vs_density.png",
    dpi=300
)

plt.show()