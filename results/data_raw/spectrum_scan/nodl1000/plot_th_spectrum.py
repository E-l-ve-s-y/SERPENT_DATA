import re
import numpy as np
import matplotlib.pyplot as plt

# ============================
# Serpent det0 文件路径
# ============================

file_path = r"C:\Users\lsy05\serpent_data\results\data_raw\spectrum_scan\nodl1000\A008_d076.sss_det0.m"

# ============================
# 读取 DET1
# ============================

with open(file_path, "r") as f:
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

# ----------------------------
# 转numpy
# ----------------------------

DET1 = np.loadtxt(det1_match.group(1).splitlines())
DET1E = np.loadtxt(det1e_match.group(1).splitlines())

# ============================
# 提取数据
# ============================

phi_u = DET1[:,10]     # 第11列

err = DET1[:,11]

E_low  = DET1E[:,0]
E_high = DET1E[:,1]
E_mid  = DET1E[:,2]

# ============================
# 微分通量
# ============================

Ephi = phi_u

# ============================
# 归一化
# ============================

flux_norm = phi_u / np.max(phi_u)

# ============================
# 图1 Normalized Flux per Lethargy
# ============================

plt.figure(figsize=(8,6))

plt.loglog(E_mid, flux_norm, 'o-')

plt.xlabel("Energy (MeV)")
plt.ylabel("Normalized Flux per Lethargy")

plt.title("70-group Normalized Flux")

plt.grid(True, which='both')

# ============================
# 图2 Flux per lethargy
# ============================

plt.figure(figsize=(8,6))

plt.semilogx(
    E_mid,
    phi_u,
    'o-',
    linewidth=1.5
)

plt.xlabel("Neutron Energy (MeV)")

plt.ylabel("Neutron Flux per Unit Lethargy")

plt.title("Neutron Spectrum")

plt.grid(True)

# ============================
# 热区/共振区/快区统计
# ============================

thermal_limit = 6.25e-7      # MeV

fast_limit = 1e-1            # 100 keV

thermal = np.sum(phi_u[E_mid < thermal_limit])

resonance = np.sum(
    phi_u[
        (E_mid >= thermal_limit) &
        (E_mid < fast_limit)
    ]
)

fast = np.sum(phi_u[E_mid >= fast_limit])

total = thermal + resonance + fast

print("\n===== Flux Fraction =====")

print(f"Thermal   : {thermal/total*100:.2f}%")

print(f"Resonance : {resonance/total*100:.2f}%")

print(f"Fast      : {fast/total*100:.2f}%")

plt.show()