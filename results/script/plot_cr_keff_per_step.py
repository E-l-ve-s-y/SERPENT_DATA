#!/usr/bin/env python3
# pyright: reportMissingImports=false, reportMissingModuleSource=false
"""
CR vs Keff scatter plots - per burnup step.

Generates 130 images:
  - 4 series plots per step (A, B, C, D groups) x 26 steps = 104
  - 1 combined plot per step x 26 steps = 26
  - Total: 130 images

Output: CR+KEFF directory under analysis/V1 folder
"""
import os
import sys
from datetime import datetime
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
import numpy as np
import pandas as pd


# ── Paths ─────────────────────────────────────────────────────────
BASE_DIR = Path(r'C:\Users\lsy05\serpent_data\results')
CSV_PATH = BASE_DIR / 'data_processed' / 'V1' / 'data.csv'
OUTPUT_DIR = BASE_DIR / 'analysis' / 'V1' / ('CR+KEFF')
GROUP_OUTPUT_DIRS = {
    'A': OUTPUT_DIR / 'A_series',
    'B': OUTPUT_DIR / 'B_series',
    'C': OUTPUT_DIR / 'C_series',
    'D': OUTPUT_DIR / 'D_series',
}


# ── Data loading ──────────────────────────────────────────────────
def load_data(csv_path):
    df = pd.read_csv(csv_path, comment='#')
    df.columns = df.columns.str.strip()
    return df


def group_cases(df):
    """Return dict group_letter -> sorted list of case IDs."""
    groups = {}
    for case in df['case'].unique():
        letter = case[0]
        groups.setdefault(letter, []).append(case)
    for k in groups:
        groups[k] = sorted(groups[k])
    return groups


# ── 95% Confidence Ellipse ───────────────────────────────────────
def get_ellipse_params(x, y):
    """Compute ellipse center, width, height, angle from x,y data."""
    if len(x) < 3:
        return None
    x = np.asarray(x, dtype=float)
    y = np.asarray(y, dtype=float)
    cx = np.mean(x)
    cy = np.mean(y)

    # Covariance
    cov = np.cov(x, y)
    # Eigenvalues/vectors
    eigenvalues, eigenvectors = np.linalg.eigh(cov)

    # Sort descending
    order = eigenvalues.argsort()[::-1]
    eigenvalues = eigenvalues[order]
    eigenvectors = eigenvectors[:, order]

    # Chi-squared for 95% with 2 DOF = 5.991
    chi2 = 5.991
    semimajor = np.sqrt(chi2 * eigenvalues[0])
    semiminor = np.sqrt(chi2 * eigenvalues[1])

    # Angle of major axis (degrees)
    angle = np.degrees(np.arctan2(eigenvectors[1, 0], eigenvectors[0, 0]))

    return (cx, cy, semimajor, semiminor, angle)


def plot_ellipse(ax, params, color, alpha=0.2):
    """Plot a confidence ellipse on axes."""
    from matplotlib.patches import Ellipse
    if params is None:
        return
    cx, cy, w, h, angle = params
    ellipse = Ellipse(
        xy=(cx, cy), width=w, height=h, angle=angle,
        facecolor=color, edgecolor=color, linewidth=1.5,
        alpha=alpha, zorder=1
    )
    ax.add_patch(ellipse)


def add_highlight_region(ax, cr_threshold, keff_threshold):
    """Highlight the upper-right region above the configured thresholds."""
    x0, x1 = ax.get_xlim()
    y0, y1 = ax.get_ylim()
    x_right = max(x1, cr_threshold)
    y_top = max(y1, keff_threshold)

    rect = Rectangle(
        (cr_threshold, keff_threshold),
        x_right - cr_threshold,
        y_top - keff_threshold,
        facecolor='lightyellow',
        edgecolor='none',
        alpha=0.45,
        zorder=0,
    )
    ax.add_patch(rect)
    ax.set_xlim(min(x0, cr_threshold), x_right)
    ax.set_ylim(min(y0, keff_threshold), y_top)


