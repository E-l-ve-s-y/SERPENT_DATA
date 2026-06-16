#!/usr/bin/env python3
"""
中子能谱绘图脚本 - 阶梯谱图版本
- 绘制通量/(Δ能量区间) 随能量的变化
- 使用阶梯图形式，横坐标为能量边界值
- 5个燃耗步一张图（det5, det10, det15, det20, det25）
- 7个能群（G1-G7）
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

# 能量边界 (eV) - 8个边界点形成7个能群
ENERGY_BOUNDARIES = [1E-11, 4.0E-9, 1.0E-8, 1.0E-7, 0.625E-6, 0.906E-3, 3.0E-3, 20.0]

# 计算每个能群的能量间隔 ΔE
DELTA_E = np.array([ENERGY_BOUNDARIES[i+1] - ENERGY_BOUNDARIES[i] for i in range(7)])

# 能群标签
GROUP_LABELS = ['G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7']

# 燃耗步选择
BURNUP_STEPS = ['det5', 'det10', 'det15', 'det20', 'det25']

# 颜色和线型设置
COLORS = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd']
LINESTYLES = ['-', '--', '-.', ':', '-']

# 输出目录
OUTPUT_DIR = Path(r"C:\Users\lsy05\serpent_data\results\analysis\V1\Neutron_spectra")


def load_data(csv_path):
    """加载探测器能谱数据"""
    df = pd.read_csv(csv_path, comment='#')
    return df


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


def plot_single_step(df, case_id, burnup_step, output_path):
    """绘制单个燃耗步的阶梯能谱图（柱状图形式）"""
    # 筛选数据
    case_data = df[df['case'] == case_id]
    step_data = case_data[case_data['detector'] == burnup_step]
    
    if step_data.empty:
        print(f"警告: 算例 {case_id} 的 {burnup_step} 没有数据")
        return False
    
    # 获取通量数据
    flux_values = []
    for group in GROUP_LABELS:
        val = step_data[group].values[0]
        flux_values.append(val)
    flux_values = np.array(flux_values)
    
    # 计算 Φ/ΔE
    flux_per_dE = flux_values / DELTA_E
    
    # 创建图形
    fig, ax = plt.subplots(figsize=(12, 7))
    
    # 使用柱状图绘制能谱
    x_positions = np.arange(7)
    ax.bar(x_positions, flux_per_dE, width=0.7, color='#1f77b4', alpha=0.8, 
           edgecolor='black', linewidth=1)
    
    # 设置X轴刻度为能量边界范围
    ax.set_xticks(x_positions)
    ax.set_xticklabels([f'{format_energy_label(ENERGY_BOUNDARIES[i])}-{format_energy_label(ENERGY_BOUNDARIES[i+1])}' 
                        for i in range(7)], rotation=45, ha='right', fontsize=10)
    
    ax.set_yscale('log')
    
    ax.set_xlabel('Energy Range (eV)', fontsize=12)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=12)
    ax.set_title(f'{case_id} - Neutron Spectrum ({burnup_step})', fontsize=14, fontweight='bold')
    
    # 添加网格
    ax.grid(True, axis='y', linestyle='--', alpha=0.7)
    
    plt.tight_layout()
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    return True


def plot_multi_steps(df, case_id, output_path):
    """绘制5个燃耗步的对比阶梯图（分组柱状图）"""
    # 筛选算例数据
    case_data = df[df['case'] == case_id]
    
    fig, ax = plt.subplots(figsize=(16, 8))
    
    # X位置
    x_positions = np.arange(7)
    bar_width = 0.15
    
    for i, burnup_step in enumerate(BURNUP_STEPS):
        step_data = case_data[case_data['detector'] == burnup_step]
        
        if step_data.empty:
            print(f"警告: 算例 {case_id} 的 {burnup_step} 没有数据")
            continue
        
        # 获取通量数据
        flux_values = []
        for group in GROUP_LABELS:
            val = step_data[group].values[0]
            flux_values.append(val)
        flux_values = np.array(flux_values)
        
        # 计算 Φ/ΔE
        flux_per_dE = flux_values / DELTA_E
        
        # 绘制分组柱状图
        offset = (i - 2) * bar_width
        ax.bar(x_positions + offset, flux_per_dE, width=bar_width, 
               color=COLORS[i], alpha=0.85, label=f'{burnup_step}',
               edgecolor='black', linewidth=0.5)
    
    ax.set_yscale('log')
    
    # 设置X轴刻度为能量边界标签
    ax.set_xticks(x_positions)
    ax.set_xticklabels([f'{format_energy_label(ENERGY_BOUNDARIES[i])}-{format_energy_label(ENERGY_BOUNDARIES[i+1])}' 
                        for i in range(7)], rotation=45, ha='right', fontsize=10)
    
    ax.set_xlabel('Energy Range (eV)', fontsize=12)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=12)
    ax.set_title(f'{case_id} - Neutron Spectrum Comparison (Grouped Bar)', fontsize=14, fontweight='bold')
    
    # 添加网格
    ax.grid(True, axis='y', linestyle='--', alpha=0.7)
    
    # 添加图例
    ax.legend(loc='best', fontsize=10, framealpha=0.9, ncol=5)
    
    plt.tight_layout()
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    return True


def plot_multi_steps_step_line(df, case_id, output_path):
    """绘制5个燃耗步的阶梯线图（drawstyle='steps-post'）"""
    # 筛选算例数据
    case_data = df[df['case'] == case_id]
    
    fig, ax = plt.subplots(figsize=(12, 8))
    
    for i, burnup_step in enumerate(BURNUP_STEPS):
        step_data = case_data[case_data['detector'] == burnup_step]
        
        if step_data.empty:
            print(f"警告: 算例 {case_id} 的 {burnup_step} 没有数据")
            continue
        
        # 获取通量数据
        flux_values = []
        for group in GROUP_LABELS:
            val = step_data[group].values[0]
            flux_values.append(val)
        flux_values = np.array(flux_values)
        
        # 计算 Φ/ΔE
        flux_per_dE = flux_values / DELTA_E
        
        # 构建阶梯线数据
        x_plot = []
        y_plot = []
        for j in range(7):
            x_plot.append(ENERGY_BOUNDARIES[j])
            x_plot.append(ENERGY_BOUNDARIES[j+1])
            y_plot.append(flux_per_dE[j])
            y_plot.append(flux_per_dE[j])
        
        ax.semilogy(x_plot, y_plot,
                   drawstyle='steps-post',
                   color=COLORS[i], 
                   linewidth=2.5, 
                   label=f'{burnup_step}')
    
    ax.set_xscale('log')
    ax.set_xlabel('Energy (eV)', fontsize=12)
    ax.set_ylabel('Φ/ΔE (a.u.)', fontsize=12)
    ax.set_title(f'{case_id} - Neutron Spectrum Comparison (Step Line)', fontsize=14, fontweight='bold')
    
    # 添加网格
    ax.grid(True, which='both', linestyle='--', alpha=0.7)
    ax.set_xlim(1E-11, 20)
    
    # 添加图例
    ax.legend(loc='best', fontsize=10, framealpha=0.9)
    
    # 添加能群分隔线
    for eb in ENERGY_BOUNDARIES[1:-1]:
        ax.axvline(x=eb, color='gray', linestyle=':', alpha=0.3)
    
    plt.tight_layout()
    plt.savefig(output_path, dpi=150, bbox_inches='tight')
    plt.close()
    
    return True


def main():
    # 数据文件路径
    csv_path = r"C:\Users\lsy05\serpent_data\results\data_processed\V1\detector_spectra.csv"
    
    print("加载数据...")
    df = load_data(csv_path)
    
    # 获取所有算例
    cases = df['case'].unique()
    print(f"共发现 {len(cases)} 个算例")
    
    # 创建输出目录
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    total_plots = 0
    
    # 遍历每个算例
    for case_id in sorted(cases):
        print(f"处理算例: {case_id}")
        
        # 创建算例专属文件夹
        case_dir = OUTPUT_DIR / case_id
        case_dir.mkdir(parents=True, exist_ok=True)
        
        # 1. 绘制5张单燃耗步柱状图
        for burnup_step in BURNUP_STEPS:
            output_path = case_dir / f"{case_id}_{burnup_step}_spectrum.png"
            if plot_single_step(df, case_id, burnup_step, output_path):
                total_plots += 1
        
        # 2. 绘制5燃耗步分组柱状图对比
        output_path = case_dir / f"{case_id}_multi_steps_spectrum_bar.png"
        if plot_multi_steps(df, case_id, output_path):
            total_plots += 1
        
        # 3. 绘制5燃耗步阶梯线图
        output_path = case_dir / f"{case_id}_multi_steps_spectrum.png"
        if plot_multi_steps_step_line(df, case_id, output_path):
            total_plots += 1
        
        print(f"  算例 {case_id} 完成")
    
    print(f"\n全部完成! 共生成 {total_plots} 张图")
    print(f"输出目录: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()