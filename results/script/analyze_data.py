#!/usr/bin/env python3
# pyright: reportMissingImports=false, reportMissingModuleSource=false
"""
Serpent数据分析脚本 - 生成每个算例的Keff/FIR/CR和核素质量随燃耗变化图
读取预处理后的CSV数据，生成:
1. Keff/FIR/CR vs Burnup 曲线图
2. U233/Pa233/U235/Pu239/Am241/Am245/Sm149/Xe135 质量随燃耗变化图
3. 关键核素原子数密度随时间变化图
4. 中子毒物演化图
5. 裂变/吸收比演化图
6. 核素质量密度随时间变化图
"""
import os
import re
import sys
from datetime import datetime
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

KEY_ADENS = ['Adens_U233', 'Adens_Th232', 'Adens_Pa233', 'Adens_U235', 'Adens_U238']
POISON_DENS = ['Mdens_Sm149', 'Mdens_Xe135', 'Adens_Sm149', 'Adens_Xe135']
RATIO_PAIRS = [
    ('U235_FISS', 'U235_CAPT', 'U235'),
    ('U238_FISS', 'U238_CAPT', 'U238'),
    ('PU239_FISS', 'PU239_CAPT', 'Pu239'),
    ('PU240_FISS', 'PU240_CAPT', 'Pu240'),
    ('PU241_FISS', 'PU241_CAPT', 'Pu241'),
]
MASS_DENSITY_COLS = [
    ('Mdens_U233', 'U-233'),
    ('Mdens_Pa233', 'Pa-233'),
    ('Mdens_U235', 'U-235'),
    ('Mdens_Pu239', 'Pu-239'),
    ('Mdens_Am241', 'Am-241'),
    ('Mdens_Am245', 'Am-245'),
    ('Mdens_Sm149', 'Sm-149'),
    ('Mdens_Xe135', 'Xe-135'),
]


def load_data(csv_path):
    """从CSV加载预处理数据"""
    df = pd.read_csv(csv_path, comment='#')
    # 清理可能的注释行
    df.columns = df.columns.str.strip()
    return df


def compute_FIR(df_case):
    """计算FIR (Fissile Inventory Ratio)"""
    # 初始可裂变核素总质量
    fissile_cols = ['Mdens_U233', 'Mdens_U235', 'Mdens_Pu239', 'Mdens_Pu241']
    fissile_initial = sum(df_case[col].iloc[0] if col in df_case.columns else 0 
                         for col in fissile_cols)
    if fissile_initial == 0:
        fissile_initial = 1.0  # 避免除零
    
    # 当前可裂变核素总质量
    fissile_current = sum(df_case[col] if col in df_case.columns else pd.Series(0, index=df_case.index) 
                         for col in fissile_cols)
    
    return fissile_current / fissile_initial


def plot_keff_fir_cr(df_case, case_name, outdir):
    """绘制单个算例的Keff/FIR/CR vs Burnup图"""
    fig, axes = plt.subplots(3, 1, figsize=(10, 12), sharex=True)
    burnup = df_case['burnup_MWd_kgHM'].values
    
    # Keff
    axes[0].plot(burnup, df_case['ANA_KEFF'].values, 'b-o', markersize=4, linewidth=1.5)
    axes[0].set_ylabel('Keff', fontsize=12)
    axes[0].set_title(f'{case_name}: k-effective vs Burnup', fontsize=14)
    axes[0].grid(True, alpha=0.3)
    axes[0].axhline(y=1.0, color='r', linestyle='--', alpha=0.5, label='Critical (keff=1)')
    axes[0].legend()
    
    # FIR
    FIR = compute_FIR(df_case)
    axes[1].plot(burnup, FIR.values, 'g-s', markersize=4, linewidth=1.5)
    axes[1].set_ylabel('FIR', fontsize=12)
    axes[1].set_title(f'{case_name}: Fissile Inventory Ratio vs Burnup', fontsize=14)
    axes[1].grid(True, alpha=0.3)
    axes[1].axhline(y=1.0, color='r', linestyle='--', alpha=0.5, label='Initial')
    axes[1].legend()
    
    # CR
    axes[2].plot(burnup, df_case['conversion_ratio'].values, 'm-^', markersize=4, linewidth=1.5)
    axes[2].set_ylabel('Conversion Ratio', fontsize=12)
    axes[2].set_xlabel('Burnup (MWd/kgHM)', fontsize=12)
    axes[2].set_title(f'{case_name}: Conversion Ratio vs Burnup', fontsize=14)
    axes[2].grid(True, alpha=0.3)
    axes[2].axhline(y=1.0, color='r', linestyle='--', alpha=0.5, label='CR=1')
    axes[2].legend()
    
    plt.tight_layout()
    out_path = Path(outdir) / case_name / 'keff_fir_cr.png'
    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()


