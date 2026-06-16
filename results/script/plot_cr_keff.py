#!/usr/bin/env python3
# pyright: reportMissingImports=false, reportMissingModuleSource=false
"""
Per-case CR vs Keff scatter plots.

Generates one plot per case, grouped into A/B/C/D subfolders under
results/analysis/CR+KEFF, and writes a summary file for points that fall into
the highlighted region.

Highlight rule:
- Conversion Ratio > CR threshold, or
- Keff > Keff threshold
"""
from datetime import datetime
from pathlib import Path
import sys

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


BASE_DIR = Path(r'C:\Users\lsy05\serpent_data\results')
CSV_PATH = BASE_DIR / 'data_processed' / 'V1' / 'data.csv'
OUTPUT_DIR = BASE_DIR / 'analysis' / 'V1' / 'CR+KEFF'
SUMMARY_PATH = OUTPUT_DIR / 'result_cr_keff'

DEFAULT_CR_THRESHOLD = 1.0
DEFAULT_KEFF_THRESHOLD = 0.9

CASE_COLORS = [
	'#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd',
	'#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
	'#aec7e8', '#ffbb78', '#98df8a', '#ff9896', '#c5b0d5',
	'#c49c94', '#f7b6d2', '#c7c7c7', '#dbdb8d', '#9edae5',
	'#393b79', '#637939', '#8c6d31', '#843c39', '#7b4173',
	'#e7298a', '#ce6dbd', '#de9ed6',
]

MARKERS = ['o', 's', '^', 'D', 'v', 'p', 'h', 'P', 'X', '*']


def load_data(csv_path):
	df = pd.read_csv(csv_path, comment='#')
	df.columns = df.columns.str.strip()
	return df


def group_cases(df):
	groups = {}
	for case in df['case'].unique():
		groups.setdefault(case[0], []).append(case)
	for key in groups:
		groups[key] = sorted(groups[key])
	return groups


def sanitize_case_label(case_name):
	return case_name.replace(' ', '_').replace('/', '_')


def ensure_output_dirs():
	OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
	for path in get_group_output_dirs(OUTPUT_DIR).values():
		path.mkdir(parents=True, exist_ok=True)


def get_group_output_dirs(base_dir):
	return {
		'A': Path(base_dir) / 'A_series',
		'B': Path(base_dir) / 'B_series',
		'C': Path(base_dir) / 'C_series',
		'D': Path(base_dir) / 'D_series',
	}


def cleanup_old_images(output_dir):
	removed = 0
	if output_dir.exists():
		for file_path in output_dir.rglob('*.png'):
			file_path.unlink()
			removed += 1
	return removed


def get_highlight_mask(df_points, cr_threshold, keff_threshold):
	return (
		(df_points['conversion_ratio'] > cr_threshold) |
		(df_points['ANA_KEFF'] > keff_threshold)
	)


def add_highlight_regions(ax, cr_threshold, keff_threshold, x_max, y_max):
	ax.axvspan(cr_threshold, x_max, color='lightyellow', alpha=0.4, zorder=0)
	ax.axhspan(keff_threshold, y_max, color='lightyellow', alpha=0.4, zorder=0)


