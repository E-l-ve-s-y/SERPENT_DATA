#!/usr/bin/env python3
"""
Orchestrator - AI Agent Orchestration Layer
============================================
Coordinates multiple AI agents for parallel execution and result aggregation.

Features:
- Parallel case analysis with worker pool
- Task queue management
- Result aggregation and ranking
- Progress tracking
- Optimized design suggestions
"""

from pathlib import Path
from typing import Optional, List, Dict, Any, Callable, TypeVar, Tuple
from dataclasses import dataclass, field
from enum import Enum
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor, as_completed
from queue import Queue
from threading import Lock
import time
import json

import numpy as np
import pandas as pd

# Import agents
from results.script.agent.data_layer import DataLake, CaseSummary
from results.script.agent.cache_layer import MultiLevelCache, get_global_cache
from results.script.agent.agents import CaseAgent, GroupAgent, TrendAgent, CaseReport


T = TypeVar('T')


class TaskStatus(Enum):
    """Task execution status"""
    PENDING = "pending"
    RUNNING = "running"
    COMPLETED = "completed"
    FAILED = "failed"


@dataclass
class Task:
    """Analysis task"""
    task_id: str
    agent_type: str  # 'case', 'group', 'trend'
    params: Dict[str, Any]
    status: TaskStatus = TaskStatus.PENDING
    result: Any = None
    error: str = ""
    start_time: float = 0
    end_time: float = 0
    
    @property
    def duration(self) -> float:
        return self.end_time - self.start_time if self.end_time > 0 else 0


@dataclass
class OptimizationResult:
    """Optimization result"""
    target_function: str
    constraints: Dict[str, Any]
    top_candidates: List[Dict]
    recommendations: List[str]
    execution_time: float


class ProgressTracker:
    """Thread-safe progress tracking"""
    
    def __init__(self, total: int):
        self.total = total
        self.completed = 0
        self.failed = 0
        self._lock = Lock()
    
    def increment(self, success: bool = True):
        with self._lock:
            self.completed += 1
            if not success:
                self.failed += 1
    
    @property
    def progress(self) -> float:
        return (self.completed / self.total * 100) if self.total > 0 else 0
    
    def __str__(self) -> str:
        return f"{self.completed}/{self.total} ({self.progress:.1f}%)" + \
               (f" [Failed: {self.failed}]" if self.failed > 0 else "")


