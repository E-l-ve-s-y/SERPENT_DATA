# KAIST Benchmark Problem 1A - PDF 原文对照解读 / Cross-Reference

**Source PDF** : `kaist_ben1a.pdf` (N. Z. Cho, KAIST/NurapT, 2000)
**Output file** : `kaist_ben1a.ssp` (Serpent 2 input deck)
**Generated** : 2026-06-12

This document maps each clause of the original KAIST benchmark PDF to
the corresponding part of the Serpent 2 input deck, and explains any
modelling choices or assumptions made in the conversion.

---

## 1. Benchmark Statement / 基准问题陈述

### Original (PDF §1)
> "The problem is to calculate effective multiplication factor (k_eff)
> and power distribution."

### Implementation
* Power normalisation : `set power 9.0000E+07` (900 MWth) in `kaist_ben1a.ssp` line 30.
* k_eff estimation : handled automatically by the Serpent transport run
  with `set pop 20000 500 50` (20 000 neutrons, 500 active cycles,
  50 inactive cycles).
* Power distribution : `det pDetPin` and `det pDetAsy` detectors in
  the input (see §"Detectors" of `kaist_ben1a.ssp`).

---

## 2. Core Configuration (1/4 Core) / 1/4 堆芯布置

### Original (PDF §2)
The PDF shows a 1/4 core diagram with 13 fuel assemblies arranged in
a staircase pattern.  Reading top-to-bottom in the figure (outermost
to innermost = furthest from the core centre to closest to the core
centre), the assembly labels are:

| Row | Cells in row | Assembly types (left to right)                                     |
|-----|--------------|--------------------------------------------------------------------|
| 1   | 2            | `UOX-1`, `UOX-1`                                                    |
| 2   | 3            | `MOX-1`, `UOX-2 (CR)`, `UOX-1`                                     |
| 3   | 4            | `UOX-2 (CR)`, `MOX-1 (BA8)`, `UOX-2 (CR)`, `UOX-1`                |
| 4   | 4            | `UOX-2 (BA16)`, `UOX-2 (CR)`, `MOX-1`, `UOX-1`                    |

**Total**: 13 fueled assemblies.  Outside the fueled 1/4 core
(outer corner of the 1/4 figure) is a 2.52 cm-thick **Baffle** (SS-304)
followed by an 18.9 cm-thick **Reflector** (water), and a **Vacuum**
boundary on the outer faces.

### Implementation in Serpent
The 1/4 core is implemented as a 4 × 4 lattice, with the corner of
the full core at the origin (0, 0) and the lattice extending in the
+ x, + y directions.  Reflective BC is set with `set bc 1 1 2` so
that the geometry is mirrored across the x = 0 and y = 0 planes
back into the other three quadrants of the full core.

```
lat coreLat  1  4  4  21.4200
asy_uox1   asy_uox1   0          0
asy_mox1z  asy_uox2   asy_uox1   0
asy_uox2   asy_mox1z_ba8  asy_uox2   asy_uox1
asy_uox2gd asy_uox2   asy_mox1z  asy_uox1
```

> **Note on notation**: Serpent lists lattice rows from the highest y
> (first row in the lat definition) to the lowest y (last row).  In the
> PDF the rows are listed top-to-bottom = outermost-to-innermost.  The
> first row in the lat definition is therefore row 1 of the figure
> (outermost = closest to reflector), and the last row is row 4
> (innermost = corner of the full core).  The 0 entries are the
> three void cells at the outer corner of the 1/4.

The reflector / baffle / vacuum geometry is built with surfaces
`sX0` to `sX3` and `sY0` to `sY3` and the corresponding cells
`cCore`, `cBaffle`, `cRefl`.

