# Serpent Data Analysis Platform

实现可燃毒物控制的高转化比钍基压水堆中子学分析。

本仓库用于整理和分析 SERPENT 蒙特卡洛燃耗计算结果，目标是把原始算例输出转成可分析、可绘图、可供后续优化算法直接调用的数据层。

## 项目结构

```text
serpent_data/
├── README.md
├── AGENTS.md
├── CLAUDE.md
└── results/
	├── data_raw/
	│   ├── A001/ ... D020/
	│   └── cases.csv
	├── data_processed/
	│   ├── data.csv
	│   ├── detector_spectra.csv
	│   ├── data_lake.db
	│   └── neutron_spectra/
	├── analysis/
	│   └── plots/
	└── script/
		├── extract_data.py
		├── analyze_data.py
		├── plot_examples.py
		├── data_layer.py
		├── cache_layer.py
		├── agents.py
		├── orchestrator.py
		└── generate_cases.py
```

## 整体架构

数据流分为四层：

1. 原始输入层：results/data_raw/ 下保存每个 case 的 SERPENT 输出，包括 .sss、.sss_dep.m、.sss_res.m、.sss_det*.m 等文件。
2. 提取层：results/script/extract_data.py 负责解析燃耗、核素库存、反应性、反应率和探测器谱，并生成结构化 CSV。
3. 数据层：results/data_processed/data.csv 和 results/data_lake.db 作为分析主数据源，便于 pandas、SQLite 和 AI agent 调用。
4. 分析层：results/script/analyze_data.py 和 results/script/plot_examples.py 负责生成各类图表，输出到 results/analysis/plots/。

## 脚本职责

### results/script/extract_data.py

这是数据进入分析管道的入口脚本，主要功能包括：

- 解析 .sss_dep.m 中的 MAT_fuel_MDENS、MAT_fuel_ADENS、MAT_fuel_BURNUP。
- 解析 .sss_res.m 中的 ANA_KEFF、CONVERSION_RATIO 和关键反应率。
- 解析 *.sss_det*.m 中的探测器能谱，并导出探测器汇总 CSV（results/data_processed/detector_spectra.csv）。
- 计算绝对质量列 Mass_*_kg，保留原子数密度列与质量密度列。
- 生成 results/data_processed/data.csv，并可同步更新 SQLite Data Lake。

### results/script/analyze_data.py

这是主分析脚本，按 case 逐个生成图表。当前已经覆盖：

- 燃耗-反应性图：burnup_MWd_kgHM 对 ANA_KEFF。
- FIR / CR 曲线：burnup_MWd_kgHM 对 conversion_ratio，并计算 FIR。
- 关键核素库存随时间图：以 EFPD 为横轴，使用 Adens_*。
- 中子毒物演化图：Mdens_Sm149、Mdens_Xe135 以及对应 Adens_*。
- 裂变/吸收比图：基于 *_FISS 与 *_CAPT。
- 核素质量密度随时间图：以 EFPD 为横轴，使用 Mdens_*。

### results/script/plot_examples.py

这是示例绘图脚本，适合快速检查单张图效果或做轻量演示。它保留原子数密度图，同时补充中子毒、裂变/吸收比和堆叠质量图。

### results/script/data_layer.py

SQLite 数据层封装，向上提供 case 级查询、筛选、流式读取等接口，便于后续做批量分析和 agent 问答。

### results/script/orchestrator.py

批量调度层，可并行执行分析任务和优化任务，适合后续做多目标设计筛选。

### results/script/generate_cases.py

用于批量生成 SERPENT 输入卡，基于给定配方和几何参数自动生成 case。

## 关键数据字段

现有 data.csv 已经包含分析所需的大部分字段：

- 燃耗：burnup_MWd_kgHM
- 时间：EFPD
- 反应性：ANA_KEFF、reactivity_pcm
- 转化比：conversion_ratio
- 质量密度：Mdens_*
- 原子数密度：Adens_*
- 绝对质量：Mass_*_kg
- 裂变率：*_FISS
- 吸收率：*_CAPT

其中 Mass_*_kg 是基于组件体积与质量密度计算得到的绝对质量列，适合做总量守恒和堆叠图。

## 输出目录

- results/data_processed/data.csv：主分析表。
- results/data_processed/detector_spectra.csv：探测器能谱汇总表。
- results/data_processed/data_lake.db：SQLite 数据湖。
- results/data_processed/neutron_spectra/：谱图输出。
- results/analysis/plots/：主分析脚本输出。
- results/analysis/plots/example/：示例绘图脚本输出。

## 运行方式

建议从 results/ 目录运行脚本：

```powershell
cd results
python script/extract_data.py --csv
python script/analyze_data.py --csv data_processed/data.csv --output analysis/plots
```

如果只想快速看示例图，可以运行：

```powershell
cd results
python script/plot_examples.py --csv data_processed/data.csv --out analysis/plots/example
```

## 当前能力与边界

已支持：

- 燃耗、反应性、CR、库存、毒物、裂变/吸收比、绝对质量、7 能群谱提取。
- case 级批量分析和输出。

仍未覆盖或需要额外输入的内容：

- 更细的空间功率分布、组件内/组件间非均匀性。
- 多普勒反应性系数和慢化剂温度系数等温度反馈参数。
- 依赖更多 detector 或 tally 的高分辨率中子谱时，需要进一步扩展提取器。

## 说明

仓库的脚本默认使用系统 Python，并假定从 results/ 目录启动。这样可以保证相对路径、导入路径和输出路径都与当前目录结构一致。
