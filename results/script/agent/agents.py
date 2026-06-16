#!/usr/bin/env python3
# pyright: reportMissingImports=false, reportMissingModuleSource=false
"""
Agents Layer - AI Analysis Agents for Thorium-Based Fuel Optimization
======================================================================
Each agent is an independent, self-contained unit for analyzing specific aspects
of the simulation data. Agents are designed for parallel execution.

Agent Types:
- CaseAgent: Single case deep analysis
- GroupAgent: Group-level statistical analysis
- TrendAgent: Cross-case trend detection
- RecommendationAgent: Optimization recommendations
"""

from pathlib import Path
from typing import Optional, List, Dict, Any, Tuple, Iterator
from dataclasses import dataclass, field
from enum import Enum
import json

import numpy as np
import pandas as pd

# Import from other layers
from results.script.agent.data_layer import DataLake, CaseSummary, FISSILE_ISOTOPES
from results.script.agent.cache_layer import MultiLevelCache, get_global_cache


class TrendType(Enum):
    """Trend analysis types"""
    INCREASING = "increasing"
    DECREASING = "decreasing"
    STABLE = "stable"
    PEAK = "peak"
    VALLEY = "valley"


@dataclass
class TrendAnalysis:
    """Trend analysis results"""
    variable: str
    trend_type: TrendType
    slope: float  # Rate of change per MWd/kgHM
    start_value: float
    end_value: float
    peak_value: float = None
    peak_step: int = None
    critical_step: int = None  # Where keff crosses 1.0
    notes: str = ""


@dataclass  
class CaseReport:
    """Comprehensive case analysis report"""
    case_id: str
    group: str
    
    # Summary metrics
    keff_initial: float
    keff_final: float
    keff_decline: float
    
    cr_initial: float
    cr_final: float
    cr_change: float
    
    fir_initial: float
    fir_final: float
    fir_change: float
    
    max_burnup_reached: float
    
    # Trends
    trends: List[TrendAnalysis] = field(default_factory=list)
    
    # Key isotopes
    u233_breeding: float = None
    u235_consumption: float = None
    pu239_production: float = None
    
    # Recommendations
    recommendations: List[str] = field(default_factory=list)
    
    # Metadata
    analysis_timestamp: str = ""
    data_quality: str = "good"  # good, warning, poor
    
    def to_dict(self) -> dict:
        return {
            'case_id': self.case_id,
            'group': self.group,
            'keff_initial': self.keff_initial,
            'keff_final': self.keff_final,
            'keff_decline': self.keff_decline,
            'cr_initial': self.cr_initial,
            'cr_final': self.cr_final,
            'cr_change': self.cr_change,
            'fir_initial': self.fir_initial,
            'fir_final': self.fir_final,
            'fir_change': self.fir_change,
            'max_burnup_reached': self.max_burnup_reached,
            'trends': [{'variable': t.variable, 'type': t.trend_type.value, 
                       'slope': t.slope} for t in self.trends],
            'recommendations': self.recommendations,
            'u233_breeding': self.u233_breeding,
            'u235_consumption': self.u235_consumption,
            'pu239_production': self.pu239_production
        }
    
    def to_json(self) -> str:
        return json.dumps(self.to_dict(), indent=2)
    
    def summary_text(self) -> str:
        """Generate human-readable summary"""
        return f"""
{'='*60}
Case {self.case_id} Analysis Report ({self.group} Group)
{'='*60}

Keff: {self.keff_initial:.4f} → {self.keff_final:.4f} (Δ {self.keff_decline:+.4f})
CR:   {self.cr_initial:.4f} → {self.cr_final:.4f} (Δ {self.cr_change:+.4f})
FIR:  {self.fir_initial:.4f} → {self.fir_final:.4f} (Δ {self.fir_change:+.4f})
Max Burnup: {self.max_burnup_reached:.2f} MWd/kgHM

{'─'*60}
Key Trends:
"""
        + "\n".join([f"  - {t.variable}: {t.trend_type.value} ({t.slope:+.2e}/MWd/kgHM)" 
                     for t in self.trends[:5]])
    
    def recommendations_text(self) -> str:
        """Generate recommendations text"""
        return f"""
{'─'*60}
Recommendations:
"""
        + "\n".join([f"  • {rec}" for rec in self.recommendations])


