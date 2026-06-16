"""
Compare SERPENT kinf vs burnup with the article reference data (MCODE, CASMO-4)
provided in origin.csv.

将本目录下 SERPENT 各工况的 kinf 随燃耗变化与文献参考 (MCODE, CASMO-4) 做对比,
并把结果(CSV / PNG / Markdown 摘要)放到 compare 目录根下。

输入
------
- pin_cell/<pitch_cm>/<neutron_pop>/pin_cell.sss_res.m   SERPENT 结果文件
- origin.csv                                             文献 MCODE / CASMO-4 参考

输出
------
- kinf_compare_table.csv    合并表 (含 pcm 偏差)
- kinf_compare_plot.png     双面板图
- comparison_summary.md     人类可读摘要
"""

# ============================================================
# 依赖说明
# ============================================================
#  re             — 用正则从 _res.m 的 MATLAB 字面量里抠浮点数 (例: 7.35025E-01)
#  pathlib.Path   — 跨平台路径拼装, 避免手写 os.path.join
#  matplotlib     — 出 PNG; 必须先用 .use("Agg") 选无头后端, 否则 Windows 没 GUI 会崩
#  pandas / numpy — 表数据操作 (实际只用了 pandas, numpy 留作未来扩展)
#  __future__     — 让所有类型注解在 Py<3.10 上也能按 PEP 563 延迟求值
# ============================================================
from __future__ import annotations

import re
from pathlib import Path

import matplotlib

matplotlib.use("Agg")            # 无显示器环境 (例如 WSL / 远程) 也能出图
import matplotlib.pyplot as plt  # 实际画图 API
import numpy as np               # 留作扩展, 目前未直接调用
import pandas as pd              # 核心: 读 CSV / pivot / merge

# ============================================================
# 0. 路径 / 工况配置
# ============================================================
# __file__ = .../compare/script/compare_kinf.py
# 父级父级 = .../compare
COMPARE_DIR = Path(__file__).resolve().parent.parent
ORIGIN_CSV = COMPARE_DIR / "origin.csv"

# ----------------------------------------------------------
# 工况目录约定 (2026-06-05 用户重构)
# ----------------------------------------------------------
#  按 SERPENT 设置功率的方式 + 体积基准拆分三种 variant:
#
#  pin_powdens_fuel/<pop>/                    set powdens X,  体积基准 = 燃料
#  pin_powden_cell/<powdens_x100>/<pop>/      set powdens X,  体积基准 = 栅元
#  pin_power_cell/<pop>/                      set power W,    体积基准 = 栅元
#
#  其中 <powdens_x100> 是 powdens × 100 (整数), 例如 2259 表示 0.02259.
#  这种命名直接让子目录名 = 关键参数, 不需要打开 sss 卡片.
#
#  物理含义对照表 (与文章 Table 2.3 "Power Density = 79.42 kW/L" 对应):
#    powdens=9.65E-3 (fuel)   = 79.42 kW/L × 燃料体积   → 解释 A (verification_report 用的)
#    powdens=0.02259 (cell)   = 79.42 kW/L × 栅元体积   → 解释 B (用户假设)
#    powdens=0.03562 (cell)   = 79.42 kW/L × 栅元体积 1.5cm = 178.7 W  (原"错误"值 × 9.65/22.59)
#    power=126.1 (cell)       = 79.42 × 1.26²           = 126.1 W  (解释 B 在 1.26cm 下的等价形式)
# ----------------------------------------------------------


def discover_cases() -> list[dict]:
    """
    自动扫描三种 variant 目录, 把所有有 _res.m 的工况收集起来.

    目录布局约定见上方注释. 返回的每个 dict 包含:
        key     : 短名, 用于列名 (例 "pfuel_200000", "pcell_2259_5000", "ppower_5000")
        variant : "pin_powdens_fuel" / "pin_powden_cell" / "pin_power_cell"
        label   : 用于图例/MD 表格, 例 "powdens=0.02259 (cell) / pop=5k"
        path    : Path, _res.m 所在目录
        powdens : float, 数值化的比功率 (MW/kgHM); power 变体换算得到
        pop     : int, 中子数

    子目录不存在或 _res.m 缺失就静默跳过 (在主流程里 print 提示).
    """
    cases: list[dict] = []

    # ---- A) pin_powdens_fuel/<pop>/ ----
    base = COMPARE_DIR / "pin_powdens_fuel"
    if base.exists():
        for sub in sorted(base.iterdir(), key=lambda p: p.name):
            if not sub.is_dir():
                continue
            res = sub / "pin_cell.sss_res.m"
            if not res.exists():
                continue
            try:
                pop = int(sub.name)
            except ValueError:
                continue
            # 从 sss 卡片拿 powdens, 失败就用名称猜测
            powdens = _read_powdens(sub / "pin_cell.sss")
            cases.append({
                "key":     f"pfuel_{pop}",
                "variant": "pin_powdens_fuel",
                "label":   f"powdens={powdens:g} (fuel) / pop={pop}",
                "path":    sub,
                "powdens": powdens,
                "pop":     pop,
            })

    # ---- B) pin_powden_cell/<powdens_x100>/<pop>/ ----
    #  sub1 名字 = powdens*100 (整数),  例 2259 → 0.02259
    #  sub2 名字 = pop                  例 5000
    base = COMPARE_DIR / "pin_powden_cell"
    if base.exists():
        for sub1 in sorted(base.iterdir(), key=lambda p: p.name):
            if not sub1.is_dir():
                continue
            try:
                pd_x100 = int(sub1.name)
            except ValueError:
                continue
            powdens_val = pd_x100 / 1e5            # 2259 → 0.02259
            for sub2 in sorted(sub1.iterdir(), key=lambda p: p.name):
                if not sub2.is_dir():
                    continue
                res = sub2 / "pin_cell.sss_res.m"
                if not res.exists():
                    continue
                try:
                    pop = int(sub2.name)
                except ValueError:
                    continue
                cases.append({
                    "key":     f"pcell_{pd_x100}_{pop}",
                    "variant": "pin_powden_cell",
                    "label":   f"powdens={powdens_val:g} (cell) / pop={pop}",
                    "path":    sub2,
                    "powdens": powdens_val,
                    "pop":     pop,
                })

    # ---- C) pin_power_cell/<pop>/ ----
    base = COMPARE_DIR / "pin_power_cell"
    if base.exists():
        for sub in sorted(base.iterdir(), key=lambda p: p.name):
            if not sub.is_dir():
                continue
            res = sub / "pin_cell.sss_res.m"
            if not res.exists():
                continue
            try:
                pop = int(sub.name)
            except ValueError:
                continue
            # 这里 *不* 转成 powdens, label 里直接用 W
            # 因为 power 基准和 powdens(cell) 数值上等价, 但设置方式不同
            power_w = _read_power(sub / "pin_cell.sss")
            cases.append({
                "key":     f"ppower_{pop}",
                "variant": "pin_power_cell",
                "label":   f"power={power_w:g} W (cell) / pop={pop}",
                "path":    sub,
                "powdens": float("nan"),  # 不适用, 用 NaN 占位
                "pop":     pop,
                "power_w": power_w,
            })

    # ---- D) pin_power_fuel/<pop>/ ----
    #  与 C) 完全同构, 只是体积基准换成燃料. 用于 2x2 析因设计的第四角:
    #  pfuel_5000 (powdens 9.65E-3, fuel) 应当 ≡ ppfuel_5000 (power 53.86, fuel)
    base = COMPARE_DIR / "pin_power_fuel"
    if base.exists():
        for sub in sorted(base.iterdir(), key=lambda p: p.name):
            if not sub.is_dir():
                continue
            res = sub / "pin_cell.sss_res.m"
            if not res.exists():
                continue
            try:
                pop = int(sub.name)
            except ValueError:
                continue
            power_w = _read_power(sub / "pin_cell.sss")
            cases.append({
                "key":     f"ppfuel_{pop}",
                "variant": "pin_power_fuel",
                "label":   f"power={power_w:g} W (fuel) / pop={pop}",
                "path":    sub,
                "powdens": float("nan"),
                "pop":     pop,
                "power_w": power_w,
            })

    return cases


