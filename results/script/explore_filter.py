import pandas as pd

df = pd.read_csv('data_processed/V1/data.csv', comment='#')

# Filter for target Th and U235 values
mask = df['Th_level'].isin([0.3, 0.6, 0.9]) & df['U235_enrichment'].isin([0.02, 0.03, 0.05])
filt = df[mask]
print('Filtered rows:', len(filt))
print()

# Get unique case+param combinations (one row per case at BURN_STEP 0)
bs0 = filt[filt['BURN_STEP'] == 0]
case_summary = bs0[['case', 'Th_level', 'U235_enrichment', 'Pu_level']].sort_values(['Th_level', 'U235_enrichment', 'case'])
print('Cases in filter (from BURN_STEP 0):')
print(case_summary.to_string(index=False))
print()
print('Total unique cases:', case_summary['case'].nunique())
print('A cases:', sorted([c for c in case_summary['case'] if c.startswith('A')]))
print('B cases:', sorted([c for c in case_summary['case'] if c.startswith('B')]))
print('C cases:', sorted([c for c in case_summary['case'] if c.startswith('C')]))
print('D cases:', sorted([c for c in case_summary['case'] if c.startswith('D')]))
print()

# Group by (Th, U235) combo
combos = bs0.groupby(['Th_level', 'U235_enrichment'])['case'].apply(list)
for (th, u235), cases in combos.items():
    print(f'Th={th}, U235={u235}: {len(cases)} cases -> {cases}')