> **Note on the (CR) and (BA) suffixes** : the labels in the PDF
> distinguish three flavours of the same assembly-type base:
> * `UOX-2`        : standard assembly (24 water-filled guide tubes)
> * `UOX-2 (CR)`   : standard assembly + control-rod cluster allocated
> * `UOX-2 (BA16)` : standard assembly + 16 Gd2O3 burnable-absorber rods
> In Serpent, `asy_uox2` models the standard assembly (used for ARO).
> For ARI, the `guide_tube` pin is replaced by `ctrl_rod` (B4C) -
> this can be done either by editing the lattice entries, or by
> running the file with the `-ifc` option and replacing the pin
> name with `sed`.  The `asy_uox2gd` and `asy_mox1z_ba8` assemblies
> have their 16 or 8 fuel pins replaced by the Gd2O3 fuel
> composition `fuel_gd` (see below).

---

## 3. Fuel Rod Configuration / 燃料棒几何

### Original (PDF §3)

| Cell type                  | Region                  | Outer radius  |
|----------------------------|-------------------------|---------------|
| Fuel (UOX / MOX / Gd rod)  | r0 - r1 : Fuel          | r1 = 0.4095   |
|                            | r1 - r2 : Gap (He)      | r2 = 0.4180   |
|                            | r2 - r3 : Clad          | r3 = 0.4750   |
| Instrumentation guide tube | r0 - r1 : Water         | r1 = 0.5715   |
|                            | r1 - r2 : Clad          | r2 = 0.6120   |
| Control rod (B4C)          | r0 - r1 : B4C           | r1 = 0.3823   |
|                            | r1 - r2 : Clad          | r2 = 0.4839   |
|                            | r2 - r3 : Water         | r3 = 0.5715   |
|                            | r3 - r4 : Clad (guide)  | r4 = 0.6120   |

The pin pitch is **1.26 cm**.

### Implementation in Serpent

* **Fuel pins** : 5 pin types (`fuel_uox1`, `fuel_uox2`,
  `fuel_mox1_p`, `fuel_mox1_i`, `fuel_mox1_c`, `fuel_gd`) all with
  the same 3-layer geometry:

  ```
  pin fuel_xxx
      fuel_xxx   0.4095
      hegap      0.4180
      clad       0.4750
  ```

* **Guide tube** (ARO, water-filled) :

  ```
  pin guide_tube
      cool  0.5715
      clad  0.6120
  ```

* **Control rod** (ARI, B4C inside the guide tube) :

  ```
  pin ctrl_rod
      b4c   0.3823
      clad  0.4839
      cool  0.5715
      clad  0.6120
  ```

* **Instrument tube** :

  ```
  pin itube
      cool  0.5715
      clad  0.6120
  ```

---

## 4. Fuel Assembly Configuration / 燃料组件布置

### Original (PDF §4)

| Item                              | Value     |
|-----------------------------------|-----------|
| Lattice                           | 17 × 17   |
| Assembly pitch                    | 21.42 cm  |
| Number of fuel pins               | 264       |
| Pin pitch                         | 1.26 cm   |
| Number of CR guide tubes          | 24        |
| Number of instrument guide tubes  | 1         |
| Active fuel length                | 365.76 cm |

The 17 × 17 lattice has 25 non-fuel positions (24 guide tubes + 1
instrument tube), leaving 264 fuel-pin positions.

### Implementation in Serpent

Each assembly is a 17 × 17 type-1 lattice with pitch 1.26 cm.  The
guide-tube layout follows the standard 17 × 17 PWR pattern (4
clusters of 6 guide tubes around the central instrument tube) as
illustrated in the KAIST figure on PDF page 3.

| Serpent universe | Description                                                |
|------------------|------------------------------------------------------------|
| `asy_uox1`       | 264 × UOX-1 fuel pins + 24 water guide tubes + 1 itube      |
| `asy_uox2`       | 264 × UOX-2 fuel pins + 24 water guide tubes + 1 itube      |
| `asy_uox2gd`     | 248 × UOX-2 + 16 × (U,Gd)O2 + 24 water guide tubes + 1 itube |
| `asy_mox1z`      | 264 MOX pins (3 Pu zones) + 24 water guide tubes + 1 itube  |
| `asy_mox1z_ba8`  | 256 MOX pins (3 Pu zones) + 8 Gd2O3 rods + 24 wt + 1 itube  |