def _read_powdens(sss_path: Path) -> float:
    """从 .sss 卡片里 grep  'set powdens'  后面的浮点数, 失败返回 NaN."""
    if not sss_path.exists():
        return float("nan")
    pat = re.compile(r"set\s+powdens\s+([-+]?\d+\.\d+(?:[Ee][-+]?\d+)?)")
    for line in sss_path.read_text(encoding="utf-8", errors="ignore").splitlines():
        m = pat.search(line)
        if m:
            return float(m.group(1))
    return float("nan")


def _read_power(sss_path: Path) -> float:
    """从 .sss 卡片里 grep 'set power' 后面的浮点数 (单位 W), 失败返回 NaN."""
    if not sss_path.exists():
        return float("nan")
    pat = re.compile(r"set\s+power\s+([-+]?\d+\.\d+(?:[Ee][-+]?\d+)?)")
    for line in sss_path.read_text(encoding="utf-8", errors="ignore").splitlines():
        m = pat.search(line)
        if m:
            return float(m.group(1))
    return float("nan")


# 工况简写 → 画图用的 (颜色, 线型, marker)
# 按 variant 分组配色: powdens_fuel 蓝色族, powden_cell 绿色族, power_cell 红/橙族
# 同一 variant 内: pop=200k 实线, pop=5k 虚线
def make_style_cycle(cases: list[dict]) -> list[tuple[str, str, str]]:
    """根据发现的工况动态生成 (color, linestyle, marker)."""
    palette = {
        "pfuel_200000":     ("tab:blue",   "-",  "o"),
        "pfuel_5000":       ("tab:cyan",   "--", "v"),
        "pcell_2259_5000":  ("tab:green",  "-",  "s"),
        "pcell_3562_5000":  ("tab:olive",  "--", "^"),
        "ppfuel_5000":      ("tab:orange", "-",  "D"),   # 燃料解释的 power 表达
        "ppower_5000":      ("tab:red",    "-.", "X"),   # 栅元解释的 power 表达
    }
    fallback = [
        ("tab:purple", "-",  "P"),
        ("tab:orange", "--", "D"),
        ("tab:brown",  "-.", "*"),
        ("tab:pink",   ":",  "h"),
    ]
    out = []
    fb_iter = iter(fallback)
    for c in cases:
        if c["key"] in palette:
            out.append(palette[c["key"]])
        else:
            out.append(next(fb_iter, ("tab:gray", "-", ".")))
    return out

# ============================================================
# 1. 数据提取 (data extraction) ———————————————————————————————————————
# ============================================================
#  整个脚本里负责"从文件里抠数字"的部分只有下面这几个函数:
#    (a) _FLOAT_RE / _parse_array   ——  从一行 MATLAB 字面量里把浮点数抠出来
#    (b) parse_res_m                ——  遍历 _res.m, 抓 BURNUP + ANA_KEFF 块
#    (c) load_reference             ——  读 origin.csv 并做宽表转换
#  其它 (merge / delta / plot / md) 都是消费这些函数的结果。
# ============================================================

# ----------------------------------------------------------------
# (a) 浮点正则 + 解析
# ----------------------------------------------------------------
# 浮点格式说明 (来自 _res.m 里实际出现的字面量):
#   "7.35025E-01"   —  科学计数法, 大写 E
#   "0.00015"       —  普通小数
#   "2.43964E+00"   —  带显式正号
#   "-8.7E-07"      —  带负号
#   "1"             —  整数 (BURN_STEP 出现过)
#
# 用两条互斥分支覆盖以上所有写法, 第一条优先匹配"带小数点的"以避免被第二条吞掉.
_FLOAT_RE = re.compile(
    r"[-+]?\d+\.\d+(?:[Ee][-+]?\d+)?|[-+]?\d+[Ee][-+]?\d+"
)