class CaseAgent:
    """
    Agent for deep analysis of a single case.
    
    Responsibilities:
    - Load and process case data
    - Compute trends and metrics
    - Generate recommendations
    - Produce comprehensive report
    """
    
    def __init__(
        self, 
        case_id: str, 
        data_lake: DataLake,
        cache: Optional[MultiLevelCache] = None
    ):
        self.case_id = case_id
        self.dl = data_lake
        self.cache = cache or get_global_cache()
        self._summary: Optional[CaseSummary] = None
        self._data: Optional[pd.DataFrame] = None
    
    @property
    def summary(self) -> Optional[CaseSummary]:
        """Get case summary from data lake"""
        if self._summary is None:
            self._summary = self.dl.get_case_summary(self.case_id)
        return self._summary
    
    @property
    def data(self) -> pd.DataFrame:
        """Get case data with caching"""
        cache_key = f"case_{self.case_id}"
        
        df = self.cache.get_df(cache_key)
        if df is None:
            df = self.dl.get_case_data(self.case_id)
            self.cache.set_df(cache_key, df)
        
        return df
    
    def compute_fir(self, steps_df: pd.DataFrame) -> pd.Series:
        """Compute Fissile Inventory Ratio"""
        fissile_mass = pd.Series(0.0, index=steps_df.index)
        for iso in FISSILE_ISOTOPES:
            col = f'Mdens_{iso}'
            if col in steps_df.columns:
                fissile_mass += steps_df[col].fillna(0)
        
        initial_fissile = fissile_mass.iloc[0] if fissile_mass.iloc[0] != 0 else 1.0
        return fissile_mass / initial_fissile
    
    def detect_critical_step(self, steps_df: pd.DataFrame) -> Optional[int]:
        """Find where keff crosses 1.0"""
        keff = steps_df['keff'].values
        for i, k in enumerate(keff):
            if k < 1.0:
                return i
        return None
    
    def analyze_trend(
        self, 
        values: np.ndarray, 
        burnup: np.ndarray
    ) -> TrendAnalysis:
        """Analyze trend in a variable"""
        if len(values) < 2:
            return TrendAnalysis(
                variable="unknown",
                trend_type=TrendType.STABLE,
                slope=0,
                start_value=values[0] if len(values) > 0 else 0,
                end_value=values[-1] if len(values) > 0 else 0
            )
        
        start_val = values[0]
        end_val = values[-1]
        
        # Linear regression for slope
        valid_mask = ~np.isnan(values) & ~np.isnan(burnup)
        if valid_mask.sum() >= 2:
            coeffs = np.polyfit(burnup[valid_mask], values[valid_mask], 1)
            slope = coeffs[0]
        else:
            slope = 0
        
        # Determine trend type
        delta = end_val - start_val
        if abs(delta) < start_val * 0.02:  # Within 2%
            trend_type = TrendType.STABLE
        elif delta > 0:
            trend_type = TrendType.INCREASING
        else:
            trend_type = TrendType.DECREASING
        
        # Find peak/valley
        peak_idx = np.argmax(values)
        peak_val = values[peak_idx]
        
        return TrendAnalysis(
            variable="",
            trend_type=trend_type,
            slope=slope,
            start_value=start_val,
            end_value=end_val,
            peak_value=peak_val,
            peak_step=int(peak_idx)
        )
    
    def analyze(self) -> CaseReport:
        """Perform comprehensive case analysis"""
        df = self.data
        summary = self.summary
        
        if df.empty or summary is None:
            return CaseReport(
                case_id=self.case_id,
                group=self.case_id[0],
                keff_initial=0,
                keff_final=0,
                keff_decline=0,
                cr_initial=0,
                cr_final=0,
                cr_change=0,
                fir_initial=0,
                fir_final=0,
                fir_change=0,
                max_burnup_reached=0,
                data_quality="poor"
            )
        
        # Basic metrics
        keff_initial = df['keff'].iloc[0] if 'keff' in df.columns else 0
        keff_final = df['keff'].iloc[-1] if 'keff' in df.columns else 0
        cr_initial = df['conversion_ratio'].iloc[0] if 'conversion_ratio' in df.columns else 0
        cr_final = df['conversion_ratio'].iloc[-1] if 'conversion_ratio' in df.columns else 0
        burnup = df['burnup'].values if 'burnup' in df.columns else np.array([0])
        
        # Compute FIR
        fir = self.compute_fir(df)
        fir_initial = fir.iloc[0] if len(fir) > 0 else 1
        fir_final = fir.iloc[-1] if len(fir) > 0 else 1
        
        # Analyze trends
        trends = []
        
        if 'keff' in df.columns:
            keff_trend = self.analyze_trend(df['keff'].values, burnup)
            keff_trend.variable = 'keff'
            keff_trend.critical_step = self.detect_critical_step(df)
            trends.append(keff_trend)
        
        if 'conversion_ratio' in df.columns:
            cr_trend = self.analyze_trend(df['conversion_ratio'].values, burnup)
            cr_trend.variable = 'conversion_ratio'
            trends.append(cr_trend)
        
        # U-233 breeding analysis (Group B cases)
        if 'Mdens_U233' in df.columns:
            u233_trend = self.analyze_trend(df['Mdens_U233'].values, burnup)
            u233_trend.variable = 'U-233'
            trends.append(u233_trend)
        
        # U-235 consumption
        if 'Mdens_U235' in df.columns:
            u235_trend = self.analyze_trend(df['Mdens_U235'].values, burnup)
            u235_trend.variable = 'U-235'
            trends.append(u235_trend)
        
        # Pu-239 production
        if 'Mdens_Pu239' in df.columns:
            pu239_trend = self.analyze_trend(df['Mdens_Pu239'].values, burnup)
            pu239_trend.variable = 'Pu-239'
            trends.append(pu239_trend)
        
        # Generate recommendations
        recommendations = self._generate_recommendations(
            keff_initial, keff_final, cr_initial, cr_final, 
            fir_initial, fir_final, summary.group_letter
        )
        
        return CaseReport(
            case_id=self.case_id,
            group=summary.group_letter,
            keff_initial=keff_initial,
            keff_final=keff_final,
            keff_decline=keff_final - keff_initial,
            cr_initial=cr_initial,
            cr_final=cr_final,
            cr_change=cr_final - cr_initial,
            fir_initial=fir_initial,
            fir_final=fir_final,
            fir_change=fir_final - fir_initial,
            max_burnup_reached=burnup[-1] if len(burnup) > 0 else 0,
            trends=trends,
            u233_breeding=trends[-3].end_value if len(trends) >= 3 else None,
            u235_consumption=trends[-2].end_value if len(trends) >= 2 else None,
            pu239_production=trends[-1].end_value if len(trends) >= 1 else None,
            recommendations=recommendations,
            analysis_timestamp=pd.Timestamp.now().isoformat(),
            data_quality="good"
        )
    
    def _generate_recommendations(
        self,
        keff_0: float, keff_f: float,
        cr_0: float, cr_f: float,
        fir_0: float, fir_f: float,
        group: str
    ) -> List[str]:
        """Generate optimization recommendations based on analysis"""
        recs = []
        
        # Keff analysis
        if keff_0 > 1.5:
            recs.append("初始keff过高(>1.5)，考虑降低初始富集度或Th-232比例")
        elif keff_0 < 0.9:
            recs.append("初始keff过低(<0.9)，需要增加可裂变材料初始装载")
        
        if keff_f < 0.9:
            recs.append(f"燃耗结束时keff={keff_f:.3f}<1.0，燃料无法持续运行")
        
        # CR analysis
        if cr_f > 1.1:
            recs.append("CR>1.1，系统具有潜在的增殖能力，可增加燃耗深度")
        elif cr_f < 0.5:
            recs.append("CR<0.5，转换比较低，考虑优化Th-232与铀/钚比例")
        
        # Group-specific recommendations
        if group == 'A':
            if fir_f > fir_0:
                recs.append("U-Th体系：FIR增加表明Th-232转化为U-233效率良好")
        
        elif group == 'B':
            if keff_0 > 1.2:
                recs.append("U-233启动体系：初始keff偏高，可尝试更高的Th-232装载")
        
        elif group == 'C':
            if cr_0 < 0.5:
                recs.append("Pu-239启动体系：初始CR较低，考虑增加Th-232初始比例")
        
        elif group == 'D':
            recs.append("混合体系：综合评估各组分转化效率")
        
        return recs


