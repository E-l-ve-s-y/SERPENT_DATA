#!/usr/bin/env python3
"""
能谱分析脚本 - 生成组内和组间能谱比较图

功能：
1. 组件内燃耗演变平均能谱比较图 - 同一组内不同燃耗步的平均能谱演变
2. 按组平均的能谱比较图 - A/B/C/D四组的平均能谱在同一燃耗步的对比
3. 组件间Th/Pu效应对比图 - 分析不同核素组成对能谱的影响

燃耗步对应关系（从SERPENT输入定义）：
| 探测器 | 燃耗步 | 燃耗值(MWd/kgHM) |
|--------|--------|------------------|
| det5   | Step 5 | 1.6              |
| det10  | Step 10| 5.0              |
| det15  | Step 15| 12.0             |
| det20  | Step 20| 24.0             |
| det25  | Step 25| 50.0             |

输出目录结构：
- results/analysis/V1/Neutron_spectra/intra_assembly/  组内比较图
- results/analysis/V1/Neutron_spectra/inter_assembly/ 组间比较图
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path
import sys

# 确保相对导入正确
sys.path.insert(0, str(Path(__file__).parent))

# Matplotlib 字体配置：自动选择可用的 CJK 字体，避免中文缺字警告
import matplotlib
from matplotlib import font_manager

def _set_cjk_font():
    """尝试设置一个可用的中文字体，按优先级列表选择。"""
    preferred = [
        'Microsoft YaHei',
        'SimHei',
        'Noto Sans CJK SC',
        'Source Han Sans CN',
        'WenQuanYi Micro Hei'
    ]
    available = {f.name for f in font_manager.fontManager.ttflist}
    for name in preferred:
        if name in available:
            matplotlib.rcParams['font.family'] = 'sans-serif'
            matplotlib.rcParams['font.sans-serif'] = [name]
            # 避免负号显示为方块
            matplotlib.rcParams['axes.unicode_minus'] = False
            print(f"Matplotlib font set to: {name}")
            return

    # 若没有找到合适字体，仍关闭 unicode minus，避免负号显示问题
    matplotlib.rcParams['axes.unicode_minus'] = False
    print('Warning: no preferred CJK font found; using default matplotlib font.')


_set_cjk_font()

# =============================================================================
# 配置
# =============================================================================

# 能量边界 (eV) - 7个能群
ENERGY_BOUNDARIES = [1E-11, 4.0E-9, 1.0E-8, 1.0E-7, 0.625E-6, 0.906E-3, 3.0E-3, 20.0]

# 计算每个能群的能量间隔 ΔE
DELTA_E = np.array([ENERGY_BOUNDARIES[i+1] - ENERGY_BOUNDARIES[i] for i in range(7)])

# 能群标签
GROUP_LABELS = ['G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7']

# 燃耗步选择（用于绘图的燃耗步）
BURNUP_STEPS = ['det5', 'det10', 'det15', 'det20', 'det25']

# 燃耗步对应的燃耗值 (MWd/kgHM)
BURNUP_VALUES = {
    'det5': 1.6,
    'det10': 5.0,
    'det15': 12.0,
    'det20': 24.0,
    'det25': 50.0
}

# 能量群中心点（备用，不再使用）
# ENERGY_CENTERS = np.array([
#     np.sqrt(ENERGY_BOUNDARIES[i] * ENERGY_BOUNDARIES[i+1]) 
#     for i in range(7)
# ])


def format_energy_label(e):
    """格式化能量标签"""
    if e >= 1:
        return f'{e:.0f}'
    elif e >= 1e-3:
        return f'{e*1e3:.1f}m'
    elif e >= 1e-6:
        return f'{e*1e6:.1f}μ'
    elif e >= 1e-9:
        return f'{e*1e9:.1f}n'
    else:
        return f'{e:.0e}'

# 颜色方案
COLORS_5_STEPS = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd']
COLORS_4_GROUPS = {'A': '#1f77b4', 'B': '#ff7f0e', 'C': '#2ca02c', 'D': '#d62728'}
LINESTYLES = ['-', '--', '-.', ':', '-']

# 组定义
GROUP_MEMBERS = {
    'A': [f'A{str(i).zfill(3)}' for i in range(1, 13)],  # A001-A012
    'B': [f'B{str(i).zfill(3)}' for i in range(1, 13)],  # B001-B012
    'C': [f'C{str(i).zfill(3)}' for i in range(1, 13)],  # C001-C012
    'D': [f'D{str(i).zfill(3)}' for i in range(1, 28)],  # D001-D027
}

# 组描述
GROUP_DESCRIPTIONS = {
    'A': 'U235+U238+Th\n(传统压水堆基准)',
    'B': 'U233+Th\n(钍铀循环)',
    'C': 'Pu239+Th\n(钚钍循环)',
    'D': 'Pu239+U235+U238+Th\n(四组分复杂燃料)'
}

# 路径配置
SCRIPT_DIR = Path(__file__).parent
DATA_DIR = SCRIPT_DIR.parent
OUTPUT_DIR = DATA_DIR / 'analysis' / 'V1' / 'Neutron_spectra'
INTRA_ASSEMBLY_DIR = OUTPUT_DIR / 'intra_assembly'
INTER_ASSEMBLY_DIR = OUTPUT_DIR / 'inter_assembly'
DATA_FILE = DATA_DIR / 'data_processed' / 'V1' / 'detector_spectra.csv'


# =============================================================================
# 辅助函数
# =============================================================================

def load_data(csv_path):
    """加载探测器能谱数据"""
    df = pd.read_csv(csv_path, comment='#')
    # 确保G1-G7列是数值类型
    for g in GROUP_LABELS:
        df[g] = pd.to_numeric(df[g], errors='coerce')
    return df


def get_group_average_spectra(df, group_name, burnup_step):
    """
    计算指定组在指定燃耗步的平均能谱
    
    Args:
        df: 探测器数据DataFrame
        group_name: 组名 ('A', 'B', 'C', 'D')
        burnup_step: 燃耗步 ('det5', 'det10', etc.)
    
    Returns:
        dict: 各能群的平均通量值 {'G1': val, ...}
    """
    cases = GROUP_MEMBERS.get(group_name, [])
    
    # 筛选数据
    mask = (df['case'].isin(cases)) & (df['detector'] == burnup_step)
    selected = df[mask]
    
    if selected.empty:
        return None
    
    # 计算平均
    avg_spectrum = {}
    for g in GROUP_LABELS:
        avg_spectrum[g] = selected[g].mean()
    
    return avg_spectrum


def get_case_spectra(df, case_name, burnup_step):
    """获取单个算例的能谱"""
    mask = (df['case'] == case_name) & (df['detector'] == burnup_step)
    selected = df[mask]
    
    if selected.empty:
        return None
    
    spectrum = {}
    for g in GROUP_LABELS:
        spectrum[g] = selected[g].values[0]
    
    return spectrum


def compute_flux_per_dE(spectrum_dict):
    """将通量转换为 Φ/ΔE"""
    values = np.array([spectrum_dict[g] for g in GROUP_LABELS])
    return values / DELTA_E


def plot_step_line(ax, flux_per_dE, color, linewidth=2, label=None, markers=True, alpha=1.0):
    """绘制阶梯线图"""
    x_plot = []
    y_plot = []
    for j in range(7):
        x_plot.append(ENERGY_BOUNDARIES[j])
        x_plot.append(ENERGY_BOUNDARIES[j+1])
        y_plot.append(flux_per_dE[j])
        y_plot.append(flux_per_dE[j])
    
    ax.semilogy(x_plot, y_plot,
               drawstyle='steps-post',
               color=color, 
               linewidth=linewidth, 
               label=label,
               alpha=alpha)
    
    if markers:
        # 在每个能群中心添加标记点
        centers = [np.sqrt(ENERGY_BOUNDARIES[j] * ENERGY_BOUNDARIES[j+1]) for j in range(7)]
        ax.semilogy(centers, flux_per_dE, 'o', color=color, markersize=6, alpha=alpha)


# =============================================================================
# 绘图函数
# =============================================================================

def plot_intra_group_burnup_evolution(df, group_name):
    """
    绘制组内燃耗演变平均能谱比较图（阶梯线图形式）
    
    同一组内所有算例的平均能谱，在不同燃耗步（det5/det10/det15/det20/det25）的变化
    """
    fig, ax = plt.subplots(figsize=(12, 8))
    
    has_data = False
    for i, burnup_step in enumerate(BURNUP_STEPS):
        spectrum = get_group_average_spectra(df, group_name, burnup_step)
        if spectrum is None:
            continue
        
        has_data = True
        flux_per_dE = compute_flux_per_dE(spectrum)
        burnup_val = BURNUP_VALUES.get(burnup_step, burnup_step.replace('det', ''))
        
        plot_step_line(ax, flux_per_dE, color=COLORS_5_STEPS[i],
                      linewidth=2, label=f'{burnup_step} ({burnup_val} MWd/kgHM)')
    
    if not has_data:
        plt.close()
        return False
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=13)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=13)
    ax.set_title(f'Group {group_name}: {GROUP_DESCRIPTIONS[group_name]}\n'
                f'Avg. Neutron Spectrum Evolution with Burnup', 
                fontsize=14, fontweight='bold')
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=10, framealpha=0.9)
    
    # 添加能群分隔线
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    plt.tight_layout()
    output_path = INTRA_ASSEMBLY_DIR / f'Group_{group_name}_intra_assembly_burnup_evolution.png'
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    print(f"  生成的图: {output_path.name}")
    return True


def plot_intra_group_comparison_with_std(df, group_name):
    """
    绘制组内平均能谱比较图（带标准差阴影，阶梯线图形式）
    
    展示组内平均值及不确定性
    """
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(18, 7))
    
    cases = GROUP_MEMBERS.get(group_name, [])
    
    # 左图：各燃耗步的平均能谱（阶梯线图）
    for i, burnup_step in enumerate(BURNUP_STEPS):
        spectrum = get_group_average_spectra(df, group_name, burnup_step)
        if spectrum is None:
            continue
        
        flux_per_dE = compute_flux_per_dE(spectrum)
        burnup_val = BURNUP_VALUES.get(burnup_step, burnup_step.replace('det', ''))
        
        plot_step_line(ax1, flux_per_dE, color=COLORS_5_STEPS[i],
                      linewidth=2, label=f'{burnup_step} ({burnup_val} MWd/kgHM)')
    
    ax1.set_xscale('log')
    ax1.set_yscale('log')
    ax1.set_xlabel('Energy (eV)', fontsize=12)
    ax1.set_ylabel('Φ/ΔE (a.u.)', fontsize=12)
    ax1.set_title(f'Group {group_name}: Avg. Spectrum by Burnup Step', fontsize=12)
    ax1.grid(True, which='both', linestyle='--', alpha=0.5)
    ax1.set_xlim(1E-11, 20)
    ax1.legend(loc='best', fontsize=9)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax1.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    # 右图：组内算例分散度（det10为例，阶梯线图）
    ref_step = 'det10'
    ref_spectrum = get_group_average_spectra(df, group_name, ref_step)
    if ref_spectrum:
        ref_flux = compute_flux_per_dE(ref_spectrum)
        
        # 绘制阶梯线
        x_plot = []
        y_plot = []
        for j in range(7):
            x_plot.append(ENERGY_BOUNDARIES[j])
            x_plot.append(ENERGY_BOUNDARIES[j+1])
            y_plot.append(ref_flux[j])
            y_plot.append(ref_flux[j])
        ax2.semilogy(x_plot, y_plot, drawstyle='steps-post',
                    color='black', linewidth=2, label='Mean', zorder=10)
        
        # 计算标准差
        mask = (df['case'].isin(cases)) & (df['detector'] == ref_step)
        selected = df[mask]
        
        if not selected.empty:
            # 计算每个能群的标准差
            std_lower = []
            std_upper = []
            for g in GROUP_LABELS:
                std = selected[g].std()
                idx = GROUP_LABELS.index(g)
                std_lower.append(ref_flux[idx] - std / DELTA_E[idx])
                std_upper.append(ref_flux[idx] + std / DELTA_E[idx])
            
            # 绘制阴影区域（阶梯形式）
            x_fill = []
            y_lower = []
            y_upper = []
            for j in range(7):
                x_fill.append(ENERGY_BOUNDARIES[j])
                x_fill.append(ENERGY_BOUNDARIES[j+1])
                y_lower.append(std_lower[j])
                y_lower.append(std_lower[j])
                y_upper.append(std_upper[j])
                y_upper.append(std_upper[j])
            
            ax2.fill_between(x_fill, y_lower, y_upper,
                           alpha=0.3, color='gray', step='post', label='±1 Std')
        
        ax2.set_xscale('log')
        ax2.set_yscale('log')
        ax2.set_xlabel('Energy (eV)', fontsize=12)
        ax2.set_ylabel('Φ/ΔE (a.u.)', fontsize=12)
        ax2.set_title(f'Group {group_name}: Intra-Group Variability at {ref_step}', fontsize=12)
        ax2.grid(True, which='both', linestyle='--', alpha=0.5)
        ax2.set_xlim(1E-11, 20)
        ax2.legend(loc='best', fontsize=9)
        for eb in ENERGY_BOUNDARIES[1:-1]:
            ax2.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    plt.suptitle(f'Group {group_name} - Intra-Assembly Spectrum Analysis', 
                fontsize=14, fontweight='bold', y=1.02)
    plt.tight_layout()
    
    output_path = INTRA_ASSEMBLY_DIR / f'Group_{group_name}_intra_assembly_comparison.png'
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    print(f"  生成的图: {output_path.name}")
    return True


def plot_all_groups_inter_comparison(df, burnup_step):
    """
    绘制所有组的能谱对比图（组间比较，阶梯线图形式）
    
    A/B/C/D四组在相同燃耗步的平均能谱对比
    """
    fig, ax = plt.subplots(figsize=(12, 8))
    
    has_data = False
    for i, group_name in enumerate(['A', 'B', 'C', 'D']):
        spectrum = get_group_average_spectra(df, group_name, burnup_step)
        if spectrum is None:
            continue
        
        has_data = True
        flux_per_dE = compute_flux_per_dE(spectrum)
        n_cases = len(GROUP_MEMBERS[group_name])
        
        plot_step_line(ax, flux_per_dE, color=COLORS_4_GROUPS[group_name],
                      linewidth=2.5, label=f'Group {group_name} ({n_cases} cases)')
    
    if not has_data:
        plt.close()
        return False
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=13)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=13)
    
    burnup_val = BURNUP_VALUES.get(burnup_step, burnup_step)
    ax.set_title(f'Inter-Group Neutron Spectrum Comparison\n'
                f'At Burnup Step: {burnup_step} ({burnup_val} MWd/kgHM)', 
                fontsize=14, fontweight='bold')
    
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=11, framealpha=0.9)
    
    # 添加能群分隔线
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    plt.tight_layout()
    output_path = INTER_ASSEMBLY_DIR / f'all_groups_inter_comparison_{burnup_step}.png'
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    print(f"  生成的图: {output_path.name}")
    return True


def plot_thPu_effect_comparison(df):
    """
    绘制Th/Pu效应对比图（阶梯线图形式）
    
    重点分析：
    1. B组 vs C组：U233+Th vs Pu239+Th（Th基燃料中不同裂变材料的对比）
    2. A组 vs B组：U235+U238 vs U233+Th（传统vs钍铀循环）
    3. C组 vs D组：Pu239+Th vs Pu239+U235+U238+Th（有无U的对比）
    """
    fig, axes = plt.subplots(2, 2, figsize=(18, 14))
    
    line_styles = ['-', '--', ':']
    
    # 图1: B组 vs C组 (U233+Th vs Pu239+Th)
    ax = axes[0, 0]
    for i, (group, label) in enumerate([('B', 'U233+Th'), ('C', 'Pu239+Th')]):
        for j, burnup_step in enumerate(['det5', 'det15', 'det25']):
            spectrum = get_group_average_spectra(df, group, burnup_step)
            if spectrum:
                flux_per_dE = compute_flux_per_dE(spectrum)
                burnup_val = BURNUP_VALUES.get(burnup_step, burnup_step)
                color = COLORS_4_GROUPS[group]
                # 用不同线型区分不同燃耗步
                x_plot = []
                y_plot = []
                for k in range(7):
                    x_plot.append(ENERGY_BOUNDARIES[k])
                    x_plot.append(ENERGY_BOUNDARIES[k+1])
                    y_plot.append(flux_per_dE[k])
                    y_plot.append(flux_per_dE[k])
                ax.semilogy(x_plot, y_plot, drawstyle='steps-post',
                           color=color, linestyle=line_styles[j], linewidth=2,
                           label=f'{label} @ {burnup_step}')
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=11)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=11)
    ax.set_title('Th-based Fuel: U233 vs Pu239\n(Effect of Fissile Material)', fontsize=12)
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=8, ncol=2)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    # 图2: A组 vs B组 (U235基准 vs U233+Th)
    ax = axes[0, 1]
    for i, (group, label) in enumerate([('A', 'U235+U238'), ('B', 'U233+Th')]):
        for j, burnup_step in enumerate(['det5', 'det15', 'det25']):
            spectrum = get_group_average_spectra(df, group, burnup_step)
            if spectrum:
                flux_per_dE = compute_flux_per_dE(spectrum)
                color = COLORS_4_GROUPS[group]
                x_plot = []
                y_plot = []
                for k in range(7):
                    x_plot.append(ENERGY_BOUNDARIES[k])
                    x_plot.append(ENERGY_BOUNDARIES[k+1])
                    y_plot.append(flux_per_dE[k])
                    y_plot.append(flux_per_dE[k])
                ax.semilogy(x_plot, y_plot, drawstyle='steps-post',
                           color=color, linestyle=line_styles[j], linewidth=2,
                           label=f'{label} @ {burnup_step}')
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=11)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=11)
    ax.set_title('Traditional vs Th-U Cycle\n(Effect of Thorium Addition)', fontsize=12)
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=8, ncol=2)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    # 图3: A组不同Th含量 (Th_level效应)
    ax = axes[1, 0]
    th_levels = {'A001': '0%', 'A004': '30%', 'A007': '60%', 'A010': '90%'}
    colors_th = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728']
    
    for k, (case, th_label) in enumerate(th_levels.items()):
        spectrum = get_case_spectra(df, case, 'det10')
        if spectrum:
            flux_per_dE = compute_flux_per_dE(spectrum)
            plot_step_line(ax, flux_per_dE, color=colors_th[k],
                          linewidth=2, label=f'Th={th_label}', markers=False)
            # 添加额外标记
            centers = [np.sqrt(ENERGY_BOUNDARIES[j] * ENERGY_BOUNDARIES[j+1]) for j in range(7)]
            ax.semilogy(centers, flux_per_dE, 'o', color=colors_th[k], markersize=6)
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=11)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=11)
    ax.set_title('A Group: Effect of Th Loading\n(U235+U238+Th with varying Th fraction)', fontsize=12)
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=10)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    # 图4: B组 vs C组 (U233 vs Pu239含量效应)
    ax = axes[1, 1]
    b_cases = [('B001', 'U233=5%'), ('B004', 'U233=20%'), ('B008', 'U233=40%'), ('B012', 'U233=60%')]
    c_cases = [('C001', 'Pu=5%'), ('C004', 'Pu=20%'), ('C008', 'Pu=40%'), ('C012', 'Pu=60%')]
    
    for case, label in b_cases:
        spectrum = get_case_spectra(df, case, 'det10')
        if spectrum:
            flux_per_dE = compute_flux_per_dE(spectrum)
            plot_step_line(ax, flux_per_dE, color='blue', linewidth=1.5,
                          label=label, markers=False, alpha=0.8)
            centers = [np.sqrt(ENERGY_BOUNDARIES[j] * ENERGY_BOUNDARIES[j+1]) for j in range(7)]
            ax.semilogy(centers, flux_per_dE, 'o', color='blue', markersize=5)
    
    for case, label in c_cases:
        spectrum = get_case_spectra(df, case, 'det10')
        if spectrum:
            flux_per_dE = compute_flux_per_dE(spectrum)
            plot_step_line(ax, flux_per_dE, color='red', linewidth=1.5,
                          label=label, markers=False, alpha=0.8)
            centers = [np.sqrt(ENERGY_BOUNDARIES[j] * ENERGY_BOUNDARIES[j+1]) for j in range(7)]
            ax.semilogy(centers, flux_per_dE, 's', color='red', markersize=5)
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=11)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=11)
    ax.set_title('B Group (U233 fraction) vs C Group (Pu239 fraction)\n'
                'At det10 (5 MWd/kgHM)', fontsize=12)
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=8, ncol=2)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    plt.suptitle('Th/Pu Effect on Neutron Spectrum (Step Line)', fontsize=15, fontweight='bold', y=1.01)
    plt.tight_layout()
    
    output_path = INTER_ASSEMBLY_DIR / 'thPu_effect_comparison.png'
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    print(f"  生成的图: {output_path.name}")
    return True


def plot_spectrum_hardness_comparison(df):
    """
    绘制能谱硬度对比图
    
    分析不同组件的能谱硬化/软化趋势
    - 热中子份额 vs 快中子份额
    - 能谱指数（热中子/快中子比）
    """
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))
    
    # 计算能谱指数：G5/G7 (热中子群/快中子群)
    spectrum_index_data = {'A': [], 'B': [], 'C': [], 'D': []}
    
    for group in ['A', 'B', 'C', 'D']:
        for burnup_step in BURNUP_STEPS:
            spectrum = get_group_average_spectra(df, group, burnup_step)
            if spectrum:
                # G1-G4为热中子区, G5-G7为共振+快中子区
                thermal = sum(spectrum[g] for g in ['G1', 'G2', 'G3', 'G4'])
                fast = sum(spectrum[g] for g in ['G5', 'G6', 'G7'])
                ratio = thermal / fast if fast > 0 else 0
                spectrum_index_data[group].append((burnup_step, ratio))
    
    # 左图：能谱指数随燃耗变化
    ax = axes[0]
    for group in ['A', 'B', 'C', 'D']:
        data = spectrum_index_data[group]
        if data:
            steps = [d[0] for d in data]
            ratios = [d[1] for d in data]
            ax.plot(range(len(steps)), ratios, 
                   marker='o', color=COLORS_4_GROUPS[group],
                   linewidth=2, markersize=8, label=f'Group {group}')
    
    ax.set_xticks(range(len(BURNUP_STEPS)))
    ax.set_xticklabels([f'{s}\n({BURNUP_VALUES[s]})' for s in BURNUP_STEPS])
    ax.set_xlabel('Burnup Step (MWd/kgHM)', fontsize=11)
    ax.set_ylabel('Thermal/Fast Ratio (G1-G4 / G5-G7)', fontsize=11)
    ax.set_title('Spectrum Hardness Evolution\n(Lower ratio = harder spectrum)', fontsize=12)
    ax.grid(True, linestyle='--', alpha=0.5)
    ax.legend(loc='best', fontsize=10)
    
    # 右图：快中子份额（G7群占比）随燃耗变化
    ax = axes[1]
    fast_fraction_data = {'A': [], 'B': [], 'C': [], 'D': []}
    
    for group in ['A', 'B', 'C', 'D']:
        for burnup_step in BURNUP_STEPS:
            spectrum = get_group_average_spectra(df, group, burnup_step)
            if spectrum:
                total = sum(spectrum[g] for g in GROUP_LABELS)
                fast_frac = spectrum['G7'] / total if total > 0 else 0
                fast_fraction_data[group].append((burnup_step, fast_frac))
    
    for group in ['A', 'B', 'C', 'D']:
        data = fast_fraction_data[group]
        if data:
            steps = [d[0] for d in data]
            fracs = [d[1] for d in data]
            ax.plot(range(len(steps)), fracs,
                   marker='s', color=COLORS_4_GROUPS[group],
                   linewidth=2, markersize=8, label=f'Group {group}')
    
    ax.set_xticks(range(len(BURNUP_STEPS)))
    ax.set_xticklabels([f'{s}\n({BURNUP_VALUES[s]})' for s in BURNUP_STEPS])
    ax.set_xlabel('Burnup Step (MWd/kgHM)', fontsize=11)
    ax.set_ylabel('Fast Neutron Fraction (G7 / Total)', fontsize=11)
    ax.set_title('Fast Neutron (G7) Fraction Evolution\n(Indication of spectrum hardening)', fontsize=12)
    ax.grid(True, linestyle='--', alpha=0.5)
    ax.legend(loc='best', fontsize=10)
    
    plt.suptitle('Spectrum Hardness Analysis: Th/Pu Effect', fontsize=14, fontweight='bold', y=1.02)
    plt.tight_layout()
    
    output_path = INTER_ASSEMBLY_DIR / 'spectrum_hardness_comparison.png'
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    print(f"  生成的图: {output_path.name}")
    return True


def plot_d_group_analysis(df):
    """
    绘制D组详细分析图（阶梯线图形式）
    
    D组是四组分复杂燃料，分析Th/Pu/U235的协同效应
    """
    fig, axes = plt.subplots(2, 2, figsize=(18, 14))
    
    # D组不同Th含量对比
    ax = axes[0, 0]
    th_variations = {
        'D001': 'Th=70%, Pu=4%', 'D004': 'Th=70%, Pu=6%', 'D007': 'Th=70%, Pu=8%',
        'D010': 'Th=80%, Pu=4%', 'D013': 'Th=80%, Pu=6%', 'D016': 'Th=80%, Pu=8%',
        'D019': 'Th=90%, Pu=4%', 'D022': 'Th=90%, Pu=6%', 'D025': 'Th=90%, Pu=8%'
    }
    
    colors_d = plt.cm.viridis(np.linspace(0, 1, len(th_variations)))
    for k, (case, label) in enumerate(th_variations.items()):
        spectrum = get_case_spectra(df, case, 'det10')
        if spectrum:
            flux_per_dE = compute_flux_per_dE(spectrum)
            plot_step_line(ax, flux_per_dE, color=colors_d[k],
                          linewidth=1.5, label=label, markers=False, alpha=0.8)
            centers = [np.sqrt(ENERGY_BOUNDARIES[j] * ENERGY_BOUNDARIES[j+1]) for j in range(7)]
            ax.semilogy(centers, flux_per_dE, 'o', color=colors_d[k], markersize=5)
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=11)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=11)
    ax.set_title('D Group: Th/Pu Variation Effects\n(det10, 5 MWd/kgHM)', fontsize=12)
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=8, ncol=2)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    # D组能谱随燃耗演变
    ax = axes[0, 1]
    for i, burnup_step in enumerate(BURNUP_STEPS):
        spectrum = get_group_average_spectra(df, 'D', burnup_step)
        if spectrum:
            flux_per_dE = compute_flux_per_dE(spectrum)
            burnup_val = BURNUP_VALUES.get(burnup_step, burnup_step)
            plot_step_line(ax, flux_per_dE, color=COLORS_5_STEPS[i],
                          linewidth=2, label=f'{burnup_step} ({burnup_val} MWd/kgHM)')
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=11)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=11)
    ax.set_title('D Group: Avg. Spectrum Evolution\n(All 27 cases averaged)', fontsize=12)
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=10)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    # U235富集度效应（D组内）
    ax = axes[1, 0]
    u235_cases = {
        'D011': 'U235=3%', 'D013': 'U235=3%, Pu=6%', 'D015': 'U235=5%'
    }
    
    for i, (case, label) in enumerate(u235_cases.items()):
        spectrum = get_case_spectra(df, case, 'det10')
        if spectrum:
            flux_per_dE = compute_flux_per_dE(spectrum)
            plot_step_line(ax, flux_per_dE, color=plt.cm.coolwarm(i/2),
                          linewidth=2, label=label)
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=11)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=11)
    ax.set_title('D Group: U235 Enrichment Effect\n(det10, 5 MWd/kgHM)', fontsize=12)
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=10)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    # 与其他组的综合对比（det25）
    ax = axes[1, 1]
    for group in ['A', 'B', 'C', 'D']:
        spectrum = get_group_average_spectra(df, group, 'det25')
        if spectrum:
            flux_per_dE = compute_flux_per_dE(spectrum)
            plot_step_line(ax, flux_per_dE, color=COLORS_4_GROUPS[group],
                          linewidth=2.5, label=f'Group {group}')
    
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=11)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=11)
    ax.set_title('All Groups Comparison at High Burnup\n(det25, 50 MWd/kgHM)', fontsize=12)
    ax.grid(True, which='both', linestyle='--', alpha=0.5)
    ax.set_xlim(1E-11, 20)
    ax.legend(loc='best', fontsize=10)
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    plt.suptitle('D Group (Pu+U235+U238+Th) Detailed Analysis (Step Line)', 
                fontsize=14, fontweight='bold', y=1.02)
    plt.tight_layout()
    
    output_path = INTER_ASSEMBLY_DIR / 'd_group_detailed_analysis.png'
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    print(f"  生成的图: {output_path.name}")
    return True


# =============================================================================
# 主函数
# =============================================================================

def main():
    """主函数：生成所有能谱比较图"""
    import argparse
    
    parser = argparse.ArgumentParser(description='生成能谱比较分析图')
    parser.add_argument('--data', '-d', type=str, default=str(DATA_FILE),
                       help='探测器能谱CSV文件路径')
    parser.add_argument('--output', '-o', type=str, default=str(OUTPUT_DIR),
                       help='输出目录')
    parser.add_argument('--skip-intra', action='store_true',
                       help='跳过组内比较图生成')
    parser.add_argument('--skip-inter', action='store_true',
                       help='跳过组间比较图生成')
    args = parser.parse_args()
    
    # 创建输出目录
    INTRA_ASSEMBLY_DIR.mkdir(parents=True, exist_ok=True)
    INTER_ASSEMBLY_DIR.mkdir(parents=True, exist_ok=True)
    
    print("=" * 60)
    print("能谱比较分析脚本")
    print("=" * 60)
    print(f"数据文件: {args.data}")
    print(f"输出目录: {args.output}")
    print(f"  - 组内比较: {INTRA_ASSEMBLY_DIR}")
    print(f"  - 组间比较: {INTER_ASSEMBLY_DIR}")
    print("=" * 60)
    
    # 加载数据
    print("\n[1/4] 加载探测器能谱数据...")
    df = load_data(args.data)
    print(f"  加载了 {len(df)} 条记录")
    print(f"  算例: {df['case'].nunique()} 个")
    print(f"  探测器: {df['detector'].nunique()} 个")
    
    # 组内比较图
    if not args.skip_intra:
        print("\n[2/4] 生成组内比较图 (intra_assembly)...")
        for group in ['A', 'B', 'C', 'D']:
            print(f"\n  处理 Group {group}:")
            plot_intra_group_burnup_evolution(df, group)
            plot_intra_group_comparison_with_std(df, group)
    
    # 组间比较图
    if not args.skip_inter:
        print("\n[3/4] 生成组间比较图 (inter_assembly)...")
        
        # 各燃耗步的所有组对比
        print("\n  各燃耗步组间对比:")
        for burnup_step in BURNUP_STEPS:
            plot_all_groups_inter_comparison(df, burnup_step)
        
        # Th/Pu效应对比
        print("\n  Th/Pu效应分析:")
        plot_thPu_effect_comparison(df)
        
        # 能谱硬度分析
        print("\n  能谱硬度分析:")
        plot_spectrum_hardness_comparison(df)
        
        # D组详细分析
        print("\n  D组详细分析:")
        plot_d_group_analysis(df)
    
    print("\n[4/4] 完成!")
    print("=" * 60)
    print("生成的图表:")
    print("-" * 60)
    print("组内比较图 (intra_assembly):")
    for group in ['A', 'B', 'C', 'D']:
        print(f"  - Group_{group}_intra_assembly_burnup_evolution.png")
        print(f"  - Group_{group}_intra_assembly_comparison.png")
    print("-" * 60)
    print("组间比较图 (inter_assembly):")
    for step in BURNUP_STEPS:
        print(f"  - all_groups_inter_comparison_{step}.png")
    print("  - thPu_effect_comparison.png")
    print("  - spectrum_hardness_comparison.png")
    print("  - d_group_detailed_analysis.png")
    print("=" * 60)


if __name__ == '__main__':
    main()