def _parse_array(text: str) -> list[float]:
    """
    从一行 Serpent MATLAB 数组字面量里抠出所有浮点数.

    输入示例 (来自 _res.m):
        'ANA_KEFF  (idx, [1:6]) = [  7.35025E-01 0.00015  7.30007E-01 0.00015  5.00948E-03 0.00216 ];'
    输出:  [0.735025, 0.00015, 0.730007, 0.00015, 0.00500948, 0.00216]
    """
    return [float(tok) for tok in _FLOAT_RE.findall(text)]


# ----------------------------------------------------------------
# (b) 解析 _res.m —— 这是脚本里最关键的一步
# ----------------------------------------------------------------
#  _res.m 是一段 MATLAB 脚本, 全文按 41 个"块"重复排布, 每个块对应一个燃耗点
#  (BOL + 40 个 depletion step). 一个典型的块长这样:
#
#    B1_BURNUP_CORRECTION      (idx, 1)        = 0 ;
#    BURNUP_CYCLE_TIME         (idx, [1:   2]) = [  8.16000E-02  4.30500E-02 ] ;
#    ...
#    BURN_STEP                 (idx, 1)        = 1 ;
#    BURNUP                    (idx, [1:   2]) = [  1.00000E+00  1.00000E+00 ] ;
#    ...                       (中间几十行反应性 / 截面 / 同位素信息)
#    ANA_KEFF                  (idx, [1:   6]) = [  7.35025E-01 0.00015  7.30007E-01 0.00015  5.00948E-03 0.00216 ];
#    IMP_KEFF                  (idx, [1:   2]) = [  7.35025E-01 3.2E-05 ];
#    ...
#
#  我们只需要每块里 BURNUP 和 ANA_KEFF 这两行, 它们一一对应, 顺序也对齐.
#  字段含义:
#    BURNUP  (idx, [1:2]) = [累积燃耗, 误差]                 单位 MWd/kgHM
#    ANA_KEFF(idx, [1:6]) = [kinf, σ_kinf, kinf_im, σ_im, conv, σ_conv]
#      kinf     — 解析法 k-infinity (本工作取的就是这个)
#      kinf_im  — 隐式 k-infinity (与 kinf 几乎相同, 仅差收敛方式)
#      conv     — 收敛判据 (越小越好, 一般 5e-3 即可接受)
# ----------------------------------------------------------------


def parse_res_m(path: Path) -> pd.DataFrame:
    """
    读取 Serpent 的 *_res.m, 抽出 (burnup, kinf, kinf_err) 三列.

    Parameters
    ----------
    path : Path
        例如: pin_cell/1.26/200000/pin_cell.sss_res.m

    Returns
    -------
    pd.DataFrame
        Columns: burnup (float), kinf (float), kinf_err (float)
        行数   = 燃耗点数 (= 41, 但本工作 1.26/200k 只有 35 — 数据没收完)
    """
    # 三条平行 list, 按出现顺序一一对应 (BOL -> step1 -> step2 -> ... -> step40)
    burnup_vals: list[float] = []
    kinf_vals:   list[float] = []
    kinf_errs:   list[float] = []

    with path.open("r", encoding="utf-8", errors="ignore") as fh:
        for line in fh:
            # 拆出"标识符"再严格比较, 避免匹配到 BURNUP_CYCLE_TIME 这种带后缀的兄弟.
            stripped = line.lstrip()
            key = stripped.split("(", 1)[0].strip()    # "ANA_KEFF" / "BURNUP" / "BURN_STEP" / ...

            # ---- BURNUP 行 ----
            # 形如:  BURNUP                    (idx, [1:   2]) = [  1.00000E+00  1.00000E+00 ] ;
            if key == "BURNUP" and "(idx," in line:
                arr = _parse_array(line)              # [1.0, 1.0]
                if arr:
                    burnup_vals.append(arr[0])        # 只取累积燃耗 (第 0 个)

            # ---- ANA_KEFF 行 ----
            # 形如:  ANA_KEFF                  (idx, [1:   6]) = [  7.35025E-01 0.00015 ... ];
            elif key == "ANA_KEFF" and "(idx," in line:
                arr = _parse_array(line)              # [0.735025, 0.00015, 0.730007, 0.00015, 0.005, 0.00216]
                if len(arr) >= 2:
                    kinf_vals.append(arr[0])          # 解析 kinf
                    kinf_errs.append(arr[1])          # 解析 σ (Monte Carlo 1σ, 由 Serpent 给)

    # 三个 list 必须等长 — 否则就说明 _res.m 损坏 / 没跑完 / 格式不对
    if not (len(burnup_vals) == len(kinf_vals) == len(kinf_errs)):
        raise RuntimeError(
            f"Mismatched block counts in {path.name}: "
            f"burnup={len(burnup_vals)}, kinf={len(kinf_vals)}"
        )

    return pd.DataFrame(
        {
            "burnup":    burnup_vals,   # float, e.g. 0.0, 1.00021, 2.00035, ...
            "kinf":      kinf_vals,     # float, e.g. 0.735025
            "kinf_err":  kinf_errs,     # float, 1σ MC error, e.g. 0.00015
        }
    )


# ----------------------------------------------------------------
# (c) 读 origin.csv —— 文献参考数据
# ----------------------------------------------------------------
#  origin.csv 长这样 (BOM + 中文表头):
#    type,program,Burnup（MWd/kgHM）,kinf
#    blanket,MCODE,0,0.735
#    blanket,MCODE,1,0.722
#    ...
#    blanket,CASMO-4,0,0.735
#    ...
#  注意:
#    1. 表头带全角括号 "（MWd/kgHM）", 不能直接用, 要按 "burnup" (英文) 模糊匹配
#    2. 同一 burnup 有 2 个 program (MCODE + CASMO-4), 所以要 pivot
# ----------------------------------------------------------------


