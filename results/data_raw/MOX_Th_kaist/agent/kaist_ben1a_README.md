# KAIST Benchmark Problem 1A — Serpent 2 Input

**Source**: N. Z. Cho, "Benchmark Problem 1A: MOX Fuel-Loaded Small PWR Core
(MOX Fuel with Zoning)", KAIST/NurapT, June 23, 2000.
Original URL: <http://nurapt.kaist.ac.kr/benchmark/>
(archive: <https://github.com/nzcho/Nurapt-Archives>)

## Problem statement

Calculate the effective multiplication factor  *k*<sub>eff</sub>  and the
assembly / pin power distribution of a small PWR core partially loaded
with MOX fuel.  Two cases are defined in the benchmark:

* **Case 1 (ARI)** — all control rods IN :  every one of the 24
  control-rod guide tubes in every fuel assembly contains a B4C
  absorber rod.
* **Case 2 (ARO)** — all control rods OUT :  the guide tubes are
  water-filled; the B4C rods are completely withdrawn from the
  active core.

The default deck is set up for the **ARO** case (`pin guide_tube` is
used in the assembly lattice).  To switch to ARI, replace every
`guide_tube` token in the assembly lattice declarations with
`ctrl_rod` (a single `sed` command does this — see §"How to run"
below).

## Geometry

### Fuel rod

| Item                       | Value              |
|----------------------------|--------------------|
| Fuel pellet outer radius   | 0.4095 cm          |
| Fuel-clad gap outer radius | 0.4180 cm          |
| Cladding outer radius      | 0.4750 cm          |
| Pin pitch                  | 1.26 cm            |

### Fuel assembly (17 × 17)

| Item                                | Value              |
|-------------------------------------|--------------------|
| Lattice                             | 17 × 17            |
| Assembly pitch                      | 21.42 cm           |
| Number of fuel pins                 | 264                |
| Number of CR guide tubes            | 24                 |
| Number of instrument tubes          | 1                  |
| Active fuel length                  | 365.76 cm          |
| Fuel density (UOX, MOX)             | 10.4 g/cm³         |

### Control-rod and instrument-tube dimensions

| Component                  | Inner radius | Outer radius | Material inside       |
|----------------------------|--------------|--------------|-----------------------|
| Instrumentation guide tube | 0.5715 cm    | 0.6120 cm    | H₂O                   |
| Control rod (B₄C)          | 0.3823 cm    | 0.4839 cm    | B₄C (1.84 g/cm³)      |
| Control-rod inner cladding | 0.4839 cm    | 0.5715 cm    | H₂O                   |
| Guide tube                 | 0.5715 cm    | 0.6120 cm    | H₂O                   |

## Material compositions

### Fuel

| Assembly type | Specification |
|---------------|----------------|
| **UOX-1**     | UO₂ with U-235 = 2.0 w/o (U-238 balance) |
| **UOX-2**     | UO₂ with U-235 = 3.3 w/o (U-238 balance) |
| **MOX-1**     | (U,Pu)O₂ with three Pu-enrichment zones:  <br> • Peripheral:  Pu-tot = 4.3 w/o  <br> • Intermediate: Pu-tot = 7.0 w/o  <br> • Central:     Pu-tot = 8.7 w/o  <br> • U-235 in the U matrix = 0.225 w/o |
| **Pu vector** (relative to total Pu, all zones) | Pu-238 / 239 / 240 / 241 / 242 / Am-241  =  1.83 / 57.93 / 22.50 / 11.06 / 5.60 / 1.08 w/o  <br>Derived from UO₂ PWR fuel of 33 000 MWd/t burnup, 3-yr cooling, 2-yr storage. |

### Burnable absorber (assembly option)

(U,Gd)O₂ :
* U-235 = 0.711 w/o (relative to U)
* Gd₂O₃ = 9.0 w/o (of the total)
* density = 10.06 g/cm³
* Natural-Gd isotopic vector (w/o) : Gd-152 0.1932, Gd-154 2.0555,
  Gd-155 14.5809, Gd-156 20.4259, Gd-157 15.6674, Gd-158 24.9061,
  Gd-160 22.1710.

### Other materials

| Material               | Composition (w/o)                                                | Density (g/cm³)                |
|------------------------|------------------------------------------------------------------|--------------------------------|
| Cladding (Zircaloy-4)  | Zr 97.91, Sn 1.59, Fe 0.5                                       | 6.44                           |
| Baffle (SS-304)        | Fe 70.351, Cr 19.152, Ni 8.483, Mn 2.014                         | 7.82                           |
| Gap                    | He at 320 psig, 700 K                                            | (ideal gas, ρ ≈ 4.8·10⁻⁴)      |
| Coolant / reflector    | H₂O                                                             | 1.0 at 300 K, 0.7295 at 570 K  |
| Soluble boron          | 800 ppm in coolant                                               |                                |
| Control rod            | B₄C, 1.84 g/cm³ (73 % of theoretical 2.52)                       |                                |

## Core layout (1/4 core)

The benchmark PDF specifies a 1/4-symmetric core.  The 1/4 core
consists of **13 fuel assemblies** in a 4 × 4 quadrant (with three
diagonal-corner cells empty), surrounded by a single row of reflector
assemblies.  Five distinct fuel-assembly universes are used:

* **MOX-1** (`asy_mox1z`)            — placed in the inner part of the 1/4
  core (positions adjacent to the core diagonal).  Each MOX-1
  assembly has three radial Pu-enrichment zones.
* **MOX-1 (BA₈)** (`asy_mox1z_ba8`) — MOX-1 with 8 Gd₂O₃ BA rods.
* **UOX-2** (`asy_uox2`)            — intermediate enrichment (3.3 w/o
  U-235).  Placed between the MOX-1 and the UOX-1 ring.  The (CR)
  assemblies in the PDF figure are all UOX-2.
* **UOX-2 (BA₁₆)** (`asy_uox2gd`)   — UOX-2 with 16 Gd₂O₃ BA rods.
* **UOX-1** (`asy_uox1`)            — lowest enrichment (2.0 w/o
  U-235).  Placed in the outermost ring of the fueled region.

The 1/4-core lattice used in the input deck (rows 0..3 outermost to
innermost, columns 0..3 outermost to innermost):

```
i\j   0           1             2          3
 0    asy_uox1    asy_uox1      0          0
 1    asy_mox1z   asy_uox2      asy_uox1   0
 2    asy_uox2    asy_mox1z_ba8 asy_uox2   asy_uox1
 3    asy_uox2gd  asy_uox2      asy_mox1z  asy_uox1
```

`-` / `0` (universe `0`) marks cells outside the fueled 1/4 core.

> **Note on the core-layout interpretation.**  The original KAIST
> 1A PDF labels each assembly in the 1/4 map with a glyph that
> does not survive standard PDF-to-text extraction.  The loading
> pattern above was recovered by (a) layout-mode text extraction
> that yields the 13-position (2+3+4+4 entries, with three
> positions for the reflector) and (b) physical reasoning that
> matches the PWR convention (outer ring UOX-1, intermediate
> UOX-2, inner part MOX-1, with the "no fresh MOX on the core
> periphery" guideline satisfied).

## Operating conditions

| Quantity                            | Value    |
|-------------------------------------|----------|
| Total thermal power of the core     | 900 MWth |
| Coolant (water) average temperature | 570 K    |
| Cladding average temperature        | 630 K    |
| Fuel average temperature            | 900 K    |
| Coolant density at 570 K            | 0.7295 g/cm³ |
| Soluble boron (uniform in coolant)  | 800 ppm  |

## Files in this directory

| File                          | Description                                          |
|-------------------------------|------------------------------------------------------|
| `kaist_ben1a.ssp`             | Serpent 2 input deck (this work)                     |
| `kaist_ben1a_materials.txt`   | Computed isotopic number densities (atoms / barn-cm) |
| `core_layout_1to4.txt`        | 1/4 core map in plain text                           |
| `cross_reference.md`          | PDF原文对照解读 / cross-reference to PDF sections   |
| `kaist_ben1a_README.md`       | This document                                        |

## How to run

```bash
# ARO case (default)
sss2 -omp 8 kaist_ben1a.ssp

# ARI case :  replace guide_tube -> ctrl_rod
sed 's/guide_tube/ctrl_rod/g' kaist_ben1a.ssp > kaist_ben1a_ari.ssp
sss2 -omp 8 kaist_ben1a_ari.ssp
```

Replace `sss_endfb7.xsdata` in the `set acelib` line with the
cross-section library actually available on your system
(e.g. `sss_endfb7.xsdata`, `sss_endfb8.xsdata`, `jeff33.xsdata`).

## Known limitations / TODOs

* The 1/4 core loading is a reasonable reconstruction from the
  layout-mode text extraction; the original KAIST PDF labels were
  glyph-encoded and could not be unambiguously decoded.  Verify
  against the original benchmark figure if available.
* The MOX-1 zoning is implemented as 3 × 3 central / 5 × 5
  intermediate / peripheral, with the central 3 × 3 of the assembly
  reduced to 8 fuel pins because the center of the 17 × 17 lattice
  is the instrument tube.  The exact zone boundaries in the KAIST
  figure may differ.
* The axial reflector and radial baffle are modelled as water and
  SS-304, respectively, with thicknesses inferred from the KAIST
  PDF figure (2.52 cm baffle + 18.9 cm reflector + 21.42 cm
  top/bottom reflector).
* No depletion is performed; this is a fresh-fuel eigenvalue run.
* The Gd-bearing burnable absorber is included as two separate
  assembly options (`asy_uox2gd` and `asy_mox1z_ba8`).
* The 1/4 core lattice is placed in a cell that occupies the
  +x, +y quadrant of the geometry, with reflective BC on the
  inner surfaces (x = 0, y = 0) provided by `set bc 1 1 2`.  The
  full core is automatically created by mirroring the 1/4 across
  the two symmetry planes.

Generated: 2026-06-12