class GroupAgent:
    """
    Agent for group-level analysis.
    
    Analyzes patterns across all cases in a group (A/B/C/D).
    """
    
    def __init__(self, group: str, data_lake: DataLake):
        self.group = group
        self.dl = data_lake
        self._case_ids: Optional[List[str]] = None
    
    @property
    def case_ids(self) -> List[str]:
        if self._case_ids is None:
            self._case_ids = self.dl.filter_cases(groups=[self.group])
        return self._case_ids
    
    def get_group_statistics(self) -> Dict[str, Any]:
        """Get statistical summary for the group"""
        cases = []
        for case_id in self.case_ids:
            agent = CaseAgent(case_id, self.dl)
            if agent.summary:
                cases.append({
                    'case_id': case_id,
                    'keff_0': agent.summary.keff_0,
                    'keff_f': agent.summary.keff_final,
                    'cr_0': agent.summary.cr_0,
                    'cr_f': agent.summary.cr_final,
                    'fir_0': agent.summary.fir_0,
                    'fir_f': agent.summary.fir_final,
                    'max_burnup': agent.summary.max_burnup
                })
        
        if not cases:
            return {}
        
        df = pd.DataFrame(cases)
        return {
            'n_cases': len(cases),
            'keff_0': {'mean': df['keff_0'].mean(), 'std': df['keff_0'].std(),
                      'min': df['keff_0'].min(), 'max': df['keff_0'].max()},
            'keff_f': {'mean': df['keff_f'].mean(), 'std': df['keff_f'].std(),
                      'min': df['keff_f'].min(), 'max': df['keff_f'].max()},
            'cr_0': {'mean': df['cr_0'].mean(), 'std': df['cr_0'].std(),
                    'min': df['cr_0'].min(), 'max': df['cr_0'].max()},
            'cr_f': {'mean': df['cr_f'].mean(), 'std': df['cr_f'].std(),
                    'min': df['cr_f'].min(), 'max': df['cr_f'].max()},
            'max_burnup': {'mean': df['max_burnup'].mean(), 'std': df['max_burnup'].std()}
        }
    
    def find_best_cases(
        self, 
        metric: str = 'keff_0',
        top_n: int = 5,
        ascending: bool = False
    ) -> List[Dict]:
        """Find best performing cases by a metric"""
        cases = []
        for case_id in self.case_ids:
            agent = CaseAgent(case_id, self.dl)
            if agent.summary:
                cases.append({
                    'case_id': case_id,
                    'metric_value': getattr(agent.summary, metric, 0),
                    'keff_0': agent.summary.keff_0,
                    'cr_0': agent.summary.cr_0,
                    'max_burnup': agent.summary.max_burnup
                })
        
        cases.sort(key=lambda x: x['metric_value'], reverse=not ascending)
        return cases[:top_n]
    
    def find_balanced_cases(
        self,
        keff_target: Tuple[float, float] = (1.0, 1.3),
        cr_target: Tuple[float, float] = (0.5, 1.0)
    ) -> List[str]:
        """Find cases meeting balanced criteria"""
        balanced = []
        for case_id in self.case_ids:
            agent = CaseAgent(case_id, self.dl)
            if agent.summary:
                if (keff_target[0] <= agent.summary.keff_0 <= keff_target[1] and
                    cr_target[0] <= agent.summary.cr_0 <= cr_target[1]):
                    balanced.append(case_id)
        return balanced


