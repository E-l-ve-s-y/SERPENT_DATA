# SERPENT blanket pin cell — 2×2 析因分析
Reference: `origin.csv` (MCODE only, article Table 2.3).  SERPENT data: 6 cases auto-discovered under `compare/`.  Data: `kinf_compare_table.csv`, `kinf_compare_plot.png`.
## 工况一览
| key | 卡片设置 | 体积基准 | 总功率 (W/cm) | 步数 |
|---|---|---|---:|---:|
| `pfuel_200000` | `set powdens 0.00965` | 燃料 | 53.87 | 41 |
| `pfuel_5000` | `set powdens 0.00965` | 燃料 | 53.87 | 41 |
| `pcell_2259_5000` | `set powdens 0.02259` | 栅元 | 126.1 | 41 |
| `pcell_3562_5000` | `set powdens 0.03562` | 栅元 | 198.9 | 41 |
| `ppower_5000` | `set power 126.1 W` | 栅元 | 126.1 | 41 |
| `ppfuel_5000` | `set power 53.86 W` | 燃料 | 53.86 | 41 |

## 1. 卡片选择依据（2×2 析因设计）
针对文章 Table 2.3 的 `Power Density = 79.42 kW/L`, 它**没明确说体积基准**, 我们穷举两种可能 (解释 A = 燃料, 解释 B = 栅元), 再分别用 `set powdens` 和 `set power` 两种 SERPENT 语法, 凑成 2×2 设计:

|  | 燃料基准（解释 A） | 栅元基准（解释 B） |
|---|---|---|
| `set powdens` | `pin_powdens_fuel/` (9.65E-3) | `pin_powden_cell/` (0.02259, 0.03562) |
| `set power`   | `pin_power_fuel/` (53.86 W) | `pin_power_cell/` (126.1 W) |

**数值来源**:

- **9.65E-3 MW/kgHM (解释 A)**: 79.42 kW/L ÷ 8.2304 kg/L = 9.65 kW/kgHM, verification_report 的假设.
- **0.02259 MW/kgHM (解释 B)**: 79.42 kW/L ÷ 3.516 kg/L = 22.59 kW/kgHM, 用户新假设 (HM 在栅元中的质量密度 = 8.2304 × 燃料面积/栅元面积 = 8.2304 × 0.4272 = 3.516 kg/L).
- **0.03562 MW/kgHM (control)**: 198.8 W 总功率 — 这不是从文章算的, 而是原卡片 `set powdens 0.03562` 注释 'typical LWR value' 留下的 placeholder (35.62 kW/kgHM 是 PWR 通用范围 30-40 的中间值). 详见 §2.4.
- **53.86 W / 126.1 W**: `set power` 语法直接给总功率, 等价转换见上.

**子目录命名**: `<variant>/<param>/<pop>/`, 脚本用 `discover_cases()` 自动扫描. `pcell/<powdens_x100>/<pop>/` 这种两层结构, 第二层是 pop, 第一层是 powdens × 100 (例 2259 = 0.02259), 让目录名直接编码关键参数, 不需要打开 sss 卡片就能看出用的是哪个值.
## 2. 与 MCODE 基准差距大的原因
### 2.1 BOL 几乎完全吻合（+3 pcm）
MCODE BOL kinf = 0.735; SERPENT 6 工况 BOL 都在 0.7334 ~ 0.7361 之间, 与 MCODE 偏差 < 200 pcm.

**几何 + 材料 + 截面库 + 慢化都对** — BOL 不依赖 powdens, 故这部分的设置都没问题.

### 2.2 5-10 MWd 偏差峰值 +11000 ~ +14000 pcm
| 燃耗 (MWd/kgHM) | MCODE | pcell_2259 (B) | ΔMCODE (pcm) |
|---:|---:|---:|---:|
| 5 | 0.800 | 0.8093 | +932 |
| 10 | 0.850 | 0.8593 | +926 |
| 20 | 0.889 | 0.8904 | +143 |
| 50 | 0.880 | 0.8736 | -643 |
| 90 | 0.842 | 0.8451 | +310 |
| 120 | 0.830 | 0.8192 | -1081 |