def annotate_highlighted_points(ax, df_points, cr_threshold, keff_threshold):
	if df_points.empty:
		return

	highlight = df_points[get_highlight_mask(df_points, cr_threshold, keff_threshold)]
	if highlight.empty:
		return

	offsets = [(6, 6), (6, -12), (-22, 6), (-22, -12), (8, 14), (-28, 14)]
	for idx, (_, row) in enumerate(highlight.iterrows()):
		dx, dy = offsets[idx % len(offsets)]
		label = f"step{int(row['BURN_STEP'])}"
		ax.annotate(
			label,
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


def write_summary_file(summary_path, rows):
	summary_path.parent.mkdir(parents=True, exist_ok=True)
	with open(summary_path, 'w', encoding='utf-8') as handle:
		handle.write('Highlight rule: conversion_ratio > 1.0 or ANA_KEFF > 0.9\n')
		handle.write('case,BURN_STEP,conversion_ratio,ANA_KEFF,trigger\n')
		for row in rows:
			handle.write(
				f"{row['case']},{row['BURN_STEP']},"
				f"{row['conversion_ratio']:.6g},{row['ANA_KEFF']:.6g},{row['trigger']}\n"
			)


class Tee:
	def __init__(self, *streams):
		self.streams = streams

	def write(self, data):
		for stream in self.streams:
			stream.write(data)
			stream.flush()

	def flush(self):
		for stream in self.streams:
			stream.flush()


def plot_case_cr_keff(df_case, case_name, outdir, cr_threshold, keff_threshold):
	df_plot = df_case[['case', 'BURN_STEP', 'conversion_ratio', 'ANA_KEFF']].dropna().copy()
	if df_plot.empty:
		return []

	df_plot = df_plot.sort_values('BURN_STEP')
	df_plot['highlight'] = get_highlight_mask(df_plot, cr_threshold, keff_threshold)
	highlight_rows = df_plot[df_plot['highlight']].copy()

	x_min = min(df_plot['conversion_ratio'].min(), cr_threshold)
	x_max = max(df_plot['conversion_ratio'].max(), cr_threshold) + 0.05
	y_min = min(df_plot['ANA_KEFF'].min(), keff_threshold)
	y_max = max(df_plot['ANA_KEFF'].max(), keff_threshold) + 0.02

	fig, ax = plt.subplots(figsize=(10, 7))

	if len(df_plot) > 1:
		ax.plot(df_plot['conversion_ratio'], df_plot['ANA_KEFF'], '-', color='0.75', linewidth=1.0, zorder=1)

	burnup_values = df_plot['BURN_STEP'].to_numpy(dtype=float)
	if len(np.unique(burnup_values)) > 1:
		norm = plt.Normalize(vmin=float(burnup_values.min()), vmax=float(burnup_values.max()))
		cmap = plt.cm.viridis
		colors = cmap(norm(burnup_values))
		scatter = ax.scatter(
			df_plot['conversion_ratio'],
			df_plot['ANA_KEFF'],
			c=burnup_values,
			cmap='viridis',
			s=70,
			edgecolors='black',
			linewidths=0.5,
			zorder=3,
		)
		cbar = plt.colorbar(scatter, ax=ax)
		cbar.set_label('BURN_STEP', fontsize=11)
	else:
		ax.scatter(
			df_plot['conversion_ratio'],
			df_plot['ANA_KEFF'],
			c='steelblue',
			s=70,
			edgecolors='black',
			linewidths=0.5,
			zorder=3,
		)

	ax.set_xlim(x_min - 0.01, x_max)
	ax.set_ylim(y_min - 0.03, y_max)
	add_highlight_regions(ax, cr_threshold, keff_threshold, x_max, y_max)
	annotate_highlighted_points(ax, df_plot[df_plot['highlight']], cr_threshold, keff_threshold)

	ax.set_xlabel('Conversion Ratio', fontsize=13)
	ax.set_ylabel('Keff', fontsize=13)
	ax.set_title(f'{case_name}: CR vs Keff by Burnup', fontsize=14)
	ax.grid(True, alpha=0.3)

	plt.tight_layout()
	out_path = Path(outdir) / f'{sanitize_case_label(case_name)}_cr_keff.png'
	plt.savefig(out_path, dpi=150, bbox_inches='tight')
	plt.close()

	print(f'  {out_path.name}')

	rows = []
	for _, row in highlight_rows.iterrows():
		trigger = []
		if row['conversion_ratio'] > cr_threshold:
			trigger.append('CR')
		if row['ANA_KEFF'] > keff_threshold:
			trigger.append('Keff')
		rows.append({
			'case': case_name,
			'BURN_STEP': int(row['BURN_STEP']),
			'conversion_ratio': float(row['conversion_ratio']),
			'ANA_KEFF': float(row['ANA_KEFF']),
			'trigger': '|'.join(trigger),
		})

	return rows


def plot_all_cases(df, groups, out_dir, summary_path, cr_threshold, keff_threshold):
	summary_rows = []
	group_output_dirs = get_group_output_dirs(out_dir)

	for letter in ['A', 'B', 'C', 'D']:
		case_list = groups.get(letter, [])
		if not case_list:
			continue

		group_dir = group_output_dirs[letter]
		group_dir.mkdir(parents=True, exist_ok=True)

		print(f'\n--- Group {letter} ({len(case_list)} cases) ---')
		for idx, case_name in enumerate(case_list):
			df_case = df[df['case'] == case_name].sort_values('BURN_STEP')
			if df_case.empty:
				continue
			summary_rows.extend(
				plot_case_cr_keff(
					df_case,
					case_name,
					group_dir,
					cr_threshold,
					keff_threshold,
				)
			)

	write_summary_file(summary_path, summary_rows)
	return summary_rows


def main():
	import argparse

	parser = argparse.ArgumentParser(description='Generate per-case CR vs Keff plots grouped by case letter.')
	parser.add_argument('--csv', '-c', default=str(CSV_PATH), help='Path to the processed CSV data file')
	parser.add_argument('--out', '-o', default=str(OUTPUT_DIR), help='Output directory for CR+KEFF plots')
	parser.add_argument('--summary', default=str(SUMMARY_PATH), help='Summary file for highlighted points')
	parser.add_argument('--cr-threshold', type=float, default=DEFAULT_CR_THRESHOLD,
						help='CR threshold for highlight rule')
	parser.add_argument('--keff-threshold', type=float, default=DEFAULT_KEFF_THRESHOLD,
						help='Keff threshold for highlight rule')
	parser.add_argument('--no-clean', action='store_true', help='Skip cleanup of old CR+KEFF images')
	args = parser.parse_args()

	summary_path = Path(args.summary)

	out_dir = Path(args.out)
	out_dir.mkdir(parents=True, exist_ok=True)
	for path in get_group_output_dirs(out_dir).values():
		path.mkdir(parents=True, exist_ok=True)

	ts = datetime.now().strftime('%Y%m%d_%H%M%S')
	log_dir = BASE_DIR / 'analysis' / 'V1' / 'log'
	log_dir.mkdir(parents=True, exist_ok=True)
	log_path = log_dir / f'cr_keff_{ts}.log'

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

			print('\n=== Generating per-case CR vs Keff plots ===')
			summary_rows = plot_all_cases(df, groups, out_dir, summary_path, args.cr_threshold, args.keff_threshold)

			print('\n=== All outputs generated ===')
			print(f'  Output directory: {out_dir}')
			print(f'  Summary file: {summary_path}')
			print(f'  Highlighted points: {len(summary_rows)}')

		finally:
			sys.stdout = orig_stdout
			sys.stderr = orig_stderr


if __name__ == '__main__':
	main()