class Orchestrator:
    """
    Main orchestrator for AI agent coordination.
    
    Handles:
    - Parallel task execution
    - Resource management
    - Result aggregation
    - Optimization workflow
    """
    
    def __init__(
        self,
        data_lake: Optional[DataLake] = None,
        max_workers: int = 4,
        cache: Optional[MultiLevelCache] = None
    ):
        self.dl = data_lake or DataLake()
        self.max_workers = max_workers
        self.cache = cache or get_global_cache()
        
        self._task_queue: List[Task] = []
        self._results: Dict[str, Any] = {}
        self._lock = Lock()
    
    # ==================== Parallel Case Analysis ====================
    
    def parallel_analyze(
        self,
        case_ids: List[str],
        progress_callback: Optional[Callable[[int, int], None]] = None
    ) -> Dict[str, CaseReport]:
        """
        Analyze multiple cases in parallel.
        
        Args:
            case_ids: List of case IDs to analyze
            progress_callback: Optional callback(completed, total)
        
        Returns:
            Dict mapping case_id -> CaseReport
        """
        results = {}
        tracker = ProgressTracker(len(case_ids))
        
        print(f"Starting parallel analysis of {len(case_ids)} cases...")
        
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            # Submit all tasks
            futures = {
                executor.submit(self._analyze_single_case, case_id): case_id
                for case_id in case_ids
            }
            
            # Collect results as they complete
            for future in as_completed(futures):
                case_id = futures[future]
                try:
                    report = future.result()
                    results[case_id] = report
                    tracker.increment(success=True)
                except Exception as e:
                    tracker.increment(success=False)
                    results[case_id] = None
                    print(f"Failed to analyze {case_id}: {e}")
                
                if progress_callback:
                    progress_callback(tracker.completed, tracker.total)
                elif tracker.completed % 10 == 0:
                    print(f"  Progress: {tracker}")
        
        print(f"Completed: {tracker}")
        return results
    
    def _analyze_single_case(self, case_id: str) -> CaseReport:
        """Analyze a single case (runs in thread pool)"""
        agent = CaseAgent(case_id, self.dl, self.cache)
        return agent.analyze()
    
    # ==================== Group Analysis ====================
    
    def analyze_groups(
        self,
        groups: Optional[List[str]] = None,
        parallel: bool = True
    ) -> Dict[str, Dict]:
        """
        Analyze all groups or specific groups.
        
        Args:
            groups: List of groups to analyze (default: all)
            parallel: Whether to analyze groups in parallel
        
        Returns:
            Dict mapping group -> analysis results
        """
        if groups is None:
            groups = ['A', 'B', 'C', 'D']
        
        if parallel:
            results = {}
            with ThreadPoolExecutor(max_workers=len(groups)) as executor:
                futures = {
                    executor.submit(self._analyze_single_group, g): g
                    for g in groups
                }
                for future in as_completed(futures):
                    group = futures[future]
                    results[group] = future.result()
            return results
        else:
            return {g: self._analyze_single_group(g) for g in groups}
    
    def _analyze_single_group(self, group: str) -> Dict:
        """Analyze a single group"""
        agent = GroupAgent(group, self.dl)
        
        return {
            'statistics': agent.get_group_statistics(),
            'best_by_keff': agent.find_best_cases('keff_0', top_n=3),
            'best_by_cr': agent.find_best_cases('cr_0', top_n=3, ascending=True),
            'balanced': agent.find_balanced_cases()
        }
    
    # ==================== Trend Analysis ====================
    
    def cross_case_trends(self) -> Dict[str, Any]:
        """Analyze trends across all cases"""
        agent = TrendAgent(self.dl)
        
        return {
            'keff_vs_cr': agent.correlate_metrics('keff_0', 'cr_0'),
            'keff_vs_burnup': agent.correlate_metrics('keff_0', 'max_burnup'),
            'cr_vs_burnup': agent.correlate_metrics('cr_0', 'max_burnup'),
            'fir_vs_cr': agent.correlate_metrics('fir_0', 'cr_0'),
            'outliers_keff': agent.find_outliers('keff_0'),
            'outliers_cr': agent.find_outliers('cr_0')
        }
    
    # ==================== Optimization ====================
    
    def optimize_design(
        self,
        objective: str = 'keff_stability',  # keff_stability, cr_maximum, fir_maximum, balanced
        constraints: Optional[Dict[str, tuple]] = None,
        top_n: int = 10
    ) -> OptimizationResult:
        """
        Optimize fuel design based on objectives and constraints.
        
        Args:
            objective: Optimization objective
                - 'keff_stability': Keep keff close to 1.0 throughout
                - 'cr_maximum': Maximize conversion ratio
                - 'fir_maximum': Maximize fissile inventory ratio
                - 'balanced': Balance multiple metrics
            constraints: Dict of metric -> (min, max) bounds
            top_n: Number of top candidates to return
        
        Returns:
            OptimizationResult with top candidates and recommendations
        """
        start_time = time.time()
        constraints = constraints or {}
        
        # Get all case summaries
        cases = self.dl.get_all_summaries()
        
        # Score each case
        scored_cases = []
        for case in cases:
            score, metrics = self._score_case(case, objective, constraints)
            if score is not None:
                scored_cases.append({
                    'case_id': case.case_id,
                    'group': case.group_letter,
                    'score': score,
                    **metrics
                })
        
        # Sort by score (descending)
        scored_cases.sort(key=lambda x: x['score'], reverse=True)
        
        # Get top candidates
        top_candidates = scored_cases[:top_n]
        
        # Generate recommendations
        recommendations = self._generate_optimization_recommendations(
            top_candidates, objective
        )
        
        execution_time = time.time() - start_time
        
        return OptimizationResult(
            target_function=objective,
            constraints=constraints,
            top_candidates=top_candidates,
            recommendations=recommendations,
            execution_time=execution_time
        )
    
    def _score_case(
        self,
        case: CaseSummary,
        objective: str,
        constraints: Dict[str, tuple]
    ) -> Tuple[Optional[float], Dict]:
        """Score a single case based on objective"""
        metrics = {
            'keff_0': case.keff_0,
            'keff_f': case.keff_final,
            'cr_0': case.cr_0,
            'cr_f': case.cr_final,
            'fir_0': case.fir_0,
            'fir_f': case.fir_final,
            'max_burnup': case.max_burnup
        }
        
        # Check constraints
        for metric, (min_val, max_val) in constraints.items():
            val = getattr(case, metric, None)
            if val is None or val < min_val or val > max_val:
                return None, metrics
        
        # Calculate score based on objective
        if objective == 'keff_stability':
            # Prefer keff close to 1.0 throughout
            keff_range = abs(case.keff_0 - 1.0) + abs(case.keff_final - 1.0)
            score = 2.0 - keff_range
        
        elif objective == 'cr_maximum':
            # Maximize final CR
            score = case.cr_final
        
        elif objective == 'fir_maximum':
            # Maximize FIR throughout (prefer higher fir_f)
            score = case.fir_final
        
        elif objective == 'balanced':
            # Balance multiple metrics
            keff_score = 1.0 - abs(case.keff_0 - 1.2) if case.keff_0 > 0.9 else 0
            cr_score = case.cr_final
            fir_score = case.fir_final
            score = (keff_score + cr_score + fir_score) / 3
        
        else:
            score = 1.0
        
        return score, metrics
    
    def _generate_optimization_recommendations(
        self,
        top_candidates: List[Dict],
        objective: str
    ) -> List[str]:
        """Generate recommendations based on top candidates"""
        recs = []
        
        if not top_candidates:
            recs.append("未找到满足约束条件的算例，请放宽约束条件")
            return recs
        
        # Group analysis
        groups = [c['group'] for c in top_candidates]
        group_counts = {g: groups.count(g) for g in set(groups)}
        best_group = max(group_counts, key=group_counts.get)
        
        recs.append(f"最优组分为 {best_group} 组，占据前{group_counts[best_group]}个最优算例")
        
        # Metric analysis
        avg_keff = np.mean([c['keff_0'] for c in top_candidates])
        avg_cr = np.mean([c['cr_0'] for c in top_candidates])
        avg_fir = np.mean([c['fir_0'] for c in top_candidates])
        
        if objective == 'keff_stability':
            recs.append(f"Keff稳定性优化：平均初始keff={avg_keff:.4f}，建议范围1.0-1.3")
        elif objective == 'cr_maximum':
            recs.append(f"CR最大化优化：平均CR={avg_cr:.4f}，考虑增加Th-232比例")
        elif objective == 'balanced':
            recs.append(f"平衡优化：Keff={avg_keff:.3f}, CR={avg_cr:.3f}, FIR={avg_fir:.3f}")
        
        return recs
    
    # ==================== Comprehensive Analysis ====================
    
    def run_full_analysis(self) -> Dict[str, Any]:
        """
        Run comprehensive analysis of all data.
        
        Returns a complete analysis report.
        """
        print("="*60)
        print("Starting Comprehensive Analysis")
        print("="*60)
        
        # 1. Group analysis
        print("\n[1/4] Analyzing groups...")
        group_results = self.analyze_groups()
        
        # 2. Cross-case trends
        print("\n[2/4] Analyzing cross-case trends...")
        trend_results = self.cross_case_trends()
        
        # 3. Run optimizations
        print("\n[3/4] Running optimizations...")
        optimizations = {
            'keff_stability': self.optimize_design('keff_stability'),
            'cr_maximum': self.optimize_design('cr_maximum'),
            'balanced': self.optimize_design('balanced')
        }
        
        # 4. Generate summary report
        print("\n[4/4] Generating summary...")
        summary = {
            'total_cases': self.dl.count(),
            'group_statistics': self.dl.get_group_statistics().to_dict(),
            'group_analysis': group_results,
            'trends': trend_results,
            'optimizations': {
                k: {
                    'top_candidates': v.top_candidates,
                    'recommendations': v.recommendations,
                    'execution_time': v.execution_time
                }
                for k, v in optimizations.items()
            },
            'timestamp': pd.Timestamp.now().isoformat()
        }
        
        print("\n" + "="*60)
        print("Analysis Complete!")
        print("="*60)
        
        return summary
    
    # ==================== Utility Methods ====================
    
    def export_results(
        self,
        results: Dict[str, Any],
        output_path: Path,
        format: str = 'json'
    ):
        """Export results to file"""
        output_path = Path(output_path)
        
        if format == 'json':
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(results, f, indent=2, default=str)
        elif format == 'csv':
            if 'optimizations' in results:
                opt_data = []
                for obj_name, opt in results['optimizations'].items():
                    for candidate in opt.get('top_candidates', []):
                        candidate['objective'] = obj_name
                        opt_data.append(candidate)
                if opt_data:
                    df = pd.DataFrame(opt_data)
                    df.to_csv(output_path, index=False)
        
        print(f"Results exported to {output_path}")
    
    def get_cache_stats(self) -> Dict:
        """Get cache statistics"""
        return self.cache.get_stats()


