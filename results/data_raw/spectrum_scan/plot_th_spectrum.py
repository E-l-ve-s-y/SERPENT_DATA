import re
import numpy as np
import matplotlib.pyplot as plt
import os
import sys
from datetime import datetime
from glob import glob

# ============================
# 配置文件路径和参数
# ============================

base_path = r"C:\Users\lsy05\serpent_data\results\data_raw\spectrum_scan"
output_base_path = r"C:\Users\lsy05\serpent_data\results\analysis\spectrum_scan"
log_path = r"C:\Users\lsy05\serpent_data\results\data_raw\spectrum_scan"

# 要分析的文件夹名称列表（可按需添加）
folder_names = [
    "A008_d040",
    "A008_d050", 
    "A008_d060",
    "A008_d070",
    "A008_d076"
]

# 为每个文件夹指定显示标签
display_names = {
    "A008_d040": "d = 0.40",
    "A008_d050": "d = 0.50",
    "A008_d060": "d = 0.60",
    "A008_d070": "d = 0.70",
    "A008_d076": "d = 0.76"
}

# 颜色方案
colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd']

# 探测器编号范围 (0 到 25)
detector_range = range(0, 26)  # det0, det1, ..., det25

# ============================
# 日志记录类（只写入文件，不显示在终端）
# ============================

