#!/usr/bin/env python3
# pyright: reportMissingImports=false, reportMissingModuleSource=false
"""
Atomic Density Evolution plotting script.

Generates per-case Adens_evolution plots (14 isotopes vs EFPD, semilogy, skip zero-only).
Output: C:\\Users\\lsy05\\serpent_data\\results\\analysis\\V1\\Adens_evolution\\
"""
import os
import sys
from datetime import datetime
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# ── Isotopes to plot ──────────────────────────────────────────────
SINGLE_ADENS_COLS = [
    'Adens_U233', 'Adens_U235', 'Adens_U238', 'Adens_Th232',
    'Adens_Pa233', 'Adens_Pu239', 'Adens_Pu240', 'Adens_Pu241',
    'Adens_Pu242', 'Adens_Sm149', 'Adens_Xe135',
]

AM_COMBINED_COLS = ['Adens_Am241', 'Adens_Am243']
ALL_ADENS_COLS = SINGLE_ADENS_COLS + AM_COMBINED_COLS

SINGLE_LABELS = {
    'Adens_U233': 'U-233', 'Adens_U235': 'U-235', 'Adens_U238': 'U-238',
    'Adens_Th232': 'Th-232', 'Adens_Pa233': 'Pa-233', 'Adens_Pu239': 'Pu-239',
    'Adens_Pu240': 'Pu-240', 'Adens_Pu241': 'Pu-241', 'Adens_Pu242': 'Pu-242',
    'Adens_Sm149': 'Sm-149', 'Adens_Xe135': 'Xe-135',
}

AM_PLOT_LABEL = 'Am (241, 243)'

# ── Paths ─────────────────────────────────────────────────────────
BASE_DIR = Path(r'C:\Users\lsy05\serpent_data\results')
CSV_PATH = BASE_DIR / 'data_processed' / 'V1' / 'data.csv'
ADENS_OUT = BASE_DIR / 'analysis' / 'V1' / 'Adens_evolution'
KEFF_OUT = BASE_DIR / 'analysis' / 'V1' / 'KEFF'

# ── Data loading ──────────────────────────────────────────────────
def load_data(csv_path):
    df = pd.read_csv(csv_path, comment='#')
    df.columns = df.columns.str.strip()
    return df


# ── Adens_evolution per-case plots ───────────────────────────────
def plot_adens_evolution(df_case, case_name, outdir):
    """Generate 12 separate isotope plots vs EFPD for a single case."""
    efpd = df_case['EFPD'].values
    case_dir = Path(outdir) / case_name
    case_dir.mkdir(parents=True, exist_ok=True)

    plotted_count = 0

    # Single isotope columns
    for col in SINGLE_ADENS_COLS:
        if col not in df_case.columns:
            continue
        vals = df_case[col].values
        if np.all(vals == 0):
            continue

        label = SINGLE_LABELS.get(col, col.replace('Adens_', ''))
        filename = f'{label.replace(" ", "_").replace("-", "_")}.png'

        fig, ax = plt.subplots(figsize=(10, 6))
        data_masked = np.where(vals > 0, vals, np.nan)
        ax.semilogy(efpd, data_masked, 'o-', markersize=4, linewidth=1.5, color='steelblue')
        ax.set_xlabel('EFPD (day)', fontsize=12)
        ax.set_ylabel('Atomic Density (atoms/barn/cm)', fontsize=12)
        ax.set_title(f'{case_name}: {label} Atomic Density vs EFPD', fontsize=14)
        ax.grid(True, alpha=0.3)

        plt.tight_layout()
        out_path = case_dir / filename
        plt.savefig(out_path, dpi=150, bbox_inches='tight')
        plt.close()
        plotted_count += 1

    # Combined Am (241, 243)
    am_has_data = False
    for col in AM_COMBINED_COLS:
        if col in df_case.columns:
            vals = df_case[col].values
            if not np.all(vals == 0):
                am_has_data = True
                break

    if am_has_data:
        fig, ax = plt.subplots(figsize=(10, 6))
        colors = ['crimson', 'darkorange']
        labels_am = ['Am-241', 'Am-243']

        for col, color, label in zip(AM_COMBINED_COLS, colors, labels_am):
            if col in df_case.columns:
                vals = df_case[col].values
                data_masked = np.where(vals > 0, vals, np.nan)
                ax.semilogy(efpd, data_masked, '-o', markersize=4, linewidth=1.5,
                           color=color, label=label)

        ax.set_xlabel('EFPD (day)', fontsize=12)
        ax.set_ylabel('Atomic Density (atoms/barn/cm)', fontsize=12)
        ax.set_title(f'{case_name}: Am (241, 243) Atomic Density vs EFPD', fontsize=14)
        ax.legend(fontsize=10)
        ax.grid(True, alpha=0.3)

        plt.tight_layout()
        out_path = case_dir / 'Am_241_243.png'
        plt.savefig(out_path, dpi=150, bbox_inches='tight')
        plt.close()
        plotted_count += 1

    print(f'Case {case_name} Adens_evolution saved ({plotted_count} plots)')