# Standalone analysis function
def quick_analyze(
    case_ids: List[str],
    output_dir: Optional[Path] = None,
    max_workers: int = 4
):
    """
    Quick analysis function for common use cases.
    
    Args:
        case_ids: Cases to analyze
        output_dir: Directory for output files
        max_workers: Parallel workers
    """
    orchestrator = Orchestrator(max_workers=max_workers)
    
    # Analyze cases
    reports = orchestrator.parallel_analyze(case_ids)
    
    # Generate output
    output_dir = output_dir or Path("analysis_results")
    output_dir.mkdir(exist_ok=True)
    
    # Save individual reports
    for case_id, report in reports.items():
        if report:
            report_path = output_dir / f"{case_id}_report.txt"
            with open(report_path, 'w', encoding='utf-8') as f:
                f.write(report.summary_text())
                f.write(report.recommendations_text())
    
    print(f"\nReports saved to {output_dir}")
    return reports


# Example usage
if __name__ == '__main__':
    from pathlib import Path
    
    # Initialize orchestrator
    db_path = Path(__file__).parent.parent.parent / "data_lake.db"
    orch = Orchestrator(data_lake=DataLake(db_path), max_workers=4)
    
    # Check if data exists
    if orch.dl.count() == 0:
        print("No data in data lake. Run extract_data.py first.")
    else:
        # Quick analysis of a few cases
        case_ids = orch.dl.filter_cases(groups=['A', 'B'])[:10]
        reports = quick_analyze(case_ids)
        
        # Optimization example
        opt_result = orch.optimize_design('balanced')
        print(f"\nTop candidates for balanced optimization:")
        for i, c in enumerate(opt_result.top_candidates[:5], 1):
            print(f"  {i}. {c['case_id']} (score={c['score']:.4f})")
        
        for rec in opt_result.recommendations:
            print(f"  • {rec}")