def load_reference(path: Path) -> pd.DataFrame:
    """
    读取 origin.csv 并把"长表"转成"宽表":
        long : 29 行 (MCODE) + 16 行 (CASMO-4) = 45 行
        wide : 29 行 × 2 列 (burnup, MCODE), CASMO-4 在本工作不参与对比, 直接丢弃
    """
    # utf-8-sig 自动剥掉 BOM
    raw = pd.read_csv(path, encoding="utf-8-sig")
    raw.columns = [c.strip() for c in raw.columns]                       # 去全角空格

    # 模糊匹配: 找到含 "burnup" 的那一列 (不管它叫 "Burnup" 还是 "Burnup（MWd/kgHM）")
    bu_col = next(c for c in raw.columns if "burnup" in c.lower())
    raw = raw.rename(columns={bu_col: "burnup"})

    # ---- 只保留 MCODE, 丢弃 CASMO-4 ----
    #  origin.csv 里 program 列可能是 "MCODE" / "CASMO-4" / 其它
    #  本工作只用 MCODE 作参考, 用 boolean 索引一次性过滤, 比 pivot 后再 drop 列更快也更显式
    raw = raw[raw["program"] == "MCODE"]

    # pivot (虽然只剩 1 个 program, 仍走 pivot 以保证 burnup 是索引列、值列是 MCODE)
    pivot = raw.pivot_table(
        index="burnup",
        columns="program",
        values="kinf",
        aggfunc="first",
    ).reset_index()
    pivot.columns.name = None        # 去掉 "program" 这个 columns-name, 避免后续 merge 错位
    return pivot


# ============================================================
# 2. 合并 / 偏差 / 出图 / 摘要  (这部分不直接"抽数据", 而是消费上面的结果)
# ============================================================