def plot_mass_evolution(df_case, case_name, outdir):
    """绘制单个算例的核素质量随燃耗变化图"""
    # 需要追踪的核素列表
    isotopes = [
        ('Mdens_U233', 'U-233'),
        ('Mdens_Pa233', 'Pa-233'),
        ('Mdens_U235', 'U-235'),
        ('Mdens_Pu239', 'Pu-239'),
        ('Mdens_Am241', 'Am-241'),
        ('Mdens_Am245', 'Am-245'),
        ('Mdens_Sm149', 'Sm-149'),
        ('Mdens_Xe135', 'Xe-135'),
    ]
    
    burnup = df_case['burnup_MWd_kgHM'].values
    
    # 创建2x4子图布局
    fig, axes = plt.subplots(2, 4, figsize=(20, 10))
    axes = axes.flatten()
    
    for idx, (col, label) in enumerate(isotopes):
        ax = axes[idx]
        if col in df_case.columns:
            data = df_case[col].values
            # 处理NaN和0值（对数坐标需要正数）
            data_masked = np.where(data > 0, data, np.nan)
            
            ax.semilogy(burnup, data_masked, 'b-o', markersize=3, linewidth=1.5)
            ax.set_xlabel('Burnup (MWd/kgHM)', fontsize=10)
            ax.set_ylabel('Mass Density (g/cm³)', fontsize=10)
            ax.set_title(label, fontsize=12)
            ax.grid(True, alpha=0.3)
            
            # 设置y轴范围，避免极端值
            valid_data = data_masked[~np.isnan(data_masked)]
            if len(valid_data) > 0:
                ymin = np.nanmin(valid_data) * 0.1
                ymax = np.nanmax(valid_data) * 10
                ax.set_ylim(ymin, ymax)
        else:
            ax.text(0.5, 0.5, f'{label}\n(No Data)', ha='center', va='center', 
                   transform=ax.transAxes, fontsize=10)
            ax.set_title(label, fontsize=12)
    
    plt.suptitle(f'{case_name}: Mass Density Evolution vs Burnup', fontsize=16, y=1.02)
    plt.tight_layout()
    
    out_path = Path(outdir) / case_name / 'mass_evolution.png'
    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()


def plot_inventory_evolution(df_case, case_name, outdir):
    """绘制关键核素原子数密度随EFPD变化图。"""
    fig, axes = plt.subplots(2, 3, figsize=(16, 9), sharex=True)
    axes = axes.flatten()
    efpd = df_case['EFPD'].values

    for idx, col in enumerate(KEY_ADENS):
        ax = axes[idx]
        if col in df_case.columns:
            data = df_case[col].values
            data_masked = np.where(data > 0, data, np.nan)
            ax.semilogy(efpd, data_masked, 'o-', markersize=3, linewidth=1.5)
            ax.set_title(col.replace('Adens_', ''), fontsize=12)
            ax.set_ylabel('atoms/barn/cm', fontsize=10)
            ax.grid(True, alpha=0.3)
        else:
            ax.text(0.5, 0.5, f'{col}\n(No Data)', ha='center', va='center', transform=ax.transAxes)

    axes[-1].axis('off')
    axes[4].set_xlabel('EFPD (day)', fontsize=10)
    axes[5].set_xlabel('EFPD (day)', fontsize=10)
    plt.suptitle(f'{case_name}: Key Isotope Atomic Density vs EFPD', fontsize=16, y=1.02)
    plt.tight_layout()
    out_path = Path(outdir) / case_name / 'inventory_vs_efpd.png'
    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()


