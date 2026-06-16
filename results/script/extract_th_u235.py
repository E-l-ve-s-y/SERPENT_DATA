"""Extract and tabulate Keff & CR for Th=0.3/0.6/0.9, U235=0.02/0.03/0.05 at BURN_STEP 0 and 25."""
import pandas as pd

df = pd.read_csv('data_processed/V1/data.csv', comment='#')

# Filter for target Th and U235 values
mask = df['Th_level'].isin([0.3, 0.6, 0.9]) & df['U235_enrichment'].isin([0.02, 0.03, 0.05])
filt = df[mask].copy()

# Take BURN_STEP 0 and 25
bs = filt[filt['BURN_STEP'].isin([0, 25])].copy()

# Sort: by Th_level, U235_enrichment, Pu_level, then case
bs = bs.sort_values(['Th_level', 'U235_enrichment', 'Pu_level', 'case', 'BURN_STEP'])

cols = ['case', 'Th_level', 'U235_enrichment', 'Pu_level', 'BURN_STEP',
        'EFPD', 'burnup_MWd_kgHM', 'ANA_KEFF', 'reactivity_pcm', 'conversion_ratio']
out = bs[cols].copy()
out['ANA_KEFF'] = out['ANA_KEFF'].round(5)
out['reactivity_pcm'] = out['reactivity_pcm'].round(1)
out['conversion_ratio'] = out['conversion_ratio'].round(5)
out['burnup_MWd_kgHM'] = out['burnup_MWd_kgHM'].round(2)

print('=' * 130)
print('ALL ROWS: cases matching filter at BURN_STEP 0 and 25')
print('=' * 130)
print(out.to_string(index=False))

# Pivot: rows = case, columns are (BURN_STEP, metric)
print()
print('=' * 130)
print('PIVOTED: per case, side-by-side BURN_STEP 0 vs 25 with deltas')
print('=' * 130)

pivot = bs.pivot_table(
    index=['case', 'Th_level', 'U235_enrichment', 'Pu_level'],
    columns='BURN_STEP',
    values=['EFPD', 'burnup_MWd_kgHM', 'ANA_KEFF', 'reactivity_pcm', 'conversion_ratio'],
    aggfunc='first'
)

# Flatten multi-index columns
pivot.columns = [f'{m}_BS{int(s)}' for m, s in pivot.columns]
pivot = pivot.reset_index()

# Add deltas
pivot['dKeff'] = (pivot['ANA_KEFF_BS25'] - pivot['ANA_KEFF_BS0']).round(5)
pivot['dCR'] = (pivot['conversion_ratio_BS25'] - pivot['conversion_ratio_BS0']).round(5)
pivot['dReactivity_pcm'] = (pivot['reactivity_pcm_BS25'] - pivot['reactivity_pcm_BS0']).round(1)

# Order columns
ordered = [
    'case', 'Th_level', 'U235_enrichment', 'Pu_level',
    'EFPD_BS0', 'EFPD_BS25', 'burnup_MWd_kgHM_BS0', 'burnup_MWd_kgHM_BS25',
    'ANA_KEFF_BS0', 'ANA_KEFF_BS25', 'dKeff',
    'reactivity_pcm_BS0', 'reactivity_pcm_BS25', 'dReactivity_pcm',
    'conversion_ratio_BS0', 'conversion_ratio_BS25', 'dCR',
]
pivot = pivot[ordered]
print(pivot.to_string(index=False))

# Group by Th_level
print()
print('=' * 130)
print('GROUPED BY Th_level (mean values per U235 enrichment)')
print('=' * 130)
for th in [0.3, 0.6, 0.9]:
    sub = pivot[pivot['Th_level'] == th]
    print(f'\n--- Th = {th} ---')
    g = sub.groupby('U235_enrichment').agg(
        n_cases=('case', 'count'),
        Keff_BS0=('ANA_KEFF_BS0', 'mean'),
        Keff_BS25=('ANA_KEFF_BS25', 'mean'),
        dKeff=('dKeff', 'mean'),
        CR_BS0=('conversion_ratio_BS0', 'mean'),
        CR_BS25=('conversion_ratio_BS25', 'mean'),
        dCR=('dCR', 'mean'),
    ).round(5)
    print(g.to_string())

# Save to CSV
pivot.to_csv('script/extract_th_u235_results.csv', index=False)
print()
print('Saved to: script/extract_th_u235_results.csv')
