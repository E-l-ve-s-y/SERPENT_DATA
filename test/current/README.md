# test/current — CASMO-4 基准 pin-cell 对比测试集

> 父目录 `test/readme.md` 定义了 3 类基准题的功率归一化约定。本目录是当前在用的"快照"——3 个子问题 × 2 套统计精度 × 各自的 Serpent 输出。

---

## 1. 目录结构

```
test/current/
├── pin_cell/          # 基准: 功率归一化到燃料棒 (CASMO-4 标准做法)
│   ├── 5000/          #  set pop 5000 100 20  (低统计, 快速试算)
│   │   └── blanket/   #   Serpent 输出 (sss_res.m, det*.m, mesh PNG, ...)
│   └── 200000/        #  set pop 200000 500 20  (生产精度)
│       └── blanket/
│
├── pin_powden/        # 基准: 功率归一化到 HM 质量 (set powdens, MW/kgHM)
│   ├── 5000/blanket/  #  set pop 5000 100 20
│   └── 20000/blanket/ #  set pop 200000 500 20 
│
├── pin_power/         # 基准: 功率归一化到栅元体积 (set power, kW/L)
│   ├── 5000/blanket/  #  set pop 5000 100 20
│   └── 20000/blanket/ #  set pop 200000 500 20  (同上命名遗留)
│
└── compare/           # 对比工具与结果
    ├── kinf_compare_table.csv   # 三种基准的 k_inf 对比
    ├── origin.csv               # 原始参考数据
    └── script/
        └── extract_kinf_burnup.py  # 从 sss_res.m 提取 k_inf 与燃耗曲线
```

## 2. 3 种基准的物理差异

| 子目录 | 归一化方式 | 卡片内指令 | 物理意义 |
|--------|-----------|-----------|---------|
| `pin_cell`  | 燃料棒体积 | (默认, 无显式 set power/powdens) | CASMO-4 原版,功率仅在燃料棒内归一 |
| `pin_powden` | HM 质量 | `set powdens 0.03562` (= 35.62 kW/kgHM) | 单位质量可裂变核素的功率 |
| `pin_power`  | 栅元总体积 | `set power 178.695` (= 178.695 kW) | 把 MW/kgHM 换算到 kW/L 后的总功率(默认轴向高度 1 cm) |

**功率换算** (父 readme §方案A/B):
- 燃料芯块面积 0.6782 cm², 栅元面积 2.25 cm²
- 功率密度 79.42 W/cm³ → 线功率 178.695 W/cm
- HM 线密度 5.017 g/cm → 比功率 35.62 kW/kgHM
- pin_powden 和 pin_power 是同一物理量在不同卡片接口下的两种写法

## 3. 统计精度档位

| 子目录 | `set pop` | 适用场景 |
|--------|-----------|---------|
| `*/5000`  | `5000 100 20`   | 100 个有效 cycle, 快速试算/调试 (几分钟) |
| `*/200000` (pin_cell) | `200000 500 20` | 500 个有效 cycle, 生产精度 (~30 min) |
| `*/20000` (pin_powden, pin_power) | `200000 500 20` | 同上, 仅目录名遗留旧值 |

⚠ `pin_powden/20000` 和 `pin_power/20000` 这两个**目录名**写的是 20000,但 `set pop` 在 sss 里写的 200000,这是历史命名遗留,不影响物理结果。

## 4. 输出文件约定

每个 `*/<pop>/blanket/` 目录包含 Serpent 完整产物:
- `pin_cell.sss`       — 输入卡(本目录里的)
- `pin_cell.sss_res.m` — 结果(matlab 格式, k_inf, 燃耗等)
- `pin_cell.sss_dep.m` — 燃耗库存(matlab 格式)
- `pin_cell.sss_det<N>.m` — 探测器输出(每个燃耗步一个文件)
- `pin_cell.sss.out`   — Serpent 主日志
- `pin_cell.sss.wrn`   — 警告(可空)
- `pin_cell.sss.seed`  — 随机种子
- `pin_cell.sss_mesh1_bstep<N>.png` — 几何/通量图
- `nohup.out`          — 终端输出(脚本运行时重定向)

## 5. 运行任一算例

```bash
# 进入具体算例目录
cd /home/sy_lu/test/current/pin_cell/200000/blanket

# 单次运行
sss2 pin_cell.sss
# 或带线程 (96 核机器建议 -omp 96 满核,或 -omp 80 留一点裕量)
nohup sss2 -omp 96 pin_cell.sss > nohup.out 2>&1 &
```

## 6. 跑对比

```bash
# 三种基准都跑完后,生成对比表
cd /home/sy_lu/test/current/compare
python script/extract_kinf_burnup.py
# 输出: kinf_compare_table.csv (与 origin.csv 对照)
```

`extract_kinf_burnup.py` 从三种基准的 `*_res.m` 抽取 `ANA_KEFF` 与燃耗步,生成同一张表上的对比曲线——验证三种归一化方式在物理上**应该**给出一致的 k_inf(因为是同一功率密度的不同表示)。

## 7. 引用与参考

- 父目录 `test/readme.md`: 命名约定与功率换算公式
- 3 类基准的 CASMO-4 原始定义: 见 `test/LW_SMR/` 与 `test/SMR_hete/`(如有)
- 本目录只放"当前在用"快照,历史版本如 `test/test3/`, `test/test4/`, `test/test_pot/` 不在此

## 8. 复现指南

如要重做整套对比:
```bash
for sub in pin_cell/200000 pin_powden/20000 pin_power/20000; do
    cd /home/sy_lu/test/current/$sub/blanket
    sss2 pin_cell.sss
done
cd /home/sy_lu/test/current/compare
python script/extract_kinf_burnup.py
```

3 个案 × ~30 min/案 ≈ 1.5 小时可重做完整对比。
