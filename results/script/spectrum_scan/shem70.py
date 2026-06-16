#!/usr/bin/env python3
"""SHEM-70 group energy boundaries (Santamarina et al., CEA).

The 71 boundaries are stored in eV. In the Serpent ``ene e70g`` block the
same numbers appear in MeV, so we convert (multiply by 1e6) when emitting
them for plotting / analysis. Boundaries span 1e-5 eV to 1.964e7 eV (10
micro-eV to 19.64 MeV), 70 energy groups.

Region labels (REGION_LABELS) classify each group into 5 physical regions
of interest for Th-cycle analysis:
  - VT  : very thermal (E < 0.1 eV)        1/v dominance
  - T   : thermal       (0.1 - 1 eV)        above Maxwell peak
  - R   : resonance     (1 eV - 100 keV)   Th-232 23 eV + many resonances
  - F   : fast          (100 keV - 1 MeV)  slowing-down region
  - VF  : very fast     (1 MeV - 19.64 MeV) fission neutron source
"""

from __future__ import annotations

# SHEM-70 boundaries as emitted in the Serpent .sss input deck (MeV).
# Source:  results/data_raw/spectrum_scan/A008_d040/A008_d040.sss (lines 113-130)
_BOUNDARIES_MEV = [
    1.0000e-11, 5.0000e-11, 1.0000e-10, 2.0000e-10,
    5.0000e-10, 1.0000e-09, 2.0000e-09, 5.0000e-09,
    1.0000e-08, 2.0000e-08, 5.0000e-08, 1.0000e-07,
    2.0000e-07, 5.0000e-07, 1.0000e-06, 1.5000e-06,
    2.0000e-06, 2.5000e-06, 3.0000e-06, 4.0000e-06,
    5.0000e-06, 6.5000e-06, 8.0000e-06, 1.0000e-05,
    1.5000e-05, 2.0000e-05, 2.5000e-05, 3.0000e-05,
    3.6000e-05, 5.0000e-05, 6.6000e-05, 8.0000e-05,
    1.0000e-04, 1.5000e-04, 2.0000e-04, 3.0000e-04,
    4.0000e-04, 5.0000e-04, 6.5000e-04, 8.0000e-04,
    1.0000e-03, 1.5000e-03, 2.0000e-03, 3.0000e-03,
    4.0000e-03, 5.0000e-03, 6.5000e-03, 8.0000e-03,
    1.0000e-02, 1.5000e-02, 2.0000e-02, 3.0000e-02,
    5.0000e-02, 7.5000e-02, 1.0000e-01, 1.5000e-01,
    2.0000e-01, 3.0000e-01, 5.0000e-01, 7.5000e-01,
    1.0000e+00, 1.5000e+00, 2.0000e+00, 3.0000e+00,
    4.0000e+00, 5.0000e+00, 6.5000e+00, 8.0000e+00,
    1.0000e+01, 1.3000e+01, 1.9640e+01,
]

# Convert MeV -> eV for the analysis side.  1 MeV = 1e6 eV.
SHEM70_ENERGIES_EV: list[float] = [b * 1.0e6 for b in _BOUNDARIES_MEV]

# Region boundaries (in eV) used to assign REGION_LABELS:
#   VT :  E_hi <= 0.1 eV
#   T  :  0.1 eV  < E_hi <= 1 eV
#   R  :  1 eV    < E_hi <= 1e5 eV  (= 100 keV)
#   F  :  1e5 eV  < E_hi <= 1e6 eV  (= 1 MeV)
#   VF :  E_hi   >  1e6 eV
_REGION_BOUNDS_EV = [0.1, 1.0, 1.0e5, 1.0e6]
_REGION_LABELS = ["VT", "T", "R", "F", "VF"]


def _label_for_upper_edge(e_hi: float) -> str:
    for bound, label in zip(_REGION_BOUNDS_EV, _REGION_LABELS[:-1]):
        if e_hi <= bound:
            return label
    return _REGION_LABELS[-1]


# 70 entries:  REGION_LABELS[g-1] is the region of group g (1-indexed).
REGION_LABELS: list[str] = [
    _label_for_upper_edge(SHEM70_ENERGIES_EV[g])  # upper edge of group g
    for g in range(1, len(SHEM70_ENERGIES_EV))
]

# Lethargy widths (useful for plotting flux per unit lethargy).
import numpy as np  # noqa: E402

_LETHARGY = np.log(SHEM70_ENERGIES_EV)  # natural log
LETHARGY_WIDTHS: np.ndarray = np.abs(np.diff(_LETHARGY))  # length 70

# Region color map for plotting consistency.
REGION_COLORS: dict[str, str] = {
    "VT": "#7B1FA2",   # purple
    "T":  "#1976D2",   # blue
    "R":  "#388E3C",   # green
    "F":  "#F57C00",   # orange
    "VF": "#C62828",   # red
}


if __name__ == "__main__":
    # quick self-check
    assert len(SHEM70_ENERGIES_EV) == 71
    assert len(REGION_LABELS) == 70
    print(f"SHEM-70: 70 groups, "
          f"{SHEM70_ENERGIES_EV[0]:.2e} eV  ->  {SHEM70_ENERGIES_EV[-1]:.3e} eV")
    from collections import Counter
    print("Region counts:", dict(Counter(REGION_LABELS)))
