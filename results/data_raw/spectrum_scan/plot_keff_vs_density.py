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

rho = []
keff = []
err = []

for density, case in cases.items():

    file = base_dir / case / f"{case}.sss_res.m"

    with open(file) as f:
        text = f.read()

    pattern = (
        r"ANA_KEFF.*?=\s*\[\s*"
        r"([Ee0-9+.\-]+)\s+"
        r"([Ee0-9+.\-]+)"
    )

    m = re.search(pattern,text,re.S)

    if m is None:
        raise ValueError(case)

    rho.append(density)

    keff.append(float(m.group(1)))

    err.append(float(m.group(2)))

plt.figure(figsize=(7,5))

plt.errorbar(
    rho,
    keff,
    yerr=err,
    marker='o',
    capsize=4
)

plt.xlabel("Water Density (g/cm$^3$)")

plt.ylabel(r"$k_{eff}$")

plt.title(r"$k_{eff}$ vs Water Density")

plt.grid(True)

plt.tight_layout()

plt.savefig(
    output_dir / "keff_vs_density.png",
    dpi=300
)

plt.show()