class TrendAgent:
    """
    Agent for cross-case trend analysis.
    
    Identifies patterns and correlations across different cases.
    """
    
    def __init__(self, data_lake: DataLake):
        self.dl = data_lake
    
    def correlate_metrics(
        self, 
        metric1: str, 
        metric2: str,
        groups: Optional[List[str]] = None
    ) -> Dict[str, float]:
        """Calculate correlation between two metrics"""
        cases = self.dl.get_all_summaries()
        
        if groups:
            cases = [c for c in cases if c.group_letter in groups]
        
        if not cases:
            return {}
        
        vals1 = [getattr(c, metric1, 0) or 0 for c in cases]
        vals2 = [getattr(c, metric2, 0) or 0 for c in cases]
        
        # Pearson correlation
        corr = np.corrcoef(vals1, vals2)[0, 1]
        
        return {
            'correlation': corr,
            'n_samples': len(cases),
            'metric1_mean': np.mean(vals1),
            'metric2_mean': np.mean(vals2)
        }
    
    def find_outliers(self, metric: str, std_threshold: float = 2.0) -> List[str]:
        """Find outlier cases by metric"""
        cases = self.dl.get_all_summaries()
        values = [(c.case_id, getattr(c, metric, 0) or 0) for c in cases]
        
        if not values:
            return []
        
        mean = np.mean([v for _, v in values])
        std = np.std([v for _, v in values])
        
        outliers = [
            case_id for case_id, val in values
            if abs(val - mean) > std_threshold * std
        ]
        
        return outliers


# Example usage
if __name__ == '__main__':
    from pathlib import Path
    
    # Initialize
    db_path = Path(__file__).parent.parent.parent / "data_lake.db"
    dl = DataLake(db_path)
    
    if dl.count() > 0:
        # Analyze a single case
        agent = CaseAgent("A001", dl)
        report = agent.analyze()
        print(report.summary_text())
        print(report.recommendations_text())
        
        # Analyze a group
        group_agent = GroupAgent("B", dl)
        stats = group_agent.get_group_statistics()
        print(f"\nGroup B Statistics: {stats}")
        
        # Cross-case trend analysis
        trend_agent = TrendAgent(dl)
        corr = trend_agent.correlate_metrics('keff_0', 'cr_0')
        print(f"\nKeff-CR Correlation: {corr}")