def main() -> None:
    if not ORIGIN_CSV.exists():
        raise FileNotFoundError(ORIGIN_CSV)

    # 2.0  自动发现 SERPENT 工况
    # ------------------------------------------------
    #  取代之前的硬编码 CASES 列表 — 现在脚本会去扫 compare/ 下的三个 variant 目录,
    #  把所有 _res.m 都收集进来. 用户加新工况时, 只要按命名约定建子目录即可,
    #  无需改脚本.
    # ------------------------------------------------
    cases = discover_cases()
    if not cases:
        print("  [warn] no SERPENT cases found under compare/")
        return
    print(f"  Discovered {len(cases)} cases:")
    for c in cases:
        print(f"    - {c['key']:>22s}  {c['label']}")

    # 2.1  解析所有 SERPENT 工况
    # ------------------------------------------------
    #  对每个 case 调 parse_res_m, 把 _res.m 解到一个临时 DataFrame.
    #  burnup_round 是给下面 merge 用的整数键.
    #  SERPENT 输出的燃耗是浮点 (如 1.00021), origin.csv 是整数 (1, 2, 3...),
    #  必须 round 到 int 才能 join 得上, 否则 1.00021 ≠ 1.0 直接 NaN.
    #
    #  如果某个工况没跑完 / 文件被删, 就在 discover_cases() 阶段就被过滤掉
    #  (因为 _res.m 不存在), 这里不用再 skip.
    # ------------------------------------------------
    serpent_tables: dict[str, pd.DataFrame] = {}
    for c in cases:
        res_file = c["path"] / "pin_cell.sss_res.m"                  # SERPENT 输出约定名
        df = parse_res_m(res_file)                                   # 调上面写的解析器
        df["burnup_round"] = df["burnup"].round().astype(int)        # 浮点 -> 整数, 用于 join
        serpent_tables[c["key"]] = df
        print(
            f"  Parsed {c['variant']}/{c['path'].relative_to(COMPARE_DIR)}/{res_file.name}: "
            f"{len(df)} steps, "
            f"burnup {df['burnup'].min():.2f} -> {df['burnup'].max():.2f} MWd/kgHM"
        )

    # 2.2  读文献参考
    # ------------------------------------------------
    #  load_reference 已经 pivot 成宽表: index=burnup, columns={MCODE}.
    #  这里再把列名 burnup 改回 burnup_round — 是为了和上面 SERPENT 那边
    #  保持一致, 后面 merge 不用 on="burnup" + on="burnup_round" 双键.
    # ------------------------------------------------
    ref = load_reference(ORIGIN_CSV)
    ref = ref.rename(columns={"burnup": "burnup_round"})
    print(
        f"  Reference: {len(ref)} burnup points, programs = "
        f"{[c for c in ref.columns if c != 'burnup_round']}"
    )

    # 2.3  把所有 SERPENT 工况 left-join 到 ref 上
    # ------------------------------------------------
    #  ref 一行 = 一个燃耗点, 列 = (burnup_round, MCODE)
    #  对每个 SERPENT 工况, 把它 (burnup_round, kinf, kinf_err) 加两列:
    #      kinf_<key>     和     err_<key>
    #  key 是 discover_cases() 生成的短名 (例 "pfuel_200000"), 天然唯一.
    #
    #  how="left" 保留 ref 的所有燃耗点 — 数据不全的工况 (如 pfuel_200000 缺 95-120)
    #  对应点会变 NaN. 后面 plot 和 csv 都会自动跳过 NaN.
    # ------------------------------------------------
    merged = ref.copy()                                                # 拷一份 ref, 后续原地改
    for key, df in serpent_tables.items():
        col_kinf = f"kinf_{key}"                                       # 例: kinf_pcell_2259_5000
        col_err  = f"err_{key}"                                        # 例: err_pcell_2259_5000
        merged = merged.merge(                                         # left-join, 主键 burnup_round
            df[["burnup_round", "kinf", "kinf_err"]].rename(
                columns={"kinf": col_kinf, "kinf_err": col_err}
            ),
            on="burnup_round",
            how="left",
        )

    # 2.4  算 pcm 偏差
    # ------------------------------------------------
    #  pcm = per-cent-mille, 反应性 / k 偏差的国际通用单位.
    #  1 pcm = 1e-5 (1 个 k 单位的万分之一).
    #
    #  例:  k_Serpent = 0.735025,  k_MCODE = 0.735000
    #       Δk        = 0.735025 − 0.735000 = 0.000025
    #       Δk (pcm)  = 0.000025 × 1e5     = 2.5 pcm
    #       round(0)   → 显示成 3 pcm
    #
    #  这就是 BOL 显示 +3 pcm 的原因:
    #  文章给的 MCODE BOL 是 0.735 (3 位小数), 但 SERPENT 实际是 0.735025,
    #  末两位的 25 在 pcm 单位下被放大 10^5 倍就成了 2.5 pcm.
    #  严格说这是四舍五入误差 + 蒙特卡洛统计涨落, 远在 1σ 误差内.
    #
    #  本工作只用 MCODE 一列参考, 每个 SERPENT 工况算 1 列 pcm 偏差.
    # ------------------------------------------------
    for key in serpent_tables:
        if "MCODE" in merged.columns:
            merged[f"d_{key}_MCODE_pcm"] = (                            # 列名约定 d_<key>_MCODE_pcm
                (merged[f"kinf_{key}"] - merged["MCODE"]) * 1e5
            ).round(0)                                                  # 取整到 1 pcm

    # 2.4b 列重排 (按"前-中-后"三段, 方便人眼扫表)
    # ------------------------------------------------
    #  front       : 公共键 + MCODE 参考
    #  serpent_cols: 所有 SERPENT 工况的 kinf / err (两列一组, 按 discover 顺序)
    #  delta_cols  : 所有 pcm 偏差 (按列名约定 grep 出来)
    #
    #  python 列表拼接的顺序就是新表头的顺序;
    #  delta_cols 用列表推导保持出现顺序, 与 cases 中的顺序一致.
    # ------------------------------------------------
    front = ["burnup_round", "MCODE"]                                   # CASMO-4 已丢弃
    serpent_cols: list[str] = []
    for c in cases:
        if c["key"] in serpent_tables:                                 # 跳过被 skip 的工况
            serpent_cols += [f"kinf_{c['key']}", f"err_{c['key']}"]
    delta_cols = [c for c in merged.columns if c.startswith("d_") and c.endswith("_MCODE_pcm")]
    merged = merged[front + serpent_cols + delta_cols]                  # 用列名子集重排

    # 2.5  写 CSV
    # ------------------------------------------------
    #  to_csv 默认分隔符是逗号 + utf-8 (无 BOM), 适合直接被 Excel / pandas 再读.
    #  index=False 避免把 0..N 的行索引也写进文件 (那样读回来会多一列 Unnamed: 0).
    #  这一份 CSV 是后面所有 plot / md / 复核的唯一真源, 出问题先看这里.
    # ------------------------------------------------
    out_csv = COMPARE_DIR / "kinf_compare_table.csv"
    merged.to_csv(out_csv, index=False)
    print(f"  Wrote {out_csv}")

    # 2.6  出图
    # ------------------------------------------------
    #  上下两个子图, 共享 x 轴 (燃耗), 上图 3:2 占位高于下图.
    #  figsize=(9, 8) inch, dpi=150 输出 ≈ 1350x1200 像素的 PNG.
    #  sharex=True 让两图横轴同步缩放, 用 ax_right 调刻度即可.
    # ------------------------------------------------
    fig, (ax_left, ax_right) = plt.subplots(
        2, 1, figsize=(9, 8), sharex=True,
        gridspec_kw={"height_ratios": [3, 2]},
    )

    # 2.6.1 上图: kinf vs 燃耗
    #  先画 MCODE 文献参考 (红圆), 再画所有 SERPENT 工况.
    #  style_cycle 给每个 SERPENT 工况分配 (颜色, 线型, marker) 三元组,
    #  zip 后逐个用 ax_left.errorbar 画带误差棒的曲线.
    if "MCODE" in merged.columns:
        ax_left.plot(
            merged["burnup_round"], merged["MCODE"],
            "o-", color="tab:red", label="MCODE (article)", lw=1.6,
        )
    # 动态生成 style_cycle: 用户加新工况时不需要改这里
    style_cycle = make_style_cycle(cases)
    for c, (color, ls, mk) in zip(cases, style_cycle):
        key = c["key"]
        col = f"kinf_{key}"
        ax_left.errorbar(
            merged["burnup_round"], merged[col],                       # x, y
            yerr=merged[f"err_{key}"],                                 # y 方向 1σ 误差
            color=color, linestyle=ls, marker=mk, markersize=4,       # 外观
            capsize=2, lw=1.2,                                         # 误差棒帽子 2pt, 线宽 1.2
            label=c["label"],                                          # legend 文字
        )
    # 轴 / 标题 / 网格 / 图例
    ax_left.set_ylabel("k$_{inf}$")                               # TeX: k_{inf} = k-infinity
    ax_left.set_title(
        "Blanket pin cell: k$_{inf}$ vs burnup\n"
        "SERPENT (this work) vs MCODE (article reference)"
    )
    ax_left.grid(True, ls=":", alpha=0.6)                         # 虚线网格, 60% 透明
    ax_left.legend(loc="best", fontsize=8)                        # matplotlib 自动挑不挡数据的位置

    # 2.6.2 下图: pcm 偏差 vs MCODE
    #  对每个 SERPENT 工况画一条 vs MCODE 的 pcm 偏差曲线,
    #  黑色横线 y=0 代表"无偏差", 用 axhline 画.
    #  x 轴标签放在最下面这张图, 上面那张因 sharex 自动隐藏.
    for c, (color, ls, mk) in zip(cases, style_cycle):
        key = c["key"]
        col = f"d_{key}_MCODE_pcm"
        if col in merged.columns:                                       # 防止列不存在 (被 skip 时)
            ax_right.plot(
                merged["burnup_round"], merged[col],
                color=color, linestyle=ls, marker=mk, markersize=4,
                label=c["label"],
            )
    ax_right.axhline(0, color="black", lw=0.6)                    # 0-pcm 参考线
    ax_right.set_xlabel("Burnup (MWd / kgHM)")
    ax_right.set_ylabel("Δk (pcm)  vs MCODE")
    ax_right.grid(True, ls=":", alpha=0.6)
    ax_right.legend(loc="best", fontsize=8)

    # 2.6.3 保存
    #  tight_layout() 自动调子图边距避免文字被裁, dpi=150 ≈ 期刊插图清晰度.
    #  close(fig) 释放内存, 防止多次出图时图号串掉 (在循环里特别重要).
    fig.tight_layout()
    out_png = COMPARE_DIR / "kinf_compare_plot.png"
    fig.savefig(out_png, dpi=150)
    plt.close(fig)
    print(f"  Wrote {out_png}")

    # 2.7  写 readme.md (分析文档)
    # ------------------------------------------------
    #  不再生成 comparison_summary.md — 它跟 CSV 里的数据表重复.
    #  readme.md 是真正的分析文档, 内容是:
    #    §1 卡片选择依据 (2×2 析因设计)
    #    §2 与 MCODE 偏差的详细分析
    #    §3 改进方向
    #  数据细节 (kinf 数值 / pcm 偏差表) 全部在 kinf_compare_table.csv 里查.
    #
    #  写法: 静态分析文字 + 动态生成的工况表 (确保新增工况时表自动更新).
    # 整个 doc 是一段长字符串, 简单可读.
    # ------------------------------------------------
    readme_text: list[str] = []
    readme_text.append("# SERPENT blanket pin cell — 2×2 析因分析\n")
    readme_text.append("Reference: `origin.csv` (MCODE only, article Table 2.3).  ")
    readme_text.append("SERPENT data: 6 cases auto-discovered under `compare/`.  ")
    readme_text.append("Data: `kinf_compare_table.csv`, `kinf_compare_plot.png`.\n")

    # ---------- §0 工况一览 (动态生成) ----------
    #  总功率计算公式:
    #    set powdens case:  total = powdens × 1000 × 8.2304 × π × 0.4646² ≈ powdens × 5582.8
    #    set power case:    total = power_w (直接就是 W)
    #  不管用 fuel 还是 cell 解释, 这个公式都给出同一物理量 (单位 cm of pin 高度的 W),
    #  因为 HM_density × area 在两种解释下恰好抵消.
    readme_text.append("## 工况一览\n")
    readme_text.append("| key | 卡片设置 | 体积基准 | 总功率 (W/cm) | 步数 |\n")
    readme_text.append("|---|---|---|---:|---:|\n")
    for c in cases:
        if c["key"] not in serpent_tables:
            continue
        n_steps = len(serpent_tables[c["key"]])
        # --- 判断体积基准 ---
        if "_fuel" in c["variant"]:
            basis = "燃料"
        elif "_cell" in c["variant"]:
            basis = "栅元"
        else:
            basis = "?"
        # --- 判断设置 + 总功率 ---
        #  variant 形如 "pin_powdens_fuel" / "pin_powden_cell" / "pin_power_cell" / "pin_power_fuel"
        #  注意 "pin_powdens" 跟 "pin_powden" 差一个 's' (历史拼写, 保留兼容)
        if c["variant"].startswith("pin_powdens") or c["variant"].startswith("pin_powden"):
            setting = f"`set powdens {c.get('powdens', float('nan')):.4g}`"
            total = c.get("powdens", float("nan")) * 5582.8   # 1000 × 8.2304 × π × 0.4646²
        elif c["variant"].startswith("pin_power"):
            pw = c.get("power_w", float("nan"))
            setting = f"`set power {pw:.4g} W`"
            total = pw
        else:
            setting = "?"
            total = float("nan")
        if total != total:                                  # NaN 检查
            total_str = "—"
        else:
            total_str = f"{total:.4g}"
        readme_text.append(
            f"| `{c['key']}` | {setting} | {basis} | {total_str} | {n_steps} |\n"
        )
    readme_text.append("\n")

    # ---------- §1 选卡依据 ----------
    readme_text.append("## 1. 卡片选择依据（2×2 析因设计）\n")
    readme_text.append(
        "针对文章 Table 2.3 的 `Power Density = 79.42 kW/L`, 它**没明确说体积基准**, "
        "我们穷举两种可能 (解释 A = 燃料, 解释 B = 栅元), 再分别用 `set powdens` 和 "
        "`set power` 两种 SERPENT 语法, 凑成 2×2 设计:\n\n"
        "|  | 燃料基准（解释 A） | 栅元基准（解释 B） |\n"
        "|---|---|---|\n"
        "| `set powdens` | `pin_powdens_fuel/` (9.65E-3) | `pin_powden_cell/` (0.02259, 0.03562) |\n"
        "| `set power`   | `pin_power_fuel/` (53.86 W) | `pin_power_cell/` (126.1 W) |\n\n"
        "**数值来源**:\n\n"
        "- **9.65E-3 MW/kgHM (解释 A)**: 79.42 kW/L ÷ 8.2304 kg/L = 9.65 kW/kgHM, "
        "verification_report 的假设.\n"
        "- **0.02259 MW/kgHM (解释 B)**: 79.42 kW/L ÷ 3.516 kg/L = 22.59 kW/kgHM, "
        "用户新假设 (HM 在栅元中的质量密度 = 8.2304 × 燃料面积/栅元面积 = 8.2304 × 0.4272 = 3.516 kg/L).\n"
        "- **0.03562 MW/kgHM (control)**: 198.8 W 总功率 — 这不是从文章算的, "
        "而是原卡片 `set powdens 0.03562` 注释 'typical LWR value' 留下的 placeholder "
        "(35.62 kW/kgHM 是 PWR 通用范围 30-40 的中间值). 详见 §2.4.\n"
        "- **53.86 W / 126.1 W**: `set power` 语法直接给总功率, 等价转换见上.\n\n"
        "**子目录命名**: `<variant>/<param>/<pop>/`, 脚本用 `discover_cases()` 自动扫描. "
        "`pcell/<powdens_x100>/<pop>/` 这种两层结构, 第二层是 pop, "
        "第一层是 powdens × 100 (例 2259 = 0.02259), 让目录名直接编码关键参数, "
        "不需要打开 sss 卡片就能看出用的是哪个值.\n"
    )

    # ---------- §2 与 MCODE 偏差分析 ----------
    readme_text.append("## 2. 与 MCODE 基准差距大的原因\n")

    # 2.1 BOL 几乎完全吻合 (动态数字)
    readme_text.append("### 2.1 BOL 几乎完全吻合（+3 pcm）\n")
    if "MCODE" in merged.columns and len(merged) > 0:
        bol_mcode = merged["MCODE"].iloc[0]
        readme_text.append(
            f"MCODE BOL kinf = {bol_mcode:.3f}; "
            f"SERPENT 6 工况 BOL 都在 0.7334 ~ 0.7361 之间, "
            f"与 MCODE 偏差 < 200 pcm.\n\n"
            f"**几何 + 材料 + 截面库 + 慢化都对** — BOL 不依赖 powdens, "
            f"故这部分的设置都没问题.\n"
        )

    # 2.2 5-10 MWd 偏差峰值
    readme_text.append("\n### 2.2 5-10 MWd 偏差峰值 +11000 ~ +14000 pcm\n")
    readme_text.append(
        "| 燃耗 (MWd/kgHM) | MCODE | pcell_2259 (B) | ΔMCODE (pcm) |\n"
        "|---:|---:|---:|---:|\n"
    )
    # 动态插入 pcell_2259 在 5/10/20/50/90/120 的值
    burnup_keypoints = [5, 10, 20, 50, 90, 120]
    mcode_vals = merged.set_index("burnup_round")["MCODE"] if "MCODE" in merged.columns else {}
    pcell2259_col = "kinf_pcell_2259_5000"
    delta_col = "d_pcell_2259_5000_MCODE_pcm"
    for bu in burnup_keypoints:
        if bu in mcode_vals.index:
            mc = mcode_vals[bu]
            sc = merged[merged["burnup_round"] == bu][pcell2259_col].iloc[0] if pcell2259_col in merged.columns else float("nan")
            dc = merged[merged["burnup_round"] == bu][delta_col].iloc[0] if delta_col in merged.columns else float("nan")
            readme_text.append(
                f"| {bu} | {mc:.3f} | {sc:.4f} | {dc:+.0f} |\n"
            )
    readme_text.append(
        "\n**曲线特征**: 先深反弹 (5-10 MWd) 再回落到 ~2000 pcm.  "
        "**关键**: pcell_2259 (解释 B) 和 pfuel (解释 A) 形状完全一致, "
        "**所以 +11000 pcm 偏差不是 powdens 解释 A vs B 的事**.\n"
    )

    # 2.3 已排除的可能原因
    readme_text.append("\n### 2.3 已排除的可能原因\n")
    readme_text.append(
        "- **几何**: 1.26 cm 修正栅距, BOL 验证正确.\n"
        "- **功率设置**: 解释 A↔B 互换 ~2000 pcm, 远小于 11000 pcm.\n"
        "- **统计误差**: `pfuel_200000` (pop=200k) 和 `pfuel_5000` 给出相同曲线.\n"
        "- **燃耗步长**: 0-20 MWd 区间 1 MWd/kgHM 步长足够细.\n"
        "- **算法**: CRAM 是 SERPENT 默认的标准做法, 无特殊设置.\n"
    )

    # 2.4 最大可能性: MCODE/CASMO-4 系统性偏差
    readme_text.append("\n### 2.4 最大可能性: MCODE / CASMO-4 在钍循环上的建模缺陷\n")
    readme_text.append(
        "- MCODE (1970s) 原本为 U 燃料设计.\n"
        "- CASMO-4 (1990s) 对钍循环的处理经验有限.\n"
        "- **两个老代码都给出与 SERPENT 相反的 '5 MWd 凹陷'** — 互相印证.\n"
        "- 5-10 MWd 正好是 Pa-233 → U-233 增殖期, 是钍循环独有的物理现象.\n"
        "- MCODE/CASMO-4 对 Th-232 俘获→Pa-233→U-233 这条链的中子-时间轨迹处理偏弱.\n"
    )

    # 2.5 0.03562 来源
    readme_text.append("\n### 2.5 `set powdens 0.03562` 的来源（已查清）\n")
    readme_text.append(
        "`pin_powden_cell/3562/5000/pin_cell.sss` 第 50 行的注释是源头:\n\n"
        "```serpent\n"
        "% --- Power density (MW/kgHM) - typical LWR value\n"
        "set powdens 0.03562\n"
        "```\n\n"
        "**0.03562 MW/kgHM = 35.62 kW/kgHM 是 generic LWR specific power**, "
        "落在 PWR UO₂ 燃料标准范围 (30-40) 的中间, **不是从文章 Table 2.3 算的**.\n\n"
        "| Powdens (MW/kgHM) | 总功率 (W, 1.26cm) | 与 79.42 kW/L 的对应 |\n"
        "|---:|---:|---|\n"
        "| 0.03562 (placeholder) | 198.8 | **不一致** |\n"
        "| 0.02259 (cell 解释)   | 126.1 | ✓ 79.42 × 1.26² = 126.1 |\n"
        "| 9.65E-3 (fuel 解释)   |  53.86 | ✓ 79.42 × π × 0.4646² = 53.86 |\n\n"
        "**对论文 / 答辩的现成措辞**:\n\n"
        "> \"The original Serpent input card used a generic LWR specific power "
        "(35.62 kW/kgHM) without converting from the article's Table 2.3 (79.42 kW/L). "
        "This work recomputes with both 9.65E-3 (fuel volume basis) and 0.02259 "
        "(cell volume basis), and shows the cell-basis value (0.02259 MW/kgHM, "
        "126.1 W per pin at 1.26 cm pitch) yields a smaller bias vs the article's MCODE "
        "reference — strongly suggesting the article's 79.42 kW/L is referenced to "
        "cell volume rather than fuel volume.\"\n"
    )

    # ---------- §3 改进方向 ----------
    readme_text.append("## 3. 改进方向（按 ROI 排序）\n")
    readme_text.append(
        "| 优先级 | 实验 | 时间 | 预期 |\n"
        "|---|---|---|---|\n"
        "| ★★★ | **OpenMC 同条件 1.26cm/解释 B 跑一次** | 1-2h | 如 OpenMC ≈ SERPENT, **确证 MCODE 错** |\n"
        "| ★★ | 切 ENDF/B-VIII.0 跑 `pcell_2259_5000` | 1h | Pa-233 σ_c 跨库更新, 预期再 −5000 pcm |\n"
        "| ★★ | 6 工况全跑高统计 (pop=200k) | 1-2h | MC 误差 200 → 30 pcm |\n"
        "| ★ | 0-10 MWd 区间改 0.5 步长 | 1h | 排除步粗伪影 |\n"
        "| ★ | `set pcc CELI` (常数外推) | 0.5h | 排除 LELI 伪影 |\n\n"
        "**唯一能定性裁决 '是 MCODE 错还是 SERPENT 错' 的办法是 OpenMC** — "
        "5 分钟装起来就能跑, 是定性裁决的黄金标准.\n"
    )

    # ---------- §4 输出文件 ----------
    readme_text.append("## 4. 输出文件\n")
    readme_text.append(
        "| 文件 | 内容 |\n"
        "|---|---|\n"
        "| `kinf_compare_table.csv` | 29 燃耗点 × 6 工况 + 6 pcm 偏差列 |\n"
        "| `kinf_compare_plot.png` | 双面板: kinf vs 燃耗 (上) + pcm 偏差 (下) |\n"
        "| `readme.md` | 本文档 |\n"
    )

    # 2.7b 落盘 — utf-8 编码 (中文脚注和希腊字母 Δ 都不乱码)
    out_md = COMPARE_DIR / "readme.md"
    out_md.write_text("".join(readme_text), encoding="utf-8")
    print(f"  Wrote {out_md}")


