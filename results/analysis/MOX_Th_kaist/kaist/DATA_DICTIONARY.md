# KAIST Th-MOX Analysis — Data Dictionary

> 涵盖 `D:\serpent_data\results\analysis\MOX_Th_kaist\kaist\` 下所有 CSV 列的说明。
> 数据由 18 个 Th-MOX 算例 + 1 个 mox1 基准产生（`M{43,70,87}-{5,10,15,20,25,30}` × 3 family + mox1）。
> 生成脚本位于 `D:\serpent_data\results\data_raw\MOX_Th_kaist\kaist\*.py`（`plot_*.py` / `analyze_*.py`）。

---

## 0. 通用命名约定

| 列名 | 含义 | 备注 |
|---|---|---|
| `case` | 算例名，格式 `M{pu}-{th*10}`（mox 例外） | 例：`M43-30` = 4.3% Pu + 30% Th；`mox1` = 纯 MOX 基准 |
| `family` | Family 标签，取 case 前缀 | `M43` / `M70` / `M87` / `mox1`（4 类） |
| `th_content_pct` | Th 投料分数（Th/HM × 100） | 5, 10, 15, 20, 25, 30 |
| `th_fraction` | th_content_pct 的浮点形式 | 同上，只是 `isotope_comparison_all_long.csv` 里的旧版字段 |
| `burnup` / `burnup_MWd_kgHM` | 燃耗深度（MWd/kgHM） | 0 → 50 步进 |
| `adens` | 原子密度 | atom / (barn·cm) |
| `mdens` | 质量密度 | g/cm³ |
| `bstep` | 燃耗步序号（整数） | 0..25（与 burnup 一一对应） |
| `BOC` | Beginning of Cycle（循环起点） | 物理量取第 0 步 |
| `EOC` | End of Cycle（循环终点） | 物理量取最后一步 |
| `*_norm` | 归一化列 | 通常以 M43（或 M43-5）为基线 |
| `per_rod` | "每根 Th 棒"归一化 | `value / n_th_rods` |

通用单位：
- **adens（原子密度）**：1 barn·cm = 10⁻²⁴ cm³，所以 atom/barn·cm = 10²⁴ atom/cm³
- **mdens（质量密度）**：g/cm³
- **R_Th（反应率）**：reactions/s（取自 `*_res.m` 的 analog estimator）
- **NU233final**：EOC 时刻的 U233 原子密度

---

## 1. `Isotope_comparison/`

### 1.1 `isotope_comparison_all_long.csv` — **长格式核素演变**

长格式（long format），每个 (case, isotope, burnup_step) 一行。

| 列 | 类型 | 含义 |
|---|---|---|
| `isotope` | str | 同位素名（21 个：`Th232`, `Pa233`, `U233`, ..., `Xe135`, `Sm149`, `Cs137`, `Nd143`） |
| `case` | str | 算例名（同上） |
| `family` | str | M43 / M70 / M87 / mox1 |
| `th_fraction` | float | Th 投料分数（5.0–30.0，浮点形式） |
| `burnup` | float | 燃耗步对应的 burnup（MWd/kgHM），0.0 → 50.0 |
| `adens` | float | 该 isotope 在该 burnup 的原子密度（atom/barn·cm） |

**行数**：9750 = 18 cases × 25 burnup steps × 21 isotopes + 头行
（注意：实际是 19 cases × 25 × 21 = 9975，但 mox1 的 Th 行为空，仍占行）

**用途**：画各 isotope 跨 case / 跨 burnup 的演变曲线；做 family 间对比。

---

### 1.2 `isotope_comparison_<isotope>.csv` — **单核素宽格式（21 个文件）**

每个 isotope 一个文件，宽格式：列为 case，行为 burnup。

| 列 | 含义 |
|---|---|
| （隐式行索引） | burnup 步（与 `all_long` 中 burnup 对应） |
| `M43-10`, `M43-15`, ..., `mox1` | 19 个 case 的 adens 时间序列 |

文件命名（21 个）：
`Th232`, `Pa233`, `U233`, `U234`, `U235`, `U236`, `U237`, `U238`,
`Np237`, `Np239`, `Pu238`, `Pu239`, `Pu240`, `Pu241`, `Pu242`,
`Am241`, `Am243`, `Xe135`, `Sm149`, `Cs137`, `Nd143`

**行数**：通常 25（对应 25 个 burnup 步）。

---

### 1.3 `isotope_comparison_end_burnup_pivot.csv` — **EOC 时刻 21 核素 × 19 case 透视表**

宽格式，**只取每个 case 的 EOC（最后一步）的 adens**。

| 列 | 含义 |
|---|---|
| `isotope` | 21 个核素名（同上） |
| `M43-10` ... `mox1` | 19 个 case 的 EOC 时刻 adens |

**行数**：21（核素）
**列数**：20（1 个 isotope + 19 个 case）

**用途**：做 family 间 / case 间 adens 横向对比；做"端点矩阵"展示。

---

## 2. `Isotope_evolution/`

### 2.1 `isotope_evolution_final_burnup.csv` — **EOC 时刻 12 关键核素**

每个 case 一行，包含 EOC 时刻 12 个核素的 adens + 2 个聚合量。

| 列 | 含义 | 单位 |
|---|---|---|
| `case` | 算例名 | str |
| `material` | 该 case 的 Th 棒 material 名 | str（一般与 case 同名） |
| `Th232`, `U233`, `U235`, `U238` | 4 个主锕系核素 adens | atom/barn·cm |
| `Pu239`, `Pu240`, `Pu241`, `Pu242` | 4 个 Pu 同位素 adens | atom/barn·cm |
| `Xe135`, `Sm149` | 2 个主要裂变产物毒物 adens | atom/barn·cm |
| `burnup_end` | EOC 燃耗 | MWd/kgHM（固定 50.0） |
| `eta_end` | EOC 时刻的 Th 利用率 η_Th = (N_Th,0 - N_Th)/N_Th,0 | 无量纲（0-1） |

**行数**：18（缺 mox1；mox1 在原统计中无 Th 数据）

**`eta_end` 的计算**：
```
eta_Th = (N_Th_initial - N_Th_final) / N_Th_initial
```

---

## 3. `Pin_power/M{43,70,87}-{th*10}/` 和 `Pin_power/mox1/`

### 3.1 `{case}_pin_power_1_8.csv` — **组件 1/8 视图的逐栅元功率**（19 个文件）

每个 case 一个文件（19 个文件 × 8 列 × 1014 行）。

| 列 | 含义 | 单位 |
|---|---|---|
| `case` | 算例名 | str |
| `bstep` | 燃耗步序号（0..25） | int |
| `burnup_MWd_kgHM` | 该步燃耗 | MWd/kgHM |
| `row_1of8` | 1/8 视图的行号（1..9） | int |
| `col_1of8` | 1/8 视图的列号（1..9） | int |
| `power_raw` | 该栅元原始功率 | （任意归一单位） |
| `power_normalized` | 归一化到"燃料栅元平均 = 1"的功率 | 无量纲 |
| `rel_error_pct` | 相对 1.000 的偏差（%） | % |

**行数**：1014 = 26 burnup steps × 9×9/2 = 26 × 40.5（实际 1014 是因为包含了所有 9×9 = 81 个格子的所有燃耗步，1014 = 26 × 39，不含水洞等被 mask 的格）

实际：每燃耗步 39 个有效栅元（1/8 视图的下三角 + 排除水洞），共 26 步 = 1014 行

**`power_normalized` 的归一化基准**：该 case 当前燃耗步下**所有有效燃料栅元**的功率平均值（即 `mean over fuel pins = 1`）。

**用途**：画 1/8 视图的 pin-power 分布图（PNG）；检查功率峰位置和均匀性。

---

## 4. `Th232_capture/`

### 4.1 `Th232_capture_contribution_table.csv` — **Th232 俘获按能区分布**

每个 case 一行，4 个能区列（**百分比，4 列之和 = 100%**）。

| 列 | 含义 | 能量范围 |
|---|---|---|
| `case` | 算例名 | str |
| `Thermal` | 热区份额（%） | E < 0.625 eV |
| `Epithermal` | 超热区份额（%） | 0.625 eV ≤ E < 0.1 MeV (100 keV)，**扣除 Resonance 主峰**后的 1/E 平台 |
| `Resonance` | 共振区主峰份额（%） | 同上范围内的 21-200 eV 主峰（最高 1-2 群） |
| `Fast` | 快区份额（%） | E ≥ 0.1 MeV |

**行数**：17（缺 mox1 + M87-20）

**典型值**：共振区 ~92%，热区 ~5%，超热 ~1%，快区 ~3%。
**物理意义**：Th232 俘获主要发生在 1/E 共振区，**自屏蔽**让 Th% 升高时单位 Th 原子效率下降。

---

## 5. `Th_breeding_family/` ⭐ 重点

这是本会话**最常引用的目录**，3 个 CSV 一起构成"Th-MOX 增殖分析"完整数据集。

### 5.1 `metrics_detailed.csv` — **每 case 完整指标（18 行 × 8 列）**

| 列 | 含义 | 单位 | 取值示例 |
|---|---|---|---|
| `case` | 算例名 | str | M43-30 |
| `family` | Family 标签 | str | M43 / M70 / M87 |
| `th_content_pct` | Th 投料分数 | % | 5 / 10 / 15 / 20 / 25 / 30 |
| `n_th_rods` | **该 family 的 Th 棒总数** | int | M43/M87 = 68，M70 = 128 |
| `thermal_fraction_pct` | **热中子通量份额**（E < 0.625 eV，per-energy） | % | ~94.79 % |
| `Th_capture_rate_R_Th` | **Th232 俘获反应率（BOC）** | reactions/s | 8.78e13 (M43-30) |
| `NU233final` | **U233 终点原子密度** | atom/barn·cm | 1.68e-4 (M43-30) |
| `Th_capture_rate_per_rod` | **每根 Th 棒的本征 R_Th** | reactions/(s·棒) | R_Th / n_th_rods |

**每列的来源**：
- `case, family, th_content_pct, n_th_rods`：来自 `kaist_utils.discover_cases` 和硬编码映射
- `thermal_fraction_pct`：`kaist_utils.read_spectrum(case, 0, "DET1")` + `φ_u/E` 归一化
- `Th_capture_rate_R_Th`：`*_res.m` 中 `TH232_CAPT(idx,[1:N]) = [...]` 的第一值（BOC）
- `NU233final`：`kaist_utils.get_isotope_adens(case, mat, "U233")` 取最后一步
- `Th_capture_rate_per_rod`：`Th_capture_rate_R_Th / n_th_rods`

---

### 5.2 `family_table.csv` — **Family 级汇总（3 行 × 11 列）**

每个 family 一行（4 个 family 中只保留 3 个有 Th 的），含**绝对值**和**归一化列**。

| 列 | 含义 | 备注 |
|---|---|---|
| `family` | Family 标签 | 索引 |
| `n_th_rods` | Th 棒数 | 同 case 级 |
| `thermal_fraction_pct` | 热中子占比（family 内 6 个 case 的均值） | |
| `Th_capture_rate_R_Th` | Th232 俘获率（均值） | |
| `Th_capture_rate_per_rod` | 每棒本征 R_Th（均值） | 跨 family 极差 5.9% |
| `NU233final` | U233 终点原子密度（均值） | |
| `n_th_rods_norm` | n_th_rods / M43 的 n_th_rods | 归一化到 M43 |
| `thermal_fraction_pct_norm` | family 均值 / M43 均值 | 极差 0.014 pp |
| `Th_capture_rate_R_Th_norm` | family 均值 / M43 均值 | M70 = 1.86（最粗） |
| `Th_capture_rate_per_rod_norm` | per-rod 均值 / M43 均值 | 0.94–1.00（最接近） |
| `NU233final_norm` | NU233 均值 / M43 均值 | 1.000–1.025 |

**典型值（取自 M43/M70/M87）**：

| 量 | M43 | M70 | M87 |
|---|---|---|---|
| `n_th_rods` | 68 | 128 | 68 |
| `Th_capture_rate_R_Th_norm` | 1.000 | 1.859 | 0.941 |
| `Th_capture_rate_per_rod_norm` | 1.000 | 0.987 | 0.941 |
| `NU233final_norm` | 1.000 | 1.017 | 1.025 |

---

### 5.3 `self_shielding_metric.csv` — **自屏蔽指标（18 行 × 6 列）**

| 列 | 含义 | 单位 | 备注 |
|---|---|---|---|
| `case` | 算例名 | str | |
| `family` | Family 标签 | str | |
| `th_content_pct` | Th 投料分数 | % | 5/10/15/20/25/30 |
| `Th_atom_norm` | **Th 原子数相对比例**（= th_content_pct / 5） | 无量纲 | 1.0 / 2.0 / 3.0 / 4.0 / 5.0 / 6.0 |
| `R_Th_norm` | **R_Th 归一化**（= R_Th / 该 family Th=5% 的 R_Th） | 无量纲 | 1.000 → 3.471 (M43 family) |
| `R_Th_per_Th_atom_norm` | **每 Th 原子的相对效率**（= R_Th_norm / Th_atom_norm） | 无量纲 | 1.000 → 0.579 (M43 family) |

**关键公式**：
```
R_Th_per_Th_atom_norm = (R_Th / R_Th_5%) / (th_content_pct / 5)
                     = 5 × R_Th / (th_content_pct × R_Th_5%)