def plot_poison_evolution(df_case, case_name, outdir):
    """绘制中子毒物随燃耗变化图。"""
    fig, axes = plt.subplots(1, 2, figsize=(14, 5), sharex=True)
    burnup = df_case['burnup_MWd_kgHM'].values
    for ax, cols, title in zip(
        axes,
        [POISON_DENS[:2], POISON_DENS[2:]],
        ['Mass Density Poisons', 'Atomic Density Poisons'],
    ):
        plotted = False
        for col in cols:
            if col in df_case.columns:
                data = df_case[col].values
                data_masked = np.where(data > 0, data, np.nan)
                ax.semilogy(burnup, data_masked, 'o-', markersize=3, linewidth=1.5, label=col)
                plotted = True
        ax.set_title(title, fontsize=13)
        ax.set_xlabel('Burnup (MWd/kgHM)', fontsize=10)
        ax.set_ylabel('Density', fontsize=10)
        ax.grid(True, alpha=0.3)
        if plotted:
            ax.legend(fontsize=8)
    plt.suptitle(f'{case_name}: Poison Evolution vs Burnup', fontsize=16, y=1.02)
    plt.tight_layout()
    out_path = Path(outdir) / case_name / 'poison_evolution.png'
    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()


def plot_fission_absorption_ratio(df_case, case_name, outdir):
    """绘制裂变/吸收比随燃耗变化图。"""
    fig, ax = plt.subplots(figsize=(10, 6))
    burnup = df_case['burnup_MWd_kgHM'].values
    for fiss_col, capt_col, label in RATIO_PAIRS:
        if fiss_col in df_case.columns and capt_col in df_case.columns:
            capt = df_case[capt_col].replace(0, np.nan)
            ratio = df_case[fiss_col] / capt
            ratio_masked = np.where(np.isfinite(ratio.values), ratio.values, np.nan)
            ax.plot(burnup, ratio_masked, 'o-', markersize=3, linewidth=1.5, label=label)

    ax.set_xlabel('Burnup (MWd/kgHM)', fontsize=12)
    ax.set_ylabel('Fission / Capture', fontsize=12)
    ax.set_title(f'{case_name}: Fission-to-Absorption Ratio', fontsize=14)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=8, ncol=2)
    plt.tight_layout()
    out_path = Path(outdir) / case_name / 'fission_absorption_ratio.png'
    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()


def plot_mass_density_efpd(df_case, case_name, outdir):
    """绘制核素质量密度随EFPD变化图。"""
    fig, axes = plt.subplots(2, 4, figsize=(20, 10))
    axes = axes.flatten()
    efpd = df_case['EFPD'].values

    for idx, (col, label) in enumerate(MASS_DENSITY_COLS):
        ax = axes[idx]
        if col in df_case.columns:
            data = df_case[col].values
            data_masked = np.where(data > 0, data, np.nan)
            ax.semilogy(efpd, data_masked, 'b-o', markersize=3, linewidth=1.5)
            ax.set_xlabel('EFPD (day)', fontsize=10)
            ax.set_ylabel('Mass Density (g/cm³)', fontsize=10)
            ax.set_title(label, fontsize=12)
            ax.grid(True, alpha=0.3)
        else:
            ax.text(0.5, 0.5, f'{label}\n(No Data)', ha='center', va='center', transform=ax.transAxes, fontsize=10)
            ax.set_title(label, fontsize=12)

    plt.suptitle(f'{case_name}: Mass Density Evolution vs EFPD', fontsize=16, y=1.02)
    plt.tight_layout()
    out_path = Path(outdir) / case_name / 'mass_density_vs_efpd.png'
    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()


def plot_all_isotopes_combined(df_case, case_name, outdir):
    """绘制所有核素在同一图中（对比图）"""
    isotopes = [
        ('Mdens_U233', 'U-233', 'blue'),
        ('Mdens_Pa233', 'Pa-233', 'orange'),
        ('Mdens_U235', 'U-235', 'green'),
        ('Mdens_Pu239', 'Pu-239', 'red'),
        ('Mdens_Am241', 'Am-241', 'purple'),
        ('Mdens_Am245', 'Am-245', 'brown'),
        ('Mdens_Sm149', 'Sm-149', 'pink'),
        ('Mdens_Xe135', 'Xe-135', 'gray'),
    ]
    
    burnup = df_case['burnup_MWd_kgHM'].values
    
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))
    
    # 主族核素 (U, Pu)
    for col, label, color in isotopes[:4]:
        if col in df_case.columns:
            data = df_case[col].values
            data_masked = np.where(data > 0, data, np.nan)
            ax1.semilogy(burnup, data_masked, '-o', markersize=3, linewidth=1.5, 
                        label=label, color=color)
    
    ax1.set_xlabel('Burnup (MWd/kgHM)', fontsize=12)
    ax1.set_ylabel('Mass Density (g/cm³)', fontsize=12)
    ax1.set_title(f'{case_name}: Major Isotopes', fontsize=14)
    ax1.legend(loc='best')
    ax1.grid(True, alpha=0.3)
    
    # 次要核素 (Am, Pa, Sm, Xe)
    for col, label, color in isotopes[4:]:
        if col in df_case.columns:
            data = df_case[col].values
            data_masked = np.where(data > 0, data, np.nan)
            ax2.semilogy(burnup, data_masked, '-o', markersize=3, linewidth=1.5, 
                        label=label, color=color)
    
    ax2.set_xlabel('Burnup (MWd/kgHM)', fontsize=12)
    ax2.set_ylabel('Mass Density (g/cm³)', fontsize=12)
    ax2.set_title(f'{case_name}: Minor Isotopes', fontsize=14)
    ax2.legend(loc='best')
    ax2.grid(True, alpha=0.3)
    
    plt.tight_layout()
    
    out_path = Path(outdir) / case_name / 'mass_combined.png'
    out_path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()


