# KAIST MOX-Th Th-232 俘获分析 - 工作流思维导图

## 数据源
### SERPENT 输出
- `_res.m` → keff, CR
- `_dep.m` → ADENS, BURNUP
- `_det0.m` → 70 群能谱
### 输入卡
- `det th232_capN n dm <case>`
- N=1/2/3 由 dm 匹配决定
### 共享工具
- `kaist_utils.py`
  - `discover_cases`
  - `read_global_burnup`
  - `read_res_data`

## 算例空间
### MOX 钚含量
- M43 (4.3% Pu)
- M70 (7.0% Pu)
- M87 (8.7% Pu)
### Th 含量
- 5 / 10 / 15 / 20 / 25 / 30 wt%
### 共 18 个有效算例
- mox1 模板（th232_cap 注释掉）

## 解析层
### 微观率
- `find_th232_detector_suffix` → N
- `read_capture_sum` → (E, micro)
### 宏观率
- `read_th232_adens` → N_Th232(BOC)
- `read_macroscopic_capture` → (E, micro × N)
### 共享 helper
- `_style_log_xaxis` (log-x 次刻度 2,3,...,9)

## 物理现象
### 21.8 eV 巨共振
- 峰值 E = 2.225e-5 MeV
- σ_γ ≈ 7000 b
### 排序反转
- 微观：M87-5 > M87-30
- 宏观：M87-5 < M87-30
- 6× 密度 > 1.76× 自屏蔽
### MOX 钚含量影响
- M70 微观率最高
- 中子产额 + 谱软化最优平衡
- M87 谱过硬、per-atom 率反而低
### 共振自屏蔽
- 21.8 eV ratio = 2.73
- 200 eV ratio = 1.90
- 热/快 ratio ≈ 1.0
- NR 近似 1/√N 趋势

## 自屏蔽分类
### 能量自屏蔽（已观察）
- 共振能群通量塌陷
### 空间自屏蔽（待做）
- pin-by-pin 网格 tally
- 棒内径向梯度
### Doppler 展宽（待做）
- 多温度扫描
- 共振宽度 ∝ √T
### 互屏蔽（待做）
- U-238 / Pu-239 → Th 谱
- 多核素分解

## 修正方法（后续工作）
### NR 近似
- 等效自屏蔽截面
- 1/√σ_0 趋势
### 子群参数
- `set nfmtx`
- Bondarenko 因子
### 无穷稀释谱
- 跨共振无屏蔽参考
- 本征 σ_γ(E) 提取

## 能区分布
### 热区 < 5e-7 MeV
- 占比 4.5–11.6%
- 随 Th↑ 而↑（谱软化）
### 超热区 5e-7–1e-4 MeV
- 占比 36–52%
- 主导区
### 共振区 1e-4–1e-1 MeV
- 占比 38–49%
- 21.8 eV 单峰主导
### 快区 ≥ 1e-1 MeV
- 占比 3–6%
- 随 MOX↑ 而↑

## 工具链
### 解析
- `kaist_utils.py`
- `plot_th232_capture_response.py`
- `plot_th232_macroscopic_capture.py`
### 绘图
- 微观 M43/M70/M87
- 宏观 M43/M70/M87
- 归一化 + 累积
- log-x 次刻度统一
### 输出
- `Th232_capture/`
- `Th232_capture_macroscopic/`
- CSV 贡献表

## 后续工作
### 空间分辨
- pin-by-pin 网格 tally
- 子通道分析
- 棒内/组件间不均匀
### 温度效应
- 600 / 900 / 1200 K
- Doppler 系数 ∂ρ/∂T
### 数据扩展
- Pa-233, U-233, U-235, Pu-239
- 时间演化（25 步燃耗）
- det0-det25 全部
### 标准化
- 7 群 WIMS 结构
- 截面温度插值
- OpenMC / SCALE 验证
### 自屏蔽修正
- NR 近似
- Bondarenko 因子
- 无穷稀释参考谱