```

**典型值（M43 family）**：

| Th% | Th_atom_norm | R_Th_norm | R_Th_per_Th_atom_norm |
|---|---|---|---|
| 5  | 1.0 | 1.000 | **1.000** |
| 10 | 2.0 | 1.654 | **0.827** |
| 15 | 3.0 | 2.189 | **0.730** |
| 20 | 4.0 | 2.651 | **0.663** |
| 25 | 5.0 | 3.081 | **0.616** |
| 30 | 6.0 | 3.471 | **0.579** |

**物理含义**：
- `R_Th_per_Th_atom_norm` 从 1.000 单调降到 0.579（**降 42%**）
- 这就是**自屏蔽**的定量证据：Th 越多，单位 Th 原子"看到"的中子越少
- 跨 family 极差仅 2%（M43/M70/M87 的 Th=30% 分别为 0.579/0.581/0.569）——**自屏蔽是棒内共振吸收主导，与 family 几何几乎无关**

---

## 6. 单位换算速查

| 量 | 数据中单位 | 物理意义 | 换算 |
|---|---|---|---|
| `adens` | atom / barn·cm | 原子密度 | 1 barn·cm = 10⁻²⁴ cm³ → 1 atom/barn·cm = **10²⁴ atom/cm³** |
| `mdens` | g/cm³ | 质量密度 | 直接 |
| `burnup_MWd_kgHM` | MW·d / kg(HM) | 燃耗深度（每 kg 重金属释放的能量） | 直接 |
| `R_Th` | reactions/s | Th232 俘获反应率 | 直接 |
| `thermal_fraction_pct` | % | 通量在 E<0.625 eV 的份额（per-energy） | 0-100 |
| `Th_capture_rate_per_rod` | reactions/(s·棒) | 每根 Th 棒的本征反应率 | R_Th / n_th_rods |
| `R_Th_per_Th_atom_norm` | 无量纲 | 每 Th 原子的相对效率 | 1.0 = 5% Th 基准 |

## 7. 物理量计算公式速查

```
η_Th = (N_Th_0 - N_Th) / N_Th_0                     # Th 利用率
R_Th = (1/V) ∫ σ_Th(E) φ(E) dE                      # 俘获反应率
f_th(E<E_cd) = ∫₀^E_cd φ(E) dE / ∫₀^∞ φ(E) dE        # 热中子份额
power_normalized = power_raw / mean(power_raw[over fuel pins])
```

## 8. 引用关系

```
*_res.m (Serpent 输出)
   └─ TH232_CAPT 块
        └─ Th_capture_rate_R_Th (BOC 第一列)
             ├─ Th_capture_rate_per_rod = R_Th / n_th_rods
             └─ R_Th_norm (in self_shielding_metric.csv)

*_det0.m (Serpent 输出)
   └─ DET1 块
        └─ thermal_fraction_pct
```

`*_dep.m` → adens 系列（Th232, U233, ...）

## 9. 关键数字（截稿时的 18-case 数据集）

| 量 | 数值 |
|---|---|
| 总 cases | 18 (3 family × 6 Th%) + 1 (mox1) |
| 缺数据 | M87-20 (目录不存在) |
| Th 棒数 | M43 = 68, M70 = 128, M87 = 68 |
| r (N_U233 vs R_Th/棒, log-log, n=18) | **+0.9965** |
| α (per-rod 幂律指数) | **+1.016** （95% CI = [0.974, 1.058]） |
| 跨 family f_th 极差 | 0.014 pp |
| 跨 family per-rod R_Th 极差 | 5.9% |
| Th232 俘获主战场（共振区占比）| **90-93%** |
| 单位 Th 原子效率 5→30% 衰减 | 1.000 → 0.579（−42%） |

---

*最后更新：与 `analyze_th_breeding_family.py` 当前输出同步。如脚本更新需同步本文档。*