def process_all_cases(df, outdir):
    """处理所有算例，生成每个算例的图"""
    cases = df['case'].unique()
    
    for case_name in sorted(cases):
        df_case = df[df['case'] == case_name].copy()
        df_case = df_case.reset_index(drop=True)
        
        # 创建算例专用文件夹
        case_dir = Path(outdir) / case_name
        case_dir.mkdir(parents=True, exist_ok=True)
        
        # 生成图表
        plot_keff_fir_cr(df_case, case_name, outdir)
        plot_mass_evolution(df_case, case_name, outdir)
        plot_all_isotopes_combined(df_case, case_name, outdir)
        plot_inventory_evolution(df_case, case_name, outdir)
        plot_poison_evolution(df_case, case_name, outdir)
        plot_fission_absorption_ratio(df_case, case_name, outdir)
        plot_mass_density_efpd(df_case, case_name, outdir)
        print(f'Processing {case_name}, saved')
    
    print(f'\n=== All plots generated in {outdir} ===')


class Tee:
    """Duplicate stdout/stderr to both terminal and a log file."""

    def __init__(self, *streams):
        self.streams = streams

    def write(self, data):
        for s in self.streams:
            s.write(data)
            s.flush()

    def flush(self):
        for s in self.streams:
            s.flush()


def main():
    import argparse
    parser = argparse.ArgumentParser(
        description='Analyze Serpent results from CSV: generate Keff/FIR/CR and mass evolution plots per case.')
    parser.add_argument('--csv', '-c', 
                       default='C:\\Users\\lsy05\\serpent_data\\results\\data_processed\\V1\\data.csv',
                       help='Path to the processed CSV data file')
    parser.add_argument('--output', '-o',
                       default='C:\\Users\\lsy05\\serpent_data\\results\\analysis\\V1\\plots',
                       help='Output directory for plots')
    parser.add_argument('--log', '-l',
                       default=None,
                       help='Path to log file. Default: <output>/analyze_data_YYYYMMDD_HHMMSS.log')
    args = parser.parse_args()
    
    # 设置输出目录
    outdir = Path(args.output)
    outdir.mkdir(parents=True, exist_ok=True)

    # Setup tee logging so terminal output is also saved to file.
    if args.log:
        log_path = Path(args.log)
    else:
        ts = datetime.now().strftime('%Y%m%d_%H%M%S')
        log_dir = outdir / 'log'
        log_dir.mkdir(parents=True, exist_ok=True)
        log_path = log_dir / f'analyze_data_{ts}.log'

    log_path.parent.mkdir(parents=True, exist_ok=True)

    orig_stdout = sys.stdout
    orig_stderr = sys.stderr
    with open(log_path, 'a', encoding='utf-8') as log_file:
        sys.stdout = Tee(orig_stdout, log_file)
        sys.stderr = Tee(orig_stderr, log_file)

        try:
            print(f'Logging to {log_path}')
            # 加载数据
            print(f'Loading data from {args.csv}...')
            df = load_data(args.csv)
            print(f'Loaded {len(df)} rows, {df["case"].nunique()} cases')

            # 处理所有算例
            process_all_cases(df, outdir)
        finally:
            sys.stdout = orig_stdout
            sys.stderr = orig_stderr


if __name__ == '__main__':
    main()