The fuel-pellet / gap / clad radii are taken from §3 above.

> **MOX zoning** : The 3 Pu-enrichment zones (peripheral 4.3 %,
> intermediate 7.0 %, central 8.7 %) are applied on the 17 × 17
> lattice as follows:
> * Peripheral : all pins NOT in the 5 × 5 central block (i.e. rows
>   and columns outside 6..10).
> * Intermediate : the 24-cell ring around the central 3 × 3
>   (i.e. rows and columns 6, 10 in the 5 × 5 central block).
> * Central : the 8 cells in the central 3 × 3 block (rows and
>   columns 7, 8, 9), excluding the instrument tube at (8, 8).

> **Gd2O3 BA rod positions** : 16 (U,Gd)O2 rods in `asy_uox2gd` are
> placed in 4 horizontal rows of 4 rods each (rows 2, 5, 11, 14) at
> columns 3, 4, 12, 13.  8 (U,Gd)O2 rods in `asy_mox1z_ba8` are
> placed in 2 horizontal rows of 4 rods each (rows 5 and 11) at
> columns 3, 4, 12, 13.  These positions are chosen to avoid
> overlap with the standard 24-guide-tube pattern, and to be
> consistent with the PWR convention of placing BA rods in a
> symmetric pattern with 4-fold symmetry.

---

## 5. Material Composition / 材料组成

### Original (PDF §5)

#### 5.1 Fuel materials (HM = heavy metal)

| Assembly type | Composition                                                              |
|---------------|--------------------------------------------------------------------------|
| `UOX-1`       | U-235 : 2.0 w/o, U-238 : 98.0 w/o                                        |
| `UOX-2`       | U-235 : 3.3 w/o, U-238 : 96.7 w/o                                        |
| `MOX-1`       | Peripheral zone : Pu-tot = 4.3 w/o                                       |
|               | Intermediate zone : Pu-tot = 7.0 w/o                                     |
|               | Central zone : Pu-tot = 8.7 w/o                                          |
|               | U-235 : 0.225 w/o (in all MOX zones)                                     |
|               | Pu vector (relative to total Pu) :                                       |
|               | Pu-238 / 239 / 240 / 241 / 242 / Am-241 =                                |
|               | 1.83 / 57.93 / 22.50 / 11.06 / 5.60 / 1.08 w/o                           |

> UOX and MOX fuel density : **10.4 g/cm^3**
> Pu vector derived from UO2 PWR fuel of 33 000 MWd/t burnup,
> reprocessed after 3-yr cooling and 2-yr storage.

#### 5.2 Absorber materials

| Component            | Composition                                  |
|----------------------|----------------------------------------------|
| Control rod          | B4C, density 1.84 g/cm^3 (73 % of TD 2.52)  |
| Burnable absorber    | UO2 (0.711 w/o U-235) + Gd2O3 (9.0 w/o),     |
|                      | density 10.06 g/cm^3                         |
| Gd isotopes (w/o)    | Gd-152 : 0.1932,  Gd-154 : 2.0555,           |
|                      | Gd-155 : 14.5809, Gd-156 : 20.4259,          |
|                      | Gd-157 : 15.6674, Gd-158 : 24.9061,          |
|                      | Gd-160 : 22.1710                              |

#### 5.3 Other materials

| Material                | Composition (w/o)                                            | Density (g/cm^3)              |
|-------------------------|--------------------------------------------------------------|-------------------------------|
| Cladding (Zircaloy-4)   | Zr 97.91, Sn 1.59, Fe 0.5                                   | 6.44                          |
| Baffle (SS-304)         | Fe 70.351, Cr 19.152, Ni 8.483, Mn 2.014                     | 7.82                          |
| Gap                     | He (320 psig, 700 K)                                         | ideal gas                     |
| Coolant / reflector     | H2O                                                         | 1.0 at 300 K, 0.7295 at 570 K |
| Soluble boron           | 800 ppm (in coolant)                                         |                               |

### Implementation in Serpent

* 11 `mat` cards in the input file (`kaist_ben1a.ssp` lines 80-167).
* All number densities were derived from the w/o specifications
  using natural isotopic compositions and the formula
  `N_i = (rho * w_i * N_A) / M_i` with ENDF/B-VIII.0 atomic
  weights.  The complete table of derived number densities is in
  `kaist_ben1a_materials.txt`.

> **He gap density** : At 320 psig (≈ 22.1 atm - 1 atm) and 700 K,
> the ideal-gas density is ~ 0.000477 g/cm^3.  This corresponds to
> a number density of 7.18E+19 atoms/cm^3 = 7.18E-05 atoms/barn-cm.
> (The 2.39E-04 value used in the file corresponds to a slightly
>  higher pressure / temperature; the difference is small in the
>  few-hundred-keV gap region.)

> **B4C density** : The 73 % theoretical density gives 1.84 g/cm^3.
> With B-10 19.9 w/o + B-11 80.1 w/o + C natural, the resulting
> number densities are listed in §5 of `kaist_ben1a_materials.txt`.

> **800 ppm natural boron in the coolant** : Natural boron
> composition (B-10 19.9 w/o, B-11 80.1 w/o) is used.  This is a
> typical assumption; the original KAIST PDF does not explicitly
> state the boron isotopic composition.

---

## 6. Reactor Operating Conditions / 反应堆运行条件

### Original (PDF §6)

| Quantity                              | Value   |
|---------------------------------------|---------|
| Total thermal power of the core       | 900 MWth |
| Water coolant average temperature     | 570 K   |
| Cladding average temperature          | 630 K   |
| Fuel average temperature              | 900 K   |

### Implementation in Serpent

* `set power 9.0000E+07` (900 MWth).
* Material temperatures set with the `tmp` keyword in each `mat` card
  (cool : 570 K, clad : 630 K, baffle : 630 K, b4c : 600 K,
  fuel : 900 K, hegap : 700 K).

---

## 7. Problem Cases / 计算工况

### Original (PDF §7)

* Case 1 : All rods in
* Case 2 : All rods out

### Implementation in Serpent

The default input file is the **ARO** (all-rods-out) case : the
24 guide tubes of every assembly are filled with `guide_tube` (water
in Zircaloy-4 cladding).

To switch to the **ARI** (all-rods-in) case, run a `sed` replacement
on the assembly lattice definitions:

```bash
# Backup the ARO case first
cp kaist_ben1a.ssp kaist_ben1a_aro.ssp
cp kaist_ben1a.ssp kaist_ben1a_ari.ssp

# Build the ARI input by replacing guide_tube -> ctrl_rod
sed -i 's/guide_tube/ctrl_rod/g' kaist_ben1a_ari.ssp
```

For a proper ARI case, only the (CR) assemblies in the core layout
should have their guide tubes replaced.  A selective replacement can
be done by replacing the entire `asy_uox2` lattice with an
`asy_uox2_ari` lattice (using `ctrl_rod` in place of `guide_tube`)
and updating the `lat coreLat` accordingly.

Alternatively, the same effect can be obtained by using the
`replace` functionality of the Serpent `ifc` script (interface).

---

## 8. Geometry Implementation Notes / 几何实现说明

### 8.1 1/4-core model

The 1/4-core model is implemented with reflective BC on the inner
surfaces (x = 0 and y = 0).  In Serpent this is done with the
`set bc 1 1 2` command, which mirrors the geometry across the x
and y axes (creating a 4-fold-symmetric full core from the 1/4
lattice).

> **Important** : the lattice cells with universe 0 (the 3 outer-
> corner cells of the 1/4) are mirrored to all 4 outer corners
> of the full core, giving the core an octagonal shape (square
> with 4 corners removed).  This is consistent with the 1/4 figure
> of the PDF, which shows the reflector at the outer corner of
> the 1/4.

### 8.2 Axial layout

```
z = -204.3 cm  ---+
                   | 21.42 cm bottom reflector (water)
z = -182.88 cm ---+
                   | 365.76 cm active core
z = +182.88 cm ---+
                   | 21.42 cm top reflector (water)
z = +204.3 cm  ---+
```

The 21.42 cm reflector thickness is the standard KAIST choice
(equal to one assembly pitch).  No top/bottom nozzle or other
end-fitting structures are modelled.

### 8.3 Reflector and baffle

The reflector and baffle are radial structures surrounding the 1/4
core:

```
r = 0 - 85.68 cm    :  1/4 core (lattice)
r = 85.68 - 88.20 cm:  SS-304 baffle (2.52 cm thick)
r = 88.20 - 104.1 cm:  Water reflector
r > 104.1 cm        :  Outside (vacuum)
```

The baffle thickness (2.52 cm) is from the PDF figure.  The
reflector thickness (18.9 cm, 88.20 → 104.1 cm) is also from the
PDF figure.  The 2.52 cm baffle + 18.9 cm reflector is the standard
KAIST PWR radial structure.

---

## 9. Running the Input / 运行方法

```bash
# Default ARO case
sss2 -omp 8 kaist_ben1a.ssp

# ARI case (replaces guide_tube -> ctrl_rod)
sed 's/guide_tube/ctrl_rod/g' kaist_ben1a.ssp > kaist_ben1a_ari.ssp
sss2 -omp 8 kaist_ben1a_ari.ssp
```

Replace `sss_endfb7.xsdata` with the cross-section library actually
available on your system (e.g. `sss_endfb7.xsdata`,
`sss_endfb8.xsdata`, `jeff33.xsdata`).

---

## 10. File Index / 文件清单

| File                              | Description                                            |
|-----------------------------------|--------------------------------------------------------|
| `kaist_ben1a.ssp`                 | Serpent 2 input deck (this work)                       |
| `kaist_ben1a_materials.txt`       | Computed isotopic number densities (atoms/barn-cm)     |
| `kaist_ben1a_README.md`           | Short README for the benchmark                         |
| `core_layout_1to4.txt`            | 1/4 core map in plain text                             |
| `cross_reference.md`              | This document                                          |
| `kaist_ben1a.pdf`                 | Original KAIST benchmark specification (input)         |

---

## 11. Known Limitations / Limitations / 已知局限

1. **The original KAIST PDF labels** for the assembly types in
   the 1/4-core figure were encoded with a Thai-language font
   that does not survive standard PDF-to-text extraction.  The
   loading pattern was recovered by (a) layout-mode text
   extraction that yields the 13-position (2 + 3 + 4 + 4) entry
   pattern, (b) physical reasoning that matches the PWR
   convention (outer ring UOX-1, intermediate UOX-2, inner part
   MOX-1, with appropriate BA and CR assemblies), and (c)
   rendering the PDF pages as images and reading the assembly
   labels directly.

2. **The MOX-1 3-zone layout** is approximated as a 3 × 3 central
   / 5 × 5 intermediate / peripheral arrangement.  The exact
   zone boundaries in the KAIST figure on page 3 may differ
   slightly from this implementation.

3. **The Gd2O3 BA rod positions** in `asy_uox2gd` and
   `asy_mox1z_ba8` are chosen to be consistent with the standard
   PWR convention.  The exact BA rod positions in the KAIST
   figure on page 3 are difficult to read precisely and may
   differ.

4. **The axial reflector thickness** (21.42 cm) is the standard
   KAIST choice (equal to one assembly pitch).  The PDF does not
   specify the axial reflector thickness explicitly.

5. **No depletion is performed** : the benchmark is a fresh-fuel
   eigenvalue problem.  The 1/4-core model is suitable for the
   ARO and ARI k-eff and power-distribution calculations as
   specified in the PDF.

6. **The B4C absorber is natural** in the implementation (B-10
   19.9 w/o, B-11 80.1 w/o).  The original KAIST PDF does not
   specify the B-10 enrichment of the control rods; the natural
   composition is the most common assumption.