def annotate_highlighted_points(ax, df_points, cr_threshold, keff_threshold, label_col='case'):
    """Annotate points that fall inside the highlighted region."""
    if df_points.empty or label_col not in df_points.columns:
        return

    highlight = df_points[
        (df_points['conversion_ratio'] > cr_threshold) &
        (df_points['ANA_KEFF'] >= keff_threshold)
    ]
    if highlight.empty:
        return

    offsets = [(6, 6), (6, -12), (-22, 6), (-22, -12), (8, 14), (-28, 14)]
    for idx, (_, row) in enumerate(highlight.iterrows()):
        dx, dy = offsets[idx % len(offsets)]
        ax.annotate(
            str(row[label_col]),
            (row['conversion_ratio'], row['ANA_KEFF']),
            textcoords='offset points',
            xytext=(dx, dy),
            fontsize=8,
            color='dimgray',
            ha='left',
            va='bottom',
            bbox=dict(boxstyle='round,pad=0.15', fc='white', ec='none', alpha=0.75),
            zorder=4,
        )


# ── Color & marker tables ─────────────────────────────────────────
CASE_COLORS = [
    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd',
    '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
    '#aec7e8', '#ffbb78', '#98df8a', '#ff9896', '#c5b0d5',
    '#c49c94', '#f7b6d2', '#c7c7c7', '#dbdb8d', '#9edae5',
    '#393b79', '#637939', '#8c6d31', '#843c39', '#7b4173',
    '#e7298a', '#ce6dbd', '#de9ed6',
]

CASE_MARKERS = ['o', 's', '^', 'D', 'v', 'p', 'h', 'P', 'X', '*',
                'o', 's', '^', 'D', 'v', 'p', 'h', 'P', 'X', '*',
                'o', 's', '^', 'D', 'v', 'p', 'h', 'P', 'X', '*']

GROUP_COLORS = {'A': '#2196F3', 'B': '#4CAF50', 'C': '#FF9800', 'D': '#9C27B0'}

DEFAULT_CR_THRESHOLD = 1.0
DEFAULT_KEFF_THRESHOLD = 0.9


# ── Plot per-group for a specific burnup step ────────────────────
def plot_series_per_step(df, group_letter, case_list, step, out_path,
                         cr_threshold=DEFAULT_CR_THRESHOLD,
                         keff_threshold=DEFAULT_KEFF_THRESHOLD):
    """Scatter CR vs Keff for a specific burnup step, one group."""
    # Filter data for this burnup step
    df_step = df[df['BURN_STEP'] == step]

    if df_step.empty:
        return

    fig, ax = plt.subplots(figsize=(10, 7))

    for idx, case_name in enumerate(case_list):
        df_c = df_step[df_step['case'] == case_name]
        if df_c.empty:
            continue

        x = df_c['conversion_ratio'].values
        y = df_c['ANA_KEFF'].values

        color = CASE_COLORS[idx % len(CASE_COLORS)]
        marker = CASE_MARKERS[idx % len(CASE_MARKERS)]

        ax.scatter(x, y, c=color, marker=marker, s=60, zorder=3,
                   label=case_name, alpha=0.9)

    add_highlight_region(ax, cr_threshold, keff_threshold)
    annotate_highlighted_points(ax, df_step[df_step['case'].isin(case_list)],
                                cr_threshold, keff_threshold)

    ax.set_xlabel('Conversion Ratio (CR)', fontsize=13)
    ax.set_ylabel('Keff', fontsize=13)
    ax.set_title(f'CR vs Keff — Group {group_letter} Series (Step {step:02d})',
                 fontsize=14)
    ax.legend(fontsize=8, ncol=2, loc='best')
    ax.grid(True, alpha=0.3)
    ax.set_xlim(auto=True)
    ax.set_ylim(auto=True)

    plt.tight_layout()
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'  {out_path.name}')


def plot_all_series_per_step(df, groups, step, out_path,
                             cr_threshold=DEFAULT_CR_THRESHOLD,
                             keff_threshold=DEFAULT_KEFF_THRESHOLD):
    """Scatter CR vs Keff for all groups with ellipses for a specific burnup step."""
    df_step = df[df['BURN_STEP'] == step]

    if df_step.empty:
        return

    fig, ax = plt.subplots(figsize=(12, 8))

    for letter in ['A', 'B', 'C', 'D']:
        case_list = groups.get(letter, [])
        if not case_list:
            continue

        color = GROUP_COLORS.get(letter, '#888888')

        for idx, case_name in enumerate(case_list):
            df_c = df_step[df_step['case'] == case_name]
            if df_c.empty:
                continue

            x = df_c['conversion_ratio'].values
            y = df_c['ANA_KEFF'].values

            marker = CASE_MARKERS[idx % len(CASE_MARKERS)]
            ax.scatter(x, y, c=color, marker=marker, s=50, zorder=3,
                       alpha=0.85, label=f'{case_name} (Grp {letter})')

        # Group-level 95% ellipse: collect all points for this group at this step
        df_group = df_step[df_step['case'].isin(case_list)]
        if not df_group.empty:
            x_all = df_group['conversion_ratio'].values
            y_all = df_group['ANA_KEFF'].values
            if len(x_all) >= 3:
                params = get_ellipse_params(x_all, y_all)
                if params:
                    plot_ellipse(ax, params, color, alpha=0.12)

    add_highlight_region(ax, cr_threshold, keff_threshold)
    annotate_highlighted_points(ax, df_step, cr_threshold, keff_threshold)

    ax.set_xlabel('Conversion Ratio (CR)', fontsize=13)
    ax.set_ylabel('Keff', fontsize=13)
    ax.set_title(f'CR vs Keff — All Series (Step {step:02d})', fontsize=14)
    ax.legend(fontsize=7, ncol=3, loc='best')
    ax.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'  {out_path.name}')