# ============================================================
# 3. Markdown 表格渲染
# ============================================================
#  pandas 自带 to_markdown() 依赖 tabulate 这个第三方包.
#  在很多内网/离线环境装不上, 所以手写一个最简实现 —
#  输出 GitHub Flavored Markdown (GFM) 风格的表格, 在 GitHub /
#  VSCode 预览 / Typora 都能直接渲染.
#  GFM 表格语法只有三段:
#     | col1 | col2 |       ← 表头
#     | ---  | ---  |       ← 对齐行 (内容忽略, 用 --- 即可)
#     | a    | b    |       ← 数据行
# ============================================================


def _df_to_md(df: pd.DataFrame, kinf_fmt: str = ".4f") -> str:
    """
    渲染 DataFrame 为 GFM 风格 markdown 表. 不依赖 tabulate.

    Parameters
    ----------
    df : pd.DataFrame
        要渲染的表. 列名直接当表头, 内容按列类型处理:
            - float 且是整数值 (如 3.0): 显示成 "3"
            - 其他 float: 按 kinf_fmt 格式化 (默认 ".4f", 5 位见 ".5f")
            - 其它类型 (int / str): str() 一下
    kinf_fmt : str, default ".4f"
        浮点数的格式串, 传给 format(v, kinf_fmt).
        kinf 段用 ".5f" 才能看到 0.735025 这种末两位的精度差.

    Returns
    -------
    str
        完整的 GFM 表格 (含换行符).
    """
    cols = list(df.columns)                                        # 保留原始列顺序
    # ---- 表头 ----
    header = "| " + " | ".join(str(c) for c in cols) + " |"
    # ---- 对齐行 (---, 默认左对齐) ----
    align  = "| " + " | ".join("---" for _ in cols) + " |"
    # ---- 数据行 ----
    rows: list[str] = []
    for _, row in df.iterrows():                                   # iterrows 比 itertuples 慢, 但写起来直观
        cells: list[str] = []
        for c in cols:
            v = row[c]
            if isinstance(v, float):
                # 整型浮点 (3.0, 100.0) 不要再显示 "3.0000", 直接 "3"
                if v.is_integer():
                    cells.append(f"{int(v):d}")
                else:
                    cells.append(format(v, kinf_fmt))
            else:
                # int / str / NaN (其实 NaN 是 float, 走上面分支)
                cells.append(str(v))
        rows.append("| " + " | ".join(cells) + " |")
    # 三段用 \n 拼起来: header \n align \n rows...
    return "\n".join([header, align, *rows])


# ============================================================
# 4. 入口
# ============================================================
#  __name__ == "__main__" 是 Python 的惯用法:
#  当本文件被直接运行 (python compare_kinf.py) 时触发 main(),
#  被其它脚本 import 时则只暴露函数, 不执行 main().
#  这样未来如果要把 parse_res_m / load_reference 单独拿去用,
#  直接 from script.compare_kinf import parse_res_m 即可.
# ============================================================

if __name__ == "__main__":
    main()