class Logger:
    """
    只将输出写入日志文件，不在终端显示
    """
    def __init__(self, log_file_path):
        self.log_file = open(log_file_path, 'w', encoding='utf-8')
        
        # 写入文件头
        self.log_file.write("="*80 + "\n")
        self.log_file.write(f"多探测器能谱分析日志\n")
        self.log_file.write(f"分析时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        self.log_file.write("="*80 + "\n\n")
        self.log_file.flush()
    
    def write(self, message):
        self.log_file.write(message)
        self.log_file.flush()
    
    def flush(self):
        self.log_file.flush()
    
    def close(self):
        self.log_file.write("\n" + "="*80 + "\n")
        self.log_file.write(f"分析结束时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        self.log_file.write("="*80 + "\n")
        self.log_file.close()

# 创建一个空的输出类来替代stdout
class NullOutput:
    def write(self, message):
        pass
    def flush(self):
        pass

# ============================
# 定义读取单个文件的函数
# ============================

def read_serpent_det_file(file_path):
    """
    读取Serpent detX文件，返回能量中点值和通量
    
    参数:
        file_path: 文件路径
    
    返回:
        E_mid: 能群中点能量
        flux: 通量值 (第11列)
        flux_norm: 归一化通量
    """
    with open(file_path, "r", encoding='utf-8', errors='ignore') as f:
        text = f.read()
    
    # 查找DET1数组
    det1_match = re.search(r"DET1\s*=\s*\[(.*?)\];", text, re.S)
    det1e_match = re.search(r"DET1E\s*=\s*\[(.*?)\];", text, re.S)
    
    if det1_match is None:
        raise ValueError(f"DET1 not found in {file_path}")
    if det1e_match is None:
        raise ValueError(f"DET1E not found in {file_path}")
    
    # 转换为numpy数组
    DET1 = np.loadtxt(det1_match.group(1).splitlines())
    DET1E = np.loadtxt(det1e_match.group(1).splitlines())
    
    n_groups = len(DET1E)  # 能群数量，应该是70
    n_rows = DET1.shape[0]
    n_cols = DET1.shape[1]
    
    # 处理 DET1 数据
    if n_rows == n_groups:
        # 情况1：直接匹配
        phi_u = DET1[:, 10]
        
    elif n_rows % n_groups == 0:
        # 情况2：行数是能群数的整数倍，需要求和
        n_sets = n_rows // n_groups
        # 重塑数组：从 (n_sets × n_groups, 12) 变成 (n_groups, n_sets, 12)
        reshaped = DET1.reshape(n_groups, n_sets, n_cols)
        # 对每组能群的 n_sets 个数据求和
        DET1_summed = np.sum(reshaped, axis=1)
        phi_u = DET1_summed[:, 10]
        
    else:
        raise ValueError(f"数据不匹配: DET1行数({n_rows}) 不能被能群数({n_groups})整除")

    # 提取数据
    E_mid = DET1E[:, 2]
    
    # 归一化
    flux_norm = phi_u / np.max(phi_u)

    return E_mid, phi_u, flux_norm

# ============================
# 分析单个探测器的所有文件夹
# ============================

def analyze_detector_for_all_folders(base_path, folder_names, detector_num, display_names=None):
    """
    分析所有文件夹中特定探测器的能谱数据
    
    参数:
        base_path: 基础路径
        folder_names: 文件夹名称列表
        detector_num: 探测器编号 (0-25)
        display_names: 显示名称字典
    
    返回:
        results: 包含所有数据的字典
    """
    results = {}
    
    print(f"\n{'='*60}")
    print(f"正在处理探测器 DET{detector_num}")
    print(f"{'='*60}")
    
    for folder in folder_names:
        folder_path = os.path.join(base_path, folder)
        
        # 构建文件路径: A008_d040.sss_det0.m, A008_d040.sss_det1.m, ...
        file_name = f"{folder}.sss_det{detector_num}.m"
        file_path = os.path.join(folder_path, file_name)
        
        print(f"  处理: {folder} -> {file_name}")

        if not os.path.isfile(file_path):
            print(f"    警告: 文件不存在，跳过")
            continue
        
        try:
            E_mid, phi_u, flux_norm = read_serpent_det_file(file_path)
            
            # 获取显示名称
            if display_names and folder in display_names:
                label = display_names[folder]
            else:
                label = folder
            
            results[folder] = {
                'E_mid': E_mid,
                'phi_u': phi_u,
                'flux_norm': flux_norm,
                'label': label,
                'folder': folder,
                'file_path': file_path
            }
            print(f"    ✓ 成功读取")
            
        except Exception as e:
            print(f"    ✗ 错误: {e}")
            continue
    
    return results

# ============================
# 绘制对比图并保存
# ============================

def plot_and_save_comparison(results, colors=None, detector_num=None, output_dir=None):
    """
    为单个探测器绘制所有文件夹的对比图并保存
    """
    if not results:
        print(f"探测器 DET{detector_num} 没有数据，跳过绘图")
        return
    
    # 图1: 归一化通量 per lethargy（对数坐标）
    plt.figure(figsize=(10, 8))
    
    for idx, (name, data) in enumerate(results.items()):
        color = colors[idx % len(colors)]
        plt.semilogx(data['E_mid'], data['flux_norm'], 
                  'o-', linewidth=1.5, markersize=4,
                  label=data['label'], color=color)
    
    plt.xlabel("Energy (MeV)", fontsize=12)
    plt.ylabel("Normalized Flux per Lethargy", fontsize=12)
    plt.title(f"DET{detector_num}: Normalized Neutron Spectra", fontsize=14, fontweight='bold')
    plt.grid(True, which='both', alpha=0.3)
    plt.legend(loc='best', fontsize=10)
    plt.tight_layout()
    
    # 保存图1
    if output_dir:
        filename = f"normalized_detector_{detector_num}.png"
        filepath = os.path.join(output_dir, filename)
        plt.savefig(filepath, dpi=300, bbox_inches='tight')
        print(f"  已保存: {filename}")
    
    # 图2: 绝对通量对比 per lethargy（对数坐标）
    plt.figure(figsize=(10, 8))
    
    for idx, (name, data) in enumerate(results.items()):
        color = colors[idx % len(colors)]
        plt.semilogx(data['E_mid'], data['phi_u'], 
                    'o-', linewidth=1.5, markersize=4,
                    label=data['label'], color=color)
    
    plt.xlabel("Neutron Energy (MeV)", fontsize=12)
    plt.ylabel("Neutron Flux per Unit Lethargy", fontsize=12)
    plt.title(f"DET{detector_num}: Absolute Neutron Spectra", fontsize=14, fontweight='bold')
    plt.grid(True, alpha=0.3)
    plt.legend(loc='best', fontsize=10)
    plt.tight_layout()
    
    # 保存图2
    if output_dir:
        filename = f"absolute_detector_{detector_num}.png"
        filepath = os.path.join(output_dir, filename)
        plt.savefig(filepath, dpi=300, bbox_inches='tight')
        print(f"  已保存: {filename}")

# ============================
# 为单个探测器打印能区份额统计
# ============================

def print_energy_region_fractions(results, detector_num=None):
    """
    计算并打印各能区的份额
    """
    thermal_limit = 6.25e-7  # 热能区上限 (MeV)
    fast_limit = 1e-1        # 快能区下限 (100 keV)
    
    if detector_num is not None:
        print("\n" + "="*60)
        print(f"探测器 DET{detector_num} - 各能区份额统计")
        print("="*60)
    else:
        print("\n" + "="*60)
        print("各能区份额统计")
        print("="*60)
    
    print(f"{'Case':<15} {'Thermal (<0.625 eV)':<20} {'Resonance':<20} {'Fast (>100 keV)':<20}")
    print("-"*75)
    
    for name, data in results.items():
        E_mid = data['E_mid']
        phi_u = data['phi_u']
        
        thermal = np.sum(phi_u[E_mid < thermal_limit])
        resonance = np.sum(phi_u[(E_mid >= thermal_limit) & (E_mid < fast_limit)])
        fast = np.sum(phi_u[E_mid >= fast_limit])
        total = thermal + resonance + fast
        
        print(f"{data['label']:<15} "
              f"{thermal/total*100:>6.2f}%{'':<14} "
              f"{resonance/total*100:>6.2f}%{'':<14} "
              f"{fast/total*100:>6.2f}%")
    
    print("="*60)

# ============================
# 保存汇总统计到文件
# ============================

def save_summary_statistics(all_results_summary, output_dir):
    """
    保存所有探测器的汇总统计到文本文件
    """
    summary_file = os.path.join(output_dir, "spectrum_summary.txt")
    
    with open(summary_file, 'w', encoding='utf-8') as f:
        f.write("="*80 + "\n")
        f.write("多探测器能谱分析汇总报告\n")
        f.write(f"生成时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write("="*80 + "\n\n")
        
        for det_num in sorted(all_results_summary.keys()):
            results = all_results_summary[det_num]
            if not results:
                continue
                
            f.write(f"\n探测器 DET{det_num}\n")
            f.write("-"*40 + "\n")
            f.write(f"{'Case':<15} {'Thermal':<12} {'Resonance':<12} {'Fast':<12}\n")
            f.write("-"*51 + "\n")
            
            thermal_limit = 6.25e-7
            fast_limit = 1e-1
            
            for folder, data in results.items():
                E_mid = data['E_mid']
                phi_u = data['phi_u']
                
                thermal = np.sum(phi_u[E_mid < thermal_limit])
                resonance = np.sum(phi_u[(E_mid >= thermal_limit) & (E_mid < fast_limit)])
                fast = np.sum(phi_u[E_mid >= fast_limit])
                total = thermal + resonance + fast
                
                f.write(f"{data['label']:<15} "
                       f"{thermal/total*100:>6.2f}%{'':<6} "
                       f"{resonance/total*100:>6.2f}%{'':<6} "
                       f"{fast/total*100:>6.2f}%\n")
        
        f.write("\n" + "="*80 + "\n")
    
    print(f"\n汇总统计已保存到: {summary_file}")

# ============================
# 主程序
# ============================

def main():
    # 创建日志文件
    log_filename = f"spectrum_analysis.log"
    log_filepath = os.path.join(log_path, log_filename)
    
    # 只写入日志文件，不显示在终端
    logger = Logger(log_filepath)
    
    # 保存原来的stdout
    original_stdout = sys.stdout
    
    # 将输出重定向到日志文件，终端不显示
    sys.stdout = logger
    
    try:
        print("="*70)
        print("多探测器能谱分析工具")
        print("="*70)
        print(f"分析文件夹: {folder_names}")
        print(f"探测器范围: DET{min(detector_range)} - DET{max(detector_range)}")
        print(f"输出目录: {output_base_path}")
        print(f"日志文件: {log_filepath}")
        print("="*70)
        
        # 创建输出目录
        os.makedirs(output_base_path, exist_ok=True)
        
        # 存储所有结果用于汇总
        all_results_summary = {}
        
        # 循环处理每个探测器
        for det_num in detector_range:
            # 分析该探测器的所有文件夹数据
            results = analyze_detector_for_all_folders(base_path, folder_names, det_num, display_names)
            
            if not results:
                print(f"\n探测器 DET{det_num} 没有找到有效数据，跳过")
                continue
            
            # 存储结果用于汇总
            all_results_summary[det_num] = results
            
            # 打印能区份额
            print_energy_region_fractions(results, detector_num=det_num)
            
            # 绘制并保存对比图
            plot_and_save_comparison(results, colors, detector_num=det_num, output_dir=output_base_path)
        
        # 保存汇总统计到文件
        if all_results_summary:
            save_summary_statistics(all_results_summary, output_base_path)
        
        print("\n" + "="*70)
        print(f"分析完成！所有图片已保存到: {output_base_path}")
        print(f"日志文件已保存到: {log_filepath}")
        print("="*70)
        
    finally:
        # 恢复标准输出
        sys.stdout = original_stdout
        logger.close()
        
        # 在终端显示简短提示（可选）
        print(f"\n分析完成！日志已保存到: {log_filepath}")

# ============================
# 运行主程序
# ============================

if __name__ == "__main__":
    main()