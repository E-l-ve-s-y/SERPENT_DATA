# 后续工作计划 (Future Work)

> 本文档列出当前 Th-232 俘获分析之外的扩展方向。
> 优先级标记：高 = 直接影响物理结论；中 = 提升数据可用性；低 = 锦上添花
> 详细依据见 `analysis_report.md` §4-§7

---

## FW-1 空间分辨（pin-by-pin 网格 tally）

**目标**：把每个 Th 燃料棒的径向/轴向分辨到网格元，量化**空间自屏蔽**。

**当前缺口**：所有 Th-232 探测器 `dm <case>` 是**体积平均**的，看不见棒内梯度。

**实施步骤**：
1. SERPENT 输入增加 `det th232_capN ... dm <case> dl 1000` + `mesh 3 ...` 或 `det ... dr 102 ... de 1 dl 1e-9 2e1 de 1 dz 1000 0 358.234`
2. 用 `mesh` 卡 + `set adf 0` 抽出每个 pin 的局部反应率
3. 写新脚本 `plot_th232_pin_resolved.py` 输出 17×17 栅格热图

**预期产出**：
- 每个 Th 棒中心的微观率 vs 边缘的微观率（应有 ~10-30% 梯度）
- 角向分布（如果是角对称可验证）

**优先级**：高
**依赖**：新增 `det` 块；不需改数据

---

## FW-2 多温度扫描（Doppler 展宽效应）

**目标**：分离**密度自屏蔽**和**Doppler 展宽**两种效应。

**当前缺口**：所有算例都在 900 K，无法区分 N 变化 vs T 变化的贡献。

**实施步骤**：
1. 在 SERPENT 输入中改 `tmp 900` → `tmp 600` / `1200`（燃料温度）
2. 重新跑 18 算例 × 3 温度 = 54 个 SERPENT run
3. 提取 `MAT_*_BURNUP` 中的有效 Doppler 反应性反馈

**预期产出**：
- `micro(N, T=900K) / micro(N, T=600K)` 比值
- 共振峰（21.8 eV）随 T 上升而展宽下移的曲线
- Doppler 系数 ∂ρ/∂T = (Δk/k) / ΔT

**优先级**：高
**依赖**：54 次 SERPENT run（耗时，~10-20 min/case）

---

## FW-3 Doppler 系数定量

**目标**：导出 MWD 级别的 Doppler 反应性反馈。

**实施步骤**：
1. 在 FW-2 数据基础上，对每个 case 计算 keff(T) 线性回归
2. 提取 Doppler 系数（pcm/K）
3. 画 α_D vs Th 含量曲线（应单调正：Th 越多，Doppler 越负）

**预期产出**：
- `Doppler_coefficient.csv` (case, T, keff, alpha_D)
- 与 N_Th232 的相关性分析

**优先级**：中
**依赖**：FW-2

---

## FW-4 多核素扩展

**目标**：从单一 Th-232 扩展到其他关键核素。

**已有探测器**（从输入卡看）：
- `u235_fiss1/2/3` （MT=18 裂变）
- `u238_cap1/2/3` （MT=102 俘获）
- `pu239_fiss1/2/3`
- `th232_cap1/2/3`
- `pa233_cap1/2/3`

**实施步骤**：
1. 复用 `read_capture_sum` 框架，把 `DETth232_capN` 换成 `DETu235_fissN` 等
2. 写通用 `read_<isotope>_<rxn>` 函数
3. 出 5 个核素 × 3 族的并排图

**预期产出**：
- U-235 裂变率谱（应为标准 1/E + 热峰）
- U-238 俘获谱（238U 共振在 6.7 eV、20 eV、36 eV）
- Pu-239 裂变谱（与 U-235 形状对比）
- Pa-233 俘获谱（用于 Th 燃耗链：Th-232 → Pa-233 → U-233）

**优先级**：高
**依赖**：现有 detector 框架（无需新 SERPENT run）

---

## FW-5 时间演化（25 步燃耗）

**目标**：跟踪微观/宏观反应率从 BOC 到 EOC 的演化。

**当前缺口**：`_det0.m` 是 BOC 快照。`_det1.m` 到 `_det25.m` 已存在但**未读取**。

**实施步骤**：
1. 扩展 `read_capture_sum` 接受 `det_num` 参数（0-25）
2. 写 `plot_th232_capture_evolution.py` 画 BU vs micro/peak E/region fraction
3. 同时读 `MAT_*_ADENS` 的每行（不只 BOC）→ 跟踪 N_Th232(t)

**预期产出**：
- BU 演化热图（case × 燃耗步 × 能群）
- 自屏蔽比随燃耗变化（Th 减少→自屏蔽减弱→per-atom 率上升）
- 共振区份额随燃耗变化

**优先级**：高
**依赖**：det1-det25 文件已存在

---

## FW-6 自屏蔽修正（NR 近似 / 子群参数）

