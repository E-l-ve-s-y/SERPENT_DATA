import re
import matplotlib.pyplot as plt
from pathlib import Path

base_dir = Path(
    r"C:\Users\lsy05\serpent_data\results\data_raw\spectrum_scan"
)

output_dir = Path(
    r"C:\Users\lsy05\serpent_data\results\analysis\spectrum_scan"
)

cases = {
    0.40: "A008_d040",
    0.50: "A008_d050",
    0.60: "A008_d060",
    0.70: "A008_d070",
    0.76: "A008_d076"
}

def get_value(text, name):

    pattern = (
        rf"{name}"
        r".*?=\s*\[\s*"
        r"([Ee0-9+\-.]+)"
    )

    match = re.search(pattern, text, re.S)

    if match:
        return float(match.group(1))

    raise ValueError(f"{name} not found")

rho = []
cr = []

for density, case in cases.items():

    file = base_dir / case / f"{case}.sss_res.m"

    with open(file) as f:
        text = f.read()

    value = get_value(text,"CONVERSION_RATIO")

    rho.append(density)
    cr.append(value)

plt.figure(figsize=(7,5))

plt.plot(rho, cr, marker='o')

plt.xlabel("Water Density (g/cm$^3$)")
plt.ylabel("Conversion Ratio")

plt.title("Conversion Ratio vs Water Density")

plt.grid(True)

plt.tight_layout()

plt.savefig(
    output_dir / "Conversion_ratio_vs_density.png",
    dpi=300
)

plt.show()