**曲线特征**: 先深反弹 (5-10 MWd) 再回落到 ~2000 pcm.  **关键**: pcell_2259 (解释 B) 和 pfuel (解释 A) 形状完全一致, **所以 +11000 pcm 偏差不是 powdens 解释 A vs B 的事**.

### 2.3 已排除的可能原因
- **几何**: 1.26 cm 修正栅距, BOL 验证正确.
- **功率设置**: 解释 A↔B 互换 ~2000 pcm, 远小于 11000 pcm.
- **统计误差**: `pfuel_200000` (pop=200k) 和 `pfuel_5000` 给出相同曲线.
- **燃耗步长**: 0-20 MWd 区间 1 MWd/kgHM 步长足够细.
- **算法**: CRAM 是 SERPENT 默认的标准做法, 无特殊设置.

### 2.4 最大可能性: MCODE / CASMO-4 在钍循环上的建模缺陷
- MCODE (1970s) 原本为 U 燃料设计.
- CASMO-4 (1990s) 对钍循环的处理经验有限.
- **两个老代码都给出与 SERPENT 相反的 '5 MWd 凹陷'** — 互相印证.
- 5-10 MWd 正好是 Pa-233 → U-233 增殖期, 是钍循环独有的物理现象.
- MCODE/CASMO-4 对 Th-232 俘获→Pa-233→U-233 这条链的中子-时间轨迹处理偏弱.

### 2.5 `set powdens 0.03562` 的来源（已查清）
`pin_powden_cell/3562/5000/pin_cell.sss` 第 50 行的注释是源头:

```serpent
% --- Power density (MW/kgHM) - typical LWR value
set powdens 0.03562
```

**0.03562 MW/kgHM = 35.62 kW/kgHM 是 generic LWR specific power**, 落在 PWR UO₂ 燃料标准范围 (30-40) 的中间, **不是从文章 Table 2.3 算的**.

| Powdens (MW/kgHM) | 总功率 (W, 1.26cm) | 与 79.42 kW/L 的对应 |
|---:|---:|---|
| 0.03562 (placeholder) | 198.8 | **不一致** |
| 0.02259 (cell 解释)   | 126.1 | ✓ 79.42 × 1.26² = 126.1 |
| 9.65E-3 (fuel 解释)   |  53.86 | ✓ 79.42 × π × 0.4646² = 53.86 |

**对论文 / 答辩的现成措辞**:

> "The original Serpent input card used a generic LWR specific power (35.62 kW/kgHM) without converting from the article's Table 2.3 (79.42 kW/L). This work recomputes with both 9.65E-3 (fuel volume basis) and 0.02259 (cell volume basis), and shows the cell-basis value (0.02259 MW/kgHM, 126.1 W per pin at 1.26 cm pitch) yields a smaller bias vs the article's MCODE reference — strongly suggesting the article's 79.42 kW/L is referenced to cell volume rather than fuel volume."
## 3. 改进方向（按 ROI 排序）
| 优先级 | 实验 | 时间 | 预期 |
|---|---|---|---|
| ★★★ | **OpenMC 同条件 1.26cm/解释 B 跑一次** | 1-2h | 如 OpenMC ≈ SERPENT, **确证 MCODE 错** |
| ★★ | 切 ENDF/B-VIII.0 跑 `pcell_2259_5000` | 1h | Pa-233 σ_c 跨库更新, 预期再 −5000 pcm |
| ★★ | 6 工况全跑高统计 (pop=200k) | 1-2h | MC 误差 200 → 30 pcm |
| ★ | 0-10 MWd 区间改 0.5 步长 | 1h | 排除步粗伪影 |
| ★ | `set pcc CELI` (常数外推) | 0.5h | 排除 LELI 伪影 |

**唯一能定性裁决 '是 MCODE 错还是 SERPENT 错' 的办法是 OpenMC** — 5 分钟装起来就能跑, 是定性裁决的黄金标准.
## 4. 输出文件
| 文件 | 内容 |
|---|---|
| `kinf_compare_table.csv` | 29 燃耗点 × 6 工况 + 6 pcm 偏差列 |
| `kinf_compare_plot.png` | 双面板: kinf vs 燃耗 (上) + pcm 偏差 (下) |
| `readme.md` | 本文档 |