**目标**：把"per-atom 率"归一到**无穷稀释参考谱**下，分离核数据本征截面与自屏蔽效应。

**实施步骤**：
1. SERPENT `set nfmtx` 启用子群参数
2. 或用 `set rfw 1` 开启 Bondarenko 迭代
3. 提取有效自屏蔽截面 σ_eff(E, σ_0)
4. 拟合 `σ_eff ∝ 1/√σ_0` 趋势（NR 近似特征）

**预期产出**：
- `sigma_eff_vs_dilution.csv` (E, sigma_0, sigma_eff)
- NR 拟合系数（用于多群数据库修正）

**优先级**：中
**依赖**：新增 SERPENT 子群卡；新后处理脚本

---

## FW-7 7 群结构归并（与 AGENTS.md 兼容）

**目标**：把 70 群结果归并到 7 群结构（已有边界定义在 `AGENTS.md`）。

**AGENTS.md 7 群边界**（已在系统 prompt）：
| Group | 能量范围 (eV) |
|---|---|
| G1 | 1e-11 - 4e-9 |
| G2 | 4e-9 - 1e-8 |
| G3 | 1e-8 - 1e-7 |
| G4 | 1e-7 - 6.25e-7 |
| G5 | 6.25e-7 - 9.06e-4 |
| G6 | 9.06e-4 - 3e-3 |
| G7 | 3e-3 - 20 |

**实施步骤**：
1. 写 `collapse_70_to_7_groups.py`
2. 加权平均（用当前通量作为权重）
3. 输出 `th232_capture_7group.csv` 供堆芯物理使用

**优先级**：中
**依赖**：当前 70 群数据已够

---

## FW-8 与 OpenMC / SCALE 交叉验证

**目标**：用不同蒙特卡洛/确定论代码验证当前结果。

**实施步骤**：
1. 选 3 个代表 case（M43-5, M70-20, M87-30）用 OpenMC 重跑
2. 比较 Th-232 俘获谱
3. 比较 keff、CR

**预期产出**：
- `validation_M43-5_OpenMC.csv` 逐群比值
- 偏差报告

**优先级**：中
**依赖**：FW-4（多核素）；OpenMC 安装

---

## FW-9 共振积分定量（拟合 NR 系数）

**目标**：把当前 M87-5 / M87-30 数据拟合到 NR 近似公式，提取经验系数。

**公式**：
$$\sigma_{eff}(E) = \sigma_\infty(E) \times \frac{1}{1 + \sqrt{N \cdot I(E) / \sigma_\infty(E)}}$$

**实施步骤**：
1. 提取每个 case 的有效自屏蔽系数
2. 拟合 `I(E)` 经验函数
3. 验证 1/√N 趋势

**预期产出**：
- 共振积分经验公式
- 与理论 NR 值的偏差

**优先级**：中
**依赖**：当前数据已够；无需新 SERPENT run

---

## FW-10 与 Isotope_evolution 联动

**目标**：把当前 BOC 俘获率与同位素演化（U-233、Pa-233 累积）联动。

**已有数据**（从 DATA_DICTIONARY.md）：
- `Isotope_evolution/` 已有 21 核素 × 19 case × 25 步的 adens
- `Isotope_comparison/` 已有 EOC 时刻的核素分布

**实施步骤**：
1. 计算每个 case 的 Th-232 总捕获数：∫R_macro × V × dt
2. 与 U-233 累积量对比（应为 ~线性，斜率 = 转换比的一部分）
3. 输出 `breeding_chain_balance.csv`

**优先级**：低
**依赖**：现有 Isotope_evolution 数据

---

## 工作量估算

| 编号 | 主题 | 工作量 | 关键挑战 |
|---|---|---|---|
| FW-1 | 空间分辨 | 中（1-2 周） | SERPENT mesh 卡调试 |
| FW-2 | 多温度扫描 | 高（1 周+ 跑批） | 54 次 run 时间 |
| FW-3 | Doppler 系数 | 低（FW-2 后续） | 线性回归 |
| FW-4 | 多核素扩展 | 中（3-5 天） | 函数泛化 |
| FW-5 | 时间演化 | 中（3-5 天） | 25 步 × 18 算例数据整合 |
| FW-6 | 自屏蔽修正 | 高（2 周+） | 子群方法理论 |
| FW-7 | 7 群归并 | 低（1-2 天） | 权重通量 |
| FW-8 | OpenMC 验证 | 高（2 周+） | 跨代码模型搭建 |
| FW-9 | NR 拟合 | 低（1-2 天） | 非线性拟合 |
| FW-10 | 同位素联动 | 低（1-2 天） | 已有数据整合 |

**建议优先级顺序**：FW-4 > FW-5 > FW-1 > FW-7 > FW-2 > FW-9 > FW-6 > FW-3 > FW-10 > FW-8