# ── Clean old CR+KEFF images ───────────────────────────────────────
def cleanup_old_images(output_dir):
    """Delete all PNG images in CR+KEFF folder (not Adens_evolution)."""
    removed = 0
    if output_dir.exists():
        for f in output_dir.rglob('*.png'):
            f.unlink()
            removed += 1
    return removed


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
    parser = argparse.ArgumentParser(description='Generate CR vs Keff scatter plots per burnup step.')
    parser.add_argument('--csv', '-c', default=str(CSV_PATH),
                        help='Path to the processed CSV data file')
    parser.add_argument('--out', '-o', default=str(OUTPUT_DIR),
                        help='Output directory for CR+KEFF plots')
    parser.add_argument('--cr-threshold', type=float, default=DEFAULT_CR_THRESHOLD,
                        help='Lower bound for the conversion ratio highlight region')
    parser.add_argument('--keff-threshold', type=float, default=DEFAULT_KEFF_THRESHOLD,
                        help='Lower bound for the Keff highlight region')
    parser.add_argument('--no-clean', action='store_true',
                        help='Skip cleanup of old CR+KEFF images')
    args = parser.parse_args()

    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)

    # Logging
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    log_dir = BASE_DIR / 'analysis' / 'V1' / 'log'
    log_dir.mkdir(parents=True, exist_ok=True)
    log_path = log_dir / f'cr_keff_per_step_{ts}.log'

    orig_stdout = sys.stdout
    orig_stderr = sys.stderr
    with open(log_path, 'a', encoding='utf-8') as log_file:
        sys.stdout = Tee(orig_stdout, log_file)
        sys.stderr = Tee(orig_stderr, log_file)
        try:
            if not args.no_clean:
                print('Cleaning old CR+KEFF images...')
                removed = cleanup_old_images(out_dir)
                if removed:
                    print(f'  Removed {removed} old images')

            print(f'Loading data from {args.csv}...')
            df = load_data(args.csv)
            print(f'Loaded {len(df)} rows, {df["case"].nunique()} cases')

            groups = group_cases(df)
            print(f'Groups found: {list(groups.keys())}')

            print(f'\n=== Generating CR vs Keff per burnup step ===')

            # Burnup steps 0 to 25
            burnup_steps = range(0, 26)

            total_images = 0
            for step in burnup_steps:
                print(f'\n--- Step {step:02d} ---')

                # Series plots (A, B, C, D)
                for letter in ['A', 'B', 'C', 'D']:
                    case_list = groups.get(letter, [])
                    if not case_list:
                        continue
                    group_dir = GROUP_OUTPUT_DIRS[letter]
                    group_dir.mkdir(parents=True, exist_ok=True)
                    out_path = group_dir / f'CR_vs_Keff_{letter}_series_step{step:02d}.png'
                    plot_series_per_step(
                        df,
                        letter,
                        case_list,
                        step,
                        out_path,
                        cr_threshold=args.cr_threshold,
                        keff_threshold=args.keff_threshold,
                    )
                    total_images += 1

                # Combined plot
                out_all = out_dir / f'CR_vs_Keff_ALL_series_step{step:02d}.png'
                plot_all_series_per_step(
                    df,
                    groups,
                    step,
                    out_all,
                    cr_threshold=args.cr_threshold,
                    keff_threshold=args.keff_threshold,
                )
                total_images += 1

            print(f'\n=== All outputs generated ===')
            print(f'  Output directory: {out_dir}')
            print(f'  Total images: {total_images}')

        finally:
            sys.stdout = orig_stdout
            sys.stderr = orig_stderr


if __name__ == '__main__':
    main()