def plot_keff_evolution(df_case, case_name, outdir):
    """Generate a per-case Keff vs burnup plot with Keff=1.03 reference line."""
    if 'ANA_KEFF' not in df_case.columns or 'burnup_MWd_kgHM' not in df_case.columns:
        print(f'Case {case_name}: missing ANA_KEFF or burnup column, skipping Keff plot')
        return

    df_plot = df_case[['burnup_MWd_kgHM', 'ANA_KEFF']].dropna().sort_values('burnup_MWd_kgHM')
    if df_plot.empty:
        print(f'Case {case_name}: no valid Keff data, skipping Keff plot')
        return

    fig, ax = plt.subplots(figsize=(10, 6))
    ax.plot(df_plot['burnup_MWd_kgHM'], df_plot['ANA_KEFF'], 'o-', markersize=4,
            linewidth=1.5, color='navy')
    ax.axhline(y=1.03, color='r', linestyle='--', linewidth=1.2, alpha=0.7,
               label='Keff = 1.03')
    ax.set_xlabel('Burnup (MWd/kgHM)', fontsize=12)
    ax.set_ylabel('Keff', fontsize=12)
    ax.set_title(f'{case_name}: Keff vs Burnup', fontsize=14)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=10)

    plt.tight_layout()
    case_dir = Path(outdir) / case_name
    case_dir.mkdir(parents=True, exist_ok=True)
    out_path = case_dir / 'keff_vs_burnup.png'
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'Case {case_name} Keff plot saved')


# ── Per-case Adens summary CSV (BURN_STEP 0..25) ───────────────────
META_COLS = ['BURN_STEP', 'case', 'layout_base', 'Th_level', 'Pu_level',
             'U235_enrichment', 'U233_enrichment', 'burnup_MWd_kgHM', 'EFPD']

ADENS_KEY = ['Adens_U233', 'Adens_U235', 'Adens_U238', 'Adens_Th232',
             'Adens_Pa233', 'Adens_Pu239', 'Adens_Pu240', 'Adens_Pu241',
             'Adens_Pu242', 'Adens_Am241', 'Adens_Am243',
             'Adens_Sm149', 'Adens_Xe135']


def collect_adens_columns(df):
    """Return the list of ADENS_KEY columns that exist in df, in ADENS_KEY order."""
    return [c for c in ADENS_KEY if c in df.columns]


def write_case_adens_summary(df, case_name, outdir):
    """Write a per-case Adens summary CSV containing BURN_STEP 0..25."""
    case_dir = Path(outdir) / case_name
    case_dir.mkdir(parents=True, exist_ok=True)

    df_c = df[df['case'] == case_name].sort_values('BURN_STEP')
    if 'BURN_STEP' in df_c.columns:
        df_c = df_c[df_c['BURN_STEP'].between(0, 25, inclusive='both')]

    if df_c.empty:
        print(f'  Case {case_name}: no rows with BURN_STEP 0..25, skipping adens CSV')
        return

    meta_order = ['case', 'layout_base', 'Th_level', 'Pu_level',
                  'U235_enrichment', 'U233_enrichment', 'burnup_MWd_kgHM',
                  'EFPD', 'BURN_STEP']

    adens_cols = collect_adens_columns(df)
    out_cols = meta_order + adens_cols

    for col in out_cols:
        if col not in df_c.columns:
            df_c[col] = np.nan

    out_df = df_c.loc[:, out_cols]
    out_path = case_dir / f'{case_name}_adens_summary.csv'
    out_df.to_csv(out_path, index=False)
    print(f'  Case {case_name}: adens summary CSV saved to {out_path}')


# ── Tee logging ───────────────────────────────────────────────────
class Tee:
    def __init__(self, *streams):
        self.streams = streams

    def write(self, data):
        for s in self.streams:
            s.write(data)
            s.flush()

    def flush(self):
        for s in self.streams:
            s.flush()


# ── Main ──────────────────────────────────────────────────────────
def main():
    import argparse
    parser = argparse.ArgumentParser(description='Generate Adens_evolution plots.')
    parser.add_argument('--csv', '-c', default=str(CSV_PATH),
                        help='Path to the processed CSV data file')
    parser.add_argument('--adens-out', default=str(ADENS_OUT),
                        help='Output directory for Adens_evolution plots')
    args = parser.parse_args()

    adens_dir = Path(args.adens_out)
    keff_dir = KEFF_OUT
    adens_dir.mkdir(parents=True, exist_ok=True)
    keff_dir.mkdir(parents=True, exist_ok=True)

    # Logging
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    log_dir = BASE_DIR / 'analysis' / 'V1' / 'log'
    log_dir.mkdir(parents=True, exist_ok=True)
    log_path = log_dir / f'adens_evolution_{ts}.log'

    orig_stdout = sys.stdout
    orig_stderr = sys.stderr
    with open(log_path, 'a', encoding='utf-8') as log_file:
        sys.stdout = Tee(orig_stdout, log_file)
        sys.stderr = Tee(orig_stderr, log_file)
        try:
            print(f'Loading data from {args.csv}...')
            df = load_data(args.csv)
            print(f'Loaded {len(df)} rows, {df["case"].nunique()} cases')

            print('\n=== Adens_evolution plots ===')
            for case_name in sorted(df['case'].unique()):
                df_case = df[df['case'] == case_name].sort_values('BURN_STEP')
                plot_adens_evolution(df_case, case_name, adens_dir)
                plot_keff_evolution(df_case, case_name, keff_dir)
                try:
                    write_case_adens_summary(df, case_name, adens_dir)
                except Exception as e:
                    print(f'  Warning: failed to write adens summary for {case_name}: {e}')

            print(f'\n=== All outputs generated ===')
            print(f'  Adens_evolution: {adens_dir}')
            print(f'  Keff plots: {keff_dir}')
        finally:
            sys.stdout = orig_stdout
            sys.stderr = orig_stderr


if __name__ == '__main__':
    main()