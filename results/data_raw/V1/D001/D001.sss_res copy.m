
% Increase counter:

if (exist('idx', 'var'));
  idx = idx + 1;
else;
  idx = 1;
end;

% Version, title and date:

VERSION                   (idx, [1:  13]) = 'Serpent 2.2.1' ;
COMPILE_DATE              (idx, [1:  20]) = 'Oct 19 2025 23:43:21' ;
DEBUG                     (idx, 1)        = 0 ;
TITLE                     (idx, [1:  59]) = 'D001_homo_Pu239+U235_Th0.700_Pu0.040_U2330.000_U235E0.02000' ;
CONFIDENTIAL_DATA         (idx, 1)        = 0 ;
INPUT_FILE_NAME           (idx, [1:  59]) = '/dssg/home/acct-sc_wang/lu_shiyi/work/results/D001/D001.sss' ;
WORKING_DIRECTORY         (idx, [1:  50]) = '/dssg/home/acct-sc_wang/lu_shiyi/work/results/D001' ;
HOSTNAME                  (idx, [1:  22]) = 'node394.pi.sjtu.edu.cn' ;
CPU_TYPE                  (idx, [1:  44]) = 'Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz' ;
CPU_MHZ                   (idx, 1)        = 218104848.0 ;
START_DATE                (idx, [1:  24]) = 'Wed Apr 29 14:21:36 2026' ;
COMPLETE_DATE             (idx, [1:  24]) = 'Wed Apr 29 14:40:19 2026' ;

% Run parameters:

POP                       (idx, 1)        = 200000 ;
CYCLES                    (idx, 1)        = 500 ;
SKIP                      (idx, 1)        = 20 ;
BATCH_INTERVAL            (idx, 1)        = 1 ;
SRC_NORM_MODE             (idx, 1)        = 2 ;
SEED                      (idx, 1)        = 1777443696418 ;
UFS_MODE                  (idx, 1)        = 0 ;
UFS_ORDER                 (idx, 1)        = 1.00000 ;
NEUTRON_TRANSPORT_MODE    (idx, 1)        = 1 ;
PHOTON_TRANSPORT_MODE     (idx, 1)        = 0 ;
GROUP_CONSTANT_GENERATION (idx, 1)        = 1 ;
B1_CALCULATION            (idx, [1:  3])  = [ 0 0 0 ] ;
B1_IMPLICIT_LEAKAGE       (idx, 1)        = 0 ;
B1_BURNUP_CORRECTION      (idx, 1)        = 0 ;

CRIT_SPEC_MODE            (idx, 1)        = 0 ;
IMPLICIT_REACTION_RATES   (idx, 1)        = 1 ;

% Optimization:

OPTIMIZATION_MODE         (idx, 1)        = 4 ;
RECONSTRUCT_MICROXS       (idx, 1)        = 1 ;
RECONSTRUCT_MACROXS       (idx, 1)        = 1 ;
DOUBLE_INDEXING           (idx, 1)        = 0 ;
MG_MAJORANT_MODE          (idx, 1)        = 0 ;
SPECTRUM_COLLAPSE         (idx, 1)        = 1 ;

% Parallelization:

MPI_TASKS                 (idx, 1)        = 1 ;
OMP_THREADS               (idx, 1)        = 33 ;
MPI_REPRODUCIBILITY       (idx, 1)        = 0 ;
OMP_REPRODUCIBILITY       (idx, 1)        = 1 ;
OMP_HISTORY_PROFILE       (idx, [1:  33]) = [  1.07288E+00  1.08650E+00  1.09001E+00  9.06850E-01  1.07810E+00  9.13394E-01  9.11280E-01  9.06897E-01  1.08552E+00  1.08324E+00  1.03158E+00  9.00171E-01  9.54620E-01  9.13537E-01  1.08900E+00  1.07948E+00  1.07637E+00  9.10429E-01  1.09432E+00  9.04324E-01  1.09136E+00  1.09088E+00  9.18874E-01  1.08718E+00  9.04697E-01  1.09106E+00  9.08299E-01  9.06209E-01  9.11434E-01  1.08799E+00  9.13084E-01  9.07810E-01  1.09264E+00  ];
SHARE_BUF_ARRAY           (idx, 1)        = 0 ;
SHARE_RES2_ARRAY          (idx, 1)        = 1 ;
OMP_SHARED_QUEUE_LIM      (idx, 1)        = 0 ;

% File paths:

XS_DATA_FILE_PATH         (idx, [1:  63]) = '/dssg/home/acct-sc_wang/lu_shiyi/data/endfb7/sss_endfb7u.xsdata' ;
DECAY_DATA_FILE_PATH      (idx, [1:  59]) = '/dssg/home/acct-sc_wang/lu_shiyi/data/endfb7/sss_endfb7.dec' ;
SFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
NFY_DATA_FILE_PATH        (idx, [1:  59]) = '/dssg/home/acct-sc_wang/lu_shiyi/data/endfb7/sss_endfb7.nfy' ;
BRA_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;

% Collision and reaction sampling (neutrons/photons):

MIN_MACROXS               (idx, [1:   4]) = [  5.00000E-02 1.7E-09  0.00000E+00 0.0E+00 ];
DT_THRESH                 (idx, [1:   2]) = [  9.00000E-01  9.00000E-01 ] ;
ST_FRAC                   (idx, [1:   4]) = [  2.64728E-02 0.00014  0.00000E+00 0.0E+00 ];
DT_FRAC                   (idx, [1:   4]) = [  9.73527E-01 3.8E-06  0.00000E+00 0.0E+00 ];
DT_EFF                    (idx, [1:   4]) = [  7.62572E-01 1.4E-05  0.00000E+00 0.0E+00 ];
REA_SAMPLING_EFF          (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
REA_SAMPLING_FAIL         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_COL_EFF               (idx, [1:   4]) = [  7.63135E-01 1.4E-05  0.00000E+00 0.0E+00 ];
AVG_TRACKING_LOOPS        (idx, [1:   8]) = [  2.89584E+00 5.9E-05  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
CELL_SEARCH_FRAC          (idx, [1:  10]) = [  9.08194E-01 9.3E-06  9.18028E-02 9.2E-05  3.50881E-06 0.00631  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
AVG_TRACKS                (idx, [1:   4]) = [  2.45472E+01 4.7E-05  0.00000E+00 0.0E+00 ];
AVG_REAL_COL              (idx, [1:   4]) = [  2.45472E+01 4.7E-05  0.00000E+00 0.0E+00 ];
AVG_VIRT_COL              (idx, [1:   4]) = [  7.61905E+00 7.0E-05  0.00000E+00 0.0E+00 ];
AVG_SURF_CROSS            (idx, [1:   4]) = [  2.64803E+00 9.5E-05  0.00000E+00 0.0E+00 ];
LOST_PARTICLES            (idx, 1)        = 0 ;

% Run statistics:

CYCLE_IDX                 (idx, 1)        = 500 ;
SIMULATED_HISTORIES       (idx, 1)        = 100001571 ;
MEAN_POP_SIZE             (idx, [1:   2]) = [  2.00003E+05 0.00015 ] ;
MEAN_POP_WGT              (idx, [1:   2]) = [  2.00003E+05 0.00015 ] ;
SIMULATION_COMPLETED      (idx, 1)        = 1 ;

% Running times:

TOT_CPU_TIME              (idx, 1)        =  4.53342E+02 ;
RUNNING_TIME              (idx, 1)        =  1.87189E+01 ;
INIT_TIME                 (idx, [1:   2]) = [  7.54283E-01  7.54283E-01 ] ;
PROCESS_TIME              (idx, [1:   2]) = [  8.85000E-03  8.85000E-03 ] ;
TRANSPORT_CYCLE_TIME      (idx, [1:   3]) = [  1.79556E+01  1.79556E+01  0.00000E+00 ] ;
BURNUP_CYCLE_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
BATEMAN_SOLUTION_TIME     (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
MPI_OVERHEAD_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
ESTIMATED_RUNNING_TIME    (idx, [1:   2]) = [  1.87173E+01  0.00000E+00 ] ;
CPU_USAGE                 (idx, 1)        = 24.21843 ;
TRANSPORT_CPU_USAGE       (idx, [1:   2]) = [  2.57926E+01 0.00532 ];
OMP_PARALLEL_FRAC         (idx, 1)        =  7.26805E-01 ;

% Memory usage:

AVAIL_MEM                 (idx, 1)        = 515110.43 ;
ALLOC_MEMSIZE             (idx, 1)        = 13250.86 ;
MEMSIZE                   (idx, 1)        = 12982.37 ;
XS_MEMSIZE                (idx, 1)        = 6854.70 ;
MAT_MEMSIZE               (idx, 1)        = 4767.36 ;
RES_MEMSIZE               (idx, 1)        = 24.37 ;
IFC_MEMSIZE               (idx, 1)        = 0.00 ;
MISC_MEMSIZE              (idx, 1)        = 1335.93 ;
UNKNOWN_MEMSIZE           (idx, 1)        = 0.00 ;
UNUSED_MEMSIZE            (idx, 1)        = 268.49 ;

% Geometry parameters:

TOT_CELLS                 (idx, 1)        = 4 ;
UNION_CELLS               (idx, 1)        = 0 ;

% Neutron energy grid:

NEUTRON_ERG_TOL           (idx, 1)        =  5.00000E-05 ;
NEUTRON_ERG_NE            (idx, 1)        = 282063 ;
NEUTRON_EMIN              (idx, 1)        =  1.00000E-11 ;
NEUTRON_EMAX              (idx, 1)        =  2.00000E+01 ;

% Unresolved resonance probability table sampling:

URES_DILU_CUT             (idx, 1)        =  1.00000E-09 ;
URES_EMIN                 (idx, 1)        =  1.00000E+37 ;
URES_EMAX                 (idx, 1)        = -1.00000E+37 ;
URES_AVAIL                (idx, 1)        = 229 ;
URES_USED                 (idx, 1)        = 0 ;

% Nuclides and reaction channels:

TOT_NUCLIDES              (idx, 1)        = 1366 ;
TOT_TRANSPORT_NUCLIDES    (idx, 1)        = 300 ;
TOT_DOSIMETRY_NUCLIDES    (idx, 1)        = 0 ;
TOT_DECAY_NUCLIDES        (idx, 1)        = 1066 ;
TOT_PHOTON_NUCLIDES       (idx, 1)        = 0 ;
TOT_REA_CHANNELS          (idx, 1)        = 8370 ;
TOT_TRANSMU_REA           (idx, 1)        = 2717 ;

% Neutron physics options:

USE_DELNU                 (idx, 1)        = 1 ;
USE_URES                  (idx, 1)        = 0 ;
USE_DBRC                  (idx, 1)        = 0 ;
IMPL_CAPT                 (idx, 1)        = 0 ;
IMPL_NXN                  (idx, 1)        = 1 ;
IMPL_FISS                 (idx, 1)        = 0 ;
DOPPLER_PREPROCESSOR      (idx, 1)        = 1 ;
TMS_MODE                  (idx, 1)        = 0 ;
SAMPLE_FISS               (idx, 1)        = 1 ;
SAMPLE_CAPT               (idx, 1)        = 1 ;
SAMPLE_SCATT              (idx, 1)        = 1 ;

% Energy deposition:

EDEP_MODE                 (idx, 1)        = 0 ;
EDEP_DELAYED              (idx, 1)        = 1 ;
EDEP_KEFF_CORR            (idx, 1)        = 1 ;
EDEP_LOCAL_EGD            (idx, 1)        = 0 ;
EDEP_COMP                 (idx, [1:   9]) = [ 0 0 0 0 0 0 0 0 0 ] ;
EDEP_CAPT_E               (idx, 1)        =  0.00000E+00 ;

% Radioactivity data:

TOT_ACTIVITY              (idx, 1)        =  1.12787E+11 ;
TOT_DECAY_HEAT            (idx, 1)        =  9.47110E-02 ;
TOT_SF_RATE               (idx, 1)        =  2.12013E+02 ;
ACTINIDE_ACTIVITY         (idx, 1)        =  1.12787E+11 ;
ACTINIDE_DECAY_HEAT       (idx, 1)        =  9.47110E-02 ;
FISSION_PRODUCT_ACTIVITY  (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_DECAY_HEAT(idx, 1)        =  0.00000E+00 ;
INHALATION_TOXICITY       (idx, 1)        =  1.35339E+07 ;
INGESTION_TOXICITY        (idx, 1)        =  2.81958E+04 ;
ACTINIDE_INH_TOX          (idx, 1)        =  1.35339E+07 ;
ACTINIDE_ING_TOX          (idx, 1)        =  2.81958E+04 ;
FISSION_PRODUCT_INH_TOX   (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ING_TOX   (idx, 1)        =  0.00000E+00 ;
SR90_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
TE132_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
I131_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
I132_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
CS134_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
CS137_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
PHOTON_DECAY_SOURCE       (idx, [1:   2]) = [  4.95011E+09  1.18082E-05 ] ;
NEUTRON_DECAY_SOURCE      (idx, 1)        =  0.00000E+00 ;
ALPHA_DECAY_SOURCE        (idx, 1)        =  1.12803E+11 ;
ELECTRON_DECAY_SOURCE     (idx, 1)        =  3.71925E+10 ;

% Normalization coefficient:

NORM_COEF                 (idx, [1:   4]) = [  1.44295E+10 8.5E-05  0.00000E+00 0.0E+00 ];

% Parameters for burnup calculation:

BURN_MATERIALS            (idx, 1)        = 264 ;
BURN_MODE                 (idx, 1)        = 2 ;
BURN_STEP                 (idx, 1)        = 0 ;
BURN_RANDOMIZE_DATA       (idx, [1:   3]) = [ 0 0 0 ] ;
BURNUP                    (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
BURN_DAYS                 (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
FIMA                      (idx, [1:   3]) = [  0.00000E+00  0.00000E+00  3.09488E+24 ] ;

% Analog reaction rate estimators:

CONVERSION_RATIO          (idx, [1:   2]) = [  3.60989E-01 0.00023 ];
TH232_FISS                (idx, [1:   4]) = [  1.45537E+13 0.00141  1.05869E-02   0.00140 ];
U235_FISS                 (idx, [1:   4]) = [  8.69304E+13 0.00060  6.32367E-02 0.00059 ];
U238_FISS                 (idx, [1:   4]) = [  2.20158E+13 0.00118  1.60151E-02 0.00116 ];
PU239_FISS                (idx, [1:   4]) = [  1.25118E+15 0.00012  9.10161E-01 4.8E-05 ];
TH232_CAPT                (idx, [1:   4]) = [  4.66158E+14 0.00027  3.07343E-01 0.00020 ];
U235_CAPT                 (idx, [1:   4]) = [  2.42876E+13 0.00110  1.60131E-02 0.00109 ];
U238_CAPT                 (idx, [1:   4]) = [  2.66979E+14 0.00037  1.76021E-01 0.00031 ];
PU239_CAPT                (idx, [1:   4]) = [  6.68445E+14 0.00018  4.40715E-01 0.00015 ];

% Neutron balance (particles/weight):

BALA_SRC_NEUTRON_SRC      (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_FISS     (idx, [1:   2]) = [ 100001571 1.00000E+08 ] ;
BALA_SRC_NEUTRON_NXN      (idx, [1:   2]) = [ 0 1.91249E+05 ] ;
BALA_SRC_NEUTRON_VR       (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_TOT      (idx, [1:   2]) = [ 100001571 1.00191E+08 ] ;

BALA_LOSS_NEUTRON_CAPT    (idx, [1:   2]) = [ 52455867 5.25567E+07 ] ;
BALA_LOSS_NEUTRON_FISS    (idx, [1:   2]) = [ 47545704 4.76346E+07 ] ;
BALA_LOSS_NEUTRON_LEAK    (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_CUT     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_ERR     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_TOT     (idx, [1:   2]) = [ 100001571 1.00191E+08 ] ;

BALA_NEUTRON_DIFF         (idx, [1:   2]) = [ 0 -4.50611E-05 ] ;

% Normalized total reaction rates (neutrons):

TOT_POWER                 (idx, [1:   6]) = [  4.56722E+04 0.0E+00  4.56722E+04 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_POWDENS               (idx, [1:   6]) = [  3.80000E-02 0.0E+00  3.80000E-02 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_GENRATE               (idx, [1:   6]) = [  3.90502E+15 8.5E-07  3.90502E+15 8.5E-07  0.00000E+00 0.0E+00 ];
TOT_FISSRATE              (idx, [1:   6]) = [  1.37452E+15 1.8E-07  1.37452E+15 1.8E-07  0.00000E+00 0.0E+00 ];
TOT_CAPTRATE              (idx, [1:   6]) = [  1.51664E+15 7.8E-05  1.43052E+15 8.2E-05  8.61220E+13 0.00015 ];
TOT_ABSRATE               (idx, [1:   6]) = [  2.89117E+15 4.1E-05  2.80504E+15 4.2E-05  8.61220E+13 0.00015 ];
TOT_SRCRATE               (idx, [1:   6]) = [  2.88590E+15 8.5E-05  2.88590E+15 8.5E-05  0.00000E+00 0.0E+00 ];
TOT_FLUX                  (idx, [1:   6]) = [  1.12523E+17 7.6E-05  3.37625E+16 9.4E-05  7.87601E+16 7.6E-05 ];
TOT_PHOTON_PRODRATE       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_LEAKRATE              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
ALBEDO_LEAKRATE           (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_LOSSRATE              (idx, [1:   2]) = [  2.89117E+15 4.1E-05 ];
TOT_CUTRATE               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_RR                    (idx, [1:   2]) = [  7.09688E+16 6.6E-05 ];
INI_FMASS                 (idx, 1)        =  1.20190E+00 ;
TOT_FMASS                 (idx, 1)        =  1.20190E+00 ;
INI_BURN_FMASS            (idx, 1)        =  1.20190E+00 ;
TOT_BURN_FMASS            (idx, 1)        =  1.20190E+00 ;

% Six-factor formula:

SIX_FF_ETA                (idx, [1:   2]) = [  1.75742E+00 9.8E-05 ];
SIX_FF_F                  (idx, [1:   2]) = [  9.71318E-01 2.1E-05 ];
SIX_FF_P                  (idx, [1:   2]) = [  6.26705E-01 8.0E-05 ];
SIX_FF_EPSILON            (idx, [1:   2]) = [  1.26502E+00 7.5E-05 ];
SIX_FF_LF                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_LT                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_KINF               (idx, [1:   2]) = [  1.35330E+00 0.00010 ];
SIX_FF_KEFF               (idx, [1:   2]) = [  1.35330E+00 0.00010 ];

% Fission neutron and energy production:

NUBAR                     (idx, [1:   2]) = [  2.84100E+00 8.8E-07 ];
FISSE                     (idx, [1:   2]) = [  2.07391E+02 1.8E-07 ];

% Criticality eigenvalues:

ANA_KEFF                  (idx, [1:   6]) = [  1.35329E+00 0.00011  1.34950E+00 0.00010  3.80839E-03 0.00287 ];
IMP_KEFF                  (idx, [1:   2]) = [  1.35326E+00 4.1E-05 ];
COL_KEFF                  (idx, [1:   2]) = [  1.35314E+00 8.5E-05 ];
ABS_KEFF                  (idx, [1:   2]) = [  1.35326E+00 4.1E-05 ];
ABS_KINF                  (idx, [1:   2]) = [  1.35326E+00 4.1E-05 ];
GEOM_ALBEDO               (idx, [1:   6]) = [  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00 ];

% ALF (Average lethargy of neutrons causing fission):
% Based on E0 = 2.000000E+01 MeV

ANA_ALF                   (idx, [1:   2]) = [  1.73084E+01 3.6E-05 ];
IMP_ALF                   (idx, [1:   2]) = [  1.73087E+01 1.3E-05 ];

% EALF (Energy corresponding to average lethargy of neutrons causing fission):

ANA_EALF                  (idx, [1:   2]) = [  6.08311E-07 0.00062 ];
IMP_EALF                  (idx, [1:   2]) = [  6.08095E-07 0.00023 ];

% AFGE (Average energy of neutrons causing fission):

ANA_AFGE                  (idx, [1:   2]) = [  1.24781E-01 0.00080 ];
IMP_AFGE                  (idx, [1:   2]) = [  1.24826E-01 0.00025 ];

% Forward-weighted delayed neutron parameters:

PRECURSOR_GROUPS          (idx, 1)        = 6 ;
FWD_ANA_BETA_ZERO         (idx, [1:  14]) = [  2.11150E-03 0.00189  6.55499E-05 0.01058  4.91339E-04 0.00388  3.73015E-04 0.00448  8.59740E-04 0.00290  2.60745E-04 0.00548  6.11077E-05 0.01104 ];
FWD_ANA_LAMBDA            (idx, [1:  14]) = [  5.74863E-01 0.00495  1.24765E-02 1.9E-05  3.02558E-02 0.00011  1.08690E-01 0.00014  3.19943E-01 6.3E-05  1.33456E+00 0.00017  8.75205E+00 0.00361 ];

% Beta-eff using Meulekamp's method:

ADJ_MEULEKAMP_BETA_EFF    (idx, [1:  14]) = [  2.80972E-03 0.00260  8.76783E-05 0.01446  6.54082E-04 0.00493  4.96311E-04 0.00607  1.14422E-03 0.00395  3.46576E-04 0.00684  8.08567E-05 0.01404 ];
ADJ_MEULEKAMP_LAMBDA      (idx, [1:  14]) = [  5.72017E-01 0.00620  1.24766E-02 2.5E-05  3.02560E-02 0.00014  1.08692E-01 0.00019  3.19931E-01 8.4E-05  1.33420E+00 0.00021  8.72215E+00 0.00470 ];

% Adjoint weighted time constants using Nauchi's method:

IFP_CHAIN_LENGTH          (idx, 1)        = 15 ;
ADJ_NAUCHI_GEN_TIME       (idx, [1:   6]) = [  8.06542E-06 0.00023  8.06448E-06 0.00023  8.39943E-06 0.00391 ];
ADJ_NAUCHI_LIFETIME       (idx, [1:   6]) = [  1.09148E-05 0.00020  1.09135E-05 0.00020  1.13668E-05 0.00391 ];
ADJ_NAUCHI_BETA_EFF       (idx, [1:  14]) = [  2.81543E-03 0.00291  8.64811E-05 0.01581  6.55231E-04 0.00580  4.99989E-04 0.00662  1.14334E-03 0.00435  3.47948E-04 0.00776  8.24430E-05 0.01572 ];
ADJ_NAUCHI_LAMBDA         (idx, [1:  14]) = [  5.77764E-01 0.00719  1.24767E-02 3.0E-05  3.02553E-02 0.00016  1.08680E-01 0.00021  3.19935E-01 9.1E-05  1.33455E+00 0.00024  8.75478E+00 0.00523 ];

% Adjoint weighted time constants using IFP:

ADJ_IFP_GEN_TIME          (idx, [1:   6]) = [  8.06753E-06 0.00051  8.06672E-06 0.00051  8.36570E-06 0.00958 ];
ADJ_IFP_LIFETIME          (idx, [1:   6]) = [  1.09176E-05 0.00050  1.09165E-05 0.00050  1.13212E-05 0.00958 ];
ADJ_IFP_IMP_BETA_EFF      (idx, [1:  14]) = [  2.86296E-03 0.00823  9.33991E-05 0.04498  6.61719E-04 0.01732  5.08468E-04 0.01982  1.16475E-03 0.01277  3.49570E-04 0.02509  8.50573E-05 0.05015 ];
ADJ_IFP_IMP_LAMBDA        (idx, [1:  14]) = [  5.81625E-01 0.02358  1.24763E-02 7.3E-05  3.02641E-02 0.00050  1.08689E-01 0.00066  3.19928E-01 0.00029  1.33484E+00 0.00075  8.66875E+00 0.01428 ];
ADJ_IFP_ANA_BETA_EFF      (idx, [1:  14]) = [  2.85821E-03 0.00816  9.11079E-05 0.04449  6.61111E-04 0.01690  5.09303E-04 0.01957  1.16202E-03 0.01256  3.49329E-04 0.02423  8.53358E-05 0.04896 ];
ADJ_IFP_ANA_LAMBDA        (idx, [1:  14]) = [  5.82049E-01 0.02283  1.24764E-02 7.2E-05  3.02629E-02 0.00049  1.08687E-01 0.00066  3.19929E-01 0.00029  1.33492E+00 0.00074  8.65582E+00 0.01431 ];
ADJ_IFP_ROSSI_ALPHA       (idx, [1:   2]) = [ -3.55036E+02 0.00830 ];

% Adjoint weighted time constants using perturbation technique:

ADJ_PERT_GEN_TIME         (idx, [1:   2]) = [  8.06425E-06 0.00014 ];
ADJ_PERT_LIFETIME         (idx, [1:   2]) = [  1.09132E-05 8.7E-05 ];
ADJ_PERT_BETA_EFF         (idx, [1:   2]) = [  2.81614E-03 0.00162 ];
ADJ_PERT_ROSSI_ALPHA      (idx, [1:   2]) = [ -3.49217E+02 0.00163 ];

% Inverse neutron speed :

ANA_INV_SPD               (idx, [1:   2]) = [  2.22398E-07 0.00013 ];

% Analog slowing-down and thermal neutron lifetime (total/prompt/delayed):

ANA_SLOW_TIME             (idx, [1:   6]) = [  2.77563E-06 9.6E-05  2.77564E-06 9.6E-05  2.77078E-06 0.00181 ];
ANA_THERM_TIME            (idx, [1:   6]) = [  1.06390E-05 0.00015  1.06390E-05 0.00015  1.06610E-05 0.00277 ];
ANA_THERM_FRAC            (idx, [1:   6]) = [  6.27354E-01 8.1E-05  6.26844E-01 8.1E-05  8.69733E-01 0.00306 ];
ANA_DELAYED_EMTIME        (idx, [1:   2]) = [  1.32257E+01 0.00414 ];
ANA_MEAN_NCOL             (idx, [1:   4]) = [  2.45472E+01 4.7E-05  2.65784E+01 6.1E-05 ];

% Group constant generation:

GC_UNIVERSE_NAME          (idx, [1:   4]) = '1001' ;

% Micro- and macro-group structures:

MICRO_NG                  (idx, 1)        = 70 ;
MICRO_E                   (idx, [1:  71]) = [  2.00000E+01  6.06550E+00  3.67900E+00  2.23100E+00  1.35300E+00  8.21000E-01  5.00000E-01  3.02500E-01  1.83000E-01  1.11000E-01  6.74300E-02  4.08500E-02  2.47800E-02  1.50300E-02  9.11800E-03  5.50000E-03  3.51910E-03  2.23945E-03  1.42510E-03  9.06898E-04  3.67262E-04  1.48728E-04  7.55014E-05  4.80520E-05  2.77000E-05  1.59680E-05  9.87700E-06  4.00000E-06  3.30000E-06  2.60000E-06  2.10000E-06  1.85500E-06  1.50000E-06  1.30000E-06  1.15000E-06  1.12300E-06  1.09700E-06  1.07100E-06  1.04500E-06  1.02000E-06  9.96000E-07  9.72000E-07  9.50000E-07  9.10000E-07  8.50000E-07  7.80000E-07  6.25000E-07  5.00000E-07  4.00000E-07  3.50000E-07  3.20000E-07  3.00000E-07  2.80000E-07  2.50000E-07  2.20000E-07  1.80000E-07  1.40000E-07  1.00000E-07  8.00000E-08  6.70000E-08  5.80000E-08  5.00000E-08  4.20000E-08  3.50000E-08  3.00000E-08  2.50000E-08  2.00000E-08  1.50000E-08  1.00000E-08  5.00000E-09  1.00000E-11 ];

MACRO_NG                  (idx, 1)        = 2 ;
MACRO_E                   (idx, [1:   3]) = [  1.00000E+37  6.25000E-07  0.00000E+00 ];

% Micro-group spectrum:

INF_MICRO_FLX             (idx, [1: 140]) = [  1.62059E+06 0.00065  6.00231E+06 0.00028  1.19081E+07 0.00022  1.29202E+07 0.00020  1.18417E+07 0.00015  1.26246E+07 0.00016  8.53865E+06 0.00015  7.51887E+06 0.00017  5.73336E+06 0.00016  4.68833E+06 0.00018  4.05244E+06 0.00019  3.64813E+06 0.00023  3.36824E+06 0.00018  3.19887E+06 0.00016  3.11435E+06 0.00016  2.68643E+06 0.00026  2.65401E+06 0.00021  2.61130E+06 0.00017  2.57299E+06 0.00021  4.98378E+06 0.00014  4.66512E+06 0.00016  3.33908E+06 0.00015  2.04950E+06 0.00018  2.57345E+06 0.00019  2.20403E+06 0.00017  1.97110E+06 0.00024  3.57570E+06 0.00017  8.10804E+05 0.00035  1.01305E+06 0.00033  9.14216E+05 0.00040  5.32975E+05 0.00053  9.17829E+05 0.00034  6.22601E+05 0.00037  5.34495E+05 0.00040  1.03274E+05 0.00101  1.02269E+05 0.00114  1.04846E+05 0.00070  1.07220E+05 0.00100  1.06032E+05 0.00085  1.03970E+05 0.00110  1.07214E+05 0.00089  1.00628E+05 0.00070  1.89147E+05 0.00080  3.00328E+05 0.00054  3.79559E+05 0.00047  9.76201E+05 0.00029  9.51265E+05 0.00034  8.32433E+05 0.00031  3.91283E+05 0.00035  2.20305E+05 0.00058  1.48413E+05 0.00058  1.58963E+05 0.00061  2.71534E+05 0.00055  3.55269E+05 0.00046  6.75701E+05 0.00041  1.03172E+06 0.00030  1.52036E+06 0.00026  9.85396E+05 0.00033  7.10719E+05 0.00035  5.15536E+05 0.00044  4.62135E+05 0.00039  4.59929E+05 0.00037  3.88898E+05 0.00042  2.63427E+05 0.00055  2.46594E+05 0.00045  2.16994E+05 0.00052  1.88432E+05 0.00040  1.45838E+05 0.00056  9.54002E+04 0.00069  3.36775E+04 0.00090 ];

% Integral parameters:

INF_KINF                  (idx, [1:   2]) = [  1.35314E+00 7.7E-05 ];

% Flux spectra in infinite geometry:

INF_FLX                   (idx, [1:   4]) = [  1.04391E+17 6.4E-05  8.13118E+15 0.00018 ];
INF_FISS_FLX              (idx, [1:   4]) = [  3.19353E+16 8.4E-05  1.82720E+15 8.6E-05 ];

% Reaction cross sections:

INF_TOT                   (idx, [1:   4]) = [  5.56106E-01 2.4E-05  1.58847E+00 4.6E-05 ];
INF_CAPT                  (idx, [1:   4]) = [  7.59482E-03 0.00013  8.90168E-02 0.00017 ];
INF_ABS                   (idx, [1:   4]) = [  1.03704E-02 0.00011  2.22427E-01 0.00017 ];
INF_FISS                  (idx, [1:   4]) = [  2.77555E-03 0.00014  1.33410E-01 0.00018 ];
INF_NSF                   (idx, [1:   4]) = [  7.83380E-03 0.00014  3.79681E-01 0.00018 ];
INF_NUBAR                 (idx, [1:   4]) = [  2.82243E+00 4.1E-06  2.84596E+00 2.0E-07 ];
INF_KAPPA                 (idx, [1:   4]) = [  2.06672E+02 8.7E-07  2.07583E+02 8.0E-08 ];
INF_INVV                  (idx, [1:   4]) = [  5.55671E-08 0.00010  2.36425E-06 5.2E-05 ];

% Total scattering cross sections:

INF_SCATT0                (idx, [1:   4]) = [  5.45733E-01 2.5E-05  1.36605E+00 5.3E-05 ];
INF_SCATT1                (idx, [1:   4]) = [  2.49525E-01 3.3E-05  3.82312E-01 0.00011 ];
INF_SCATT2                (idx, [1:   4]) = [  9.83311E-02 6.5E-05  9.87288E-02 0.00037 ];
INF_SCATT3                (idx, [1:   4]) = [  7.58046E-03 0.00065  2.96464E-02 0.00107 ];
INF_SCATT4                (idx, [1:   4]) = [ -1.04052E-02 0.00037 -5.56256E-03 0.00439 ];
INF_SCATT5                (idx, [1:   4]) = [  2.78279E-04 0.01552  5.10202E-03 0.00482 ];
INF_SCATT6                (idx, [1:   4]) = [  5.24133E-03 0.00064 -1.37024E-02 0.00133 ];
INF_SCATT7                (idx, [1:   4]) = [  7.68633E-04 0.00414 -5.45565E-04 0.04133 ];

% Total scattering production cross sections:

INF_SCATTP0               (idx, [1:   4]) = [  5.45786E-01 2.5E-05  1.36605E+00 5.3E-05 ];
INF_SCATTP1               (idx, [1:   4]) = [  2.49526E-01 3.3E-05  3.82312E-01 0.00011 ];
INF_SCATTP2               (idx, [1:   4]) = [  9.83312E-02 6.6E-05  9.87288E-02 0.00037 ];
INF_SCATTP3               (idx, [1:   4]) = [  7.58044E-03 0.00065  2.96464E-02 0.00107 ];
INF_SCATTP4               (idx, [1:   4]) = [ -1.04052E-02 0.00036 -5.56256E-03 0.00439 ];
INF_SCATTP5               (idx, [1:   4]) = [  2.78324E-04 0.01549  5.10202E-03 0.00482 ];
INF_SCATTP6               (idx, [1:   4]) = [  5.24129E-03 0.00064 -1.37024E-02 0.00133 ];
INF_SCATTP7               (idx, [1:   4]) = [  7.68654E-04 0.00414 -5.45565E-04 0.04133 ];

% Diffusion parameters:

INF_TRANSPXS              (idx, [1:   4]) = [  2.19520E-01 6.5E-05  1.07592E+00 6.0E-05 ];
INF_DIFFCOEF              (idx, [1:   4]) = [  1.51847E+00 6.5E-05  3.09811E-01 6.0E-05 ];

% Reduced absoption and removal:

INF_RABSXS                (idx, [1:   4]) = [  1.03175E-02 0.00011  2.22427E-01 0.00017 ];
INF_REMXS                 (idx, [1:   4]) = [  2.79520E-02 4.5E-05  2.25692E-01 0.00016 ];

% Poison cross sections:

INF_I135_YIELD            (idx, [1:   4]) = [  6.49336E-02 1.2E-06  6.52839E-02 1.2E-07 ];
INF_XE135_YIELD           (idx, [1:   4]) = [  8.48569E-03 3.9E-05  1.02439E-02 2.3E-06 ];
INF_PM147_YIELD           (idx, [1:   4]) = [  4.98610E-09 4.4E-05  6.15445E-09 3.1E-06 ];
INF_PM148_YIELD           (idx, [1:   4]) = [  9.68024E-09 4.4E-05  1.19483E-08 3.1E-06 ];
INF_PM148M_YIELD          (idx, [1:   4]) = [  3.45637E-08 4.4E-05  4.26686E-08 3.1E-06 ];
INF_PM149_YIELD           (idx, [1:   4]) = [  1.22674E-02 2.9E-06  1.20955E-02 3.3E-07 ];
INF_SM149_YIELD           (idx, [1:   4]) = [  6.29063E-10 4.4E-05  7.76582E-10 3.1E-06 ];
INF_I135_MICRO_ABS        (idx, [1:   4]) = [  8.98555E-01 0.00017  3.03729E+01 0.00015 ];
INF_XE135_MICRO_ABS       (idx, [1:   4]) = [  1.23400E+02 0.00035  1.12578E+06 0.00014 ];
INF_PM147_MICRO_ABS       (idx, [1:   4]) = [  5.93204E+01 0.00093  6.25805E+01 0.00015 ];
INF_PM148_MICRO_ABS       (idx, [1:   4]) = [  8.40810E+01 0.00019  7.60492E+02 0.00015 ];
INF_PM148M_MICRO_ABS      (idx, [1:   4]) = [  1.30909E+02 0.00016  1.27389E+04 0.00018 ];
INF_PM149_MICRO_ABS       (idx, [1:   4]) = [  4.58190E+01 0.00015  5.32350E+02 0.00015 ];
INF_SM149_MICRO_ABS       (idx, [1:   4]) = [  9.81617E+01 0.00038  3.35345E+04 0.00014 ];
INF_I135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_MACRO_ABS      (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison universe-averaged densities:

I135_ADENS                (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
XE135_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM147_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148M_ADENS              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
SM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Poison decay constants:

PM147_LAMBDA              (idx, 1)        =  8.37254E-09 ;
PM148_LAMBDA              (idx, 1)        =  1.49451E-06 ;
PM148M_LAMBDA             (idx, 1)        =  1.94297E-07 ;
PM149_LAMBDA              (idx, 1)        =  3.62737E-06 ;
I135_LAMBDA               (idx, 1)        =  2.93061E-05 ;
XE135_LAMBDA              (idx, 1)        =  2.10657E-05 ;
XE135M_LAMBDA             (idx, 1)        =  7.55556E-04 ;
I135_BR                   (idx, 1)        =  9.01450E-01 ;

% Fission spectra:

INF_CHIT                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHIP                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHID                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

INF_S0                    (idx, [1:   8]) = [  5.28154E-01 2.4E-05  1.75794E-02 6.3E-05  3.26364E-03 0.00107  1.36278E+00 5.4E-05 ];
INF_S1                    (idx, [1:   8]) = [  2.44363E-01 3.3E-05  5.16142E-03 0.00018  1.17850E-03 0.00166  3.81133E-01 0.00011 ];
INF_S2                    (idx, [1:   8]) = [  9.98901E-02 6.1E-05 -1.55896E-03 0.00060  7.11776E-04 0.00176  9.80170E-02 0.00037 ];
INF_S3                    (idx, [1:   8]) = [  9.44948E-03 0.00049 -1.86901E-03 0.00043  3.10956E-04 0.00448  2.93355E-02 0.00108 ];
INF_S4                    (idx, [1:   8]) = [ -9.79130E-03 0.00040 -6.13913E-04 0.00112  5.56778E-05 0.02414 -5.61823E-03 0.00438 ];
INF_S5                    (idx, [1:   8]) = [  2.50984E-04 0.01707  2.72949E-05 0.02103 -6.59716E-05 0.01571  5.16799E-03 0.00474 ];
INF_S6                    (idx, [1:   8]) = [  5.36772E-03 0.00062 -1.26393E-04 0.00460 -1.10623E-04 0.00839 -1.35918E-02 0.00133 ];
INF_S7                    (idx, [1:   8]) = [  9.30961E-04 0.00327 -1.62328E-04 0.00368 -1.15113E-04 0.00816 -4.30452E-04 0.05181 ];

% Scattering production matrixes:

INF_SP0                   (idx, [1:   8]) = [  5.28207E-01 2.4E-05  1.75794E-02 6.3E-05  3.26364E-03 0.00107  1.36278E+00 5.4E-05 ];
INF_SP1                   (idx, [1:   8]) = [  2.44364E-01 3.4E-05  5.16142E-03 0.00018  1.17850E-03 0.00166  3.81133E-01 0.00011 ];
INF_SP2                   (idx, [1:   8]) = [  9.98902E-02 6.2E-05 -1.55896E-03 0.00060  7.11776E-04 0.00176  9.80170E-02 0.00037 ];
INF_SP3                   (idx, [1:   8]) = [  9.44946E-03 0.00049 -1.86901E-03 0.00043  3.10956E-04 0.00448  2.93355E-02 0.00108 ];
INF_SP4                   (idx, [1:   8]) = [ -9.79125E-03 0.00040 -6.13913E-04 0.00112  5.56778E-05 0.02414 -5.61823E-03 0.00438 ];
INF_SP5                   (idx, [1:   8]) = [  2.51030E-04 0.01703  2.72949E-05 0.02103 -6.59716E-05 0.01571  5.16799E-03 0.00474 ];
INF_SP6                   (idx, [1:   8]) = [  5.36768E-03 0.00062 -1.26393E-04 0.00460 -1.10623E-04 0.00839 -1.35918E-02 0.00133 ];
INF_SP7                   (idx, [1:   8]) = [  9.30982E-04 0.00327 -1.62328E-04 0.00368 -1.15113E-04 0.00816 -4.30452E-04 0.05181 ];

% Micro-group spectrum:

B1_MICRO_FLX              (idx, [1: 140]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Integral parameters:

B1_KINF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_KEFF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_B2                     (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_ERR                    (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Critical spectra in infinite geometry:

B1_FLX                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS_FLX               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reaction cross sections:

B1_TOT                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CAPT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_ABS                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NSF                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NUBAR                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_KAPPA                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_INVV                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering cross sections:

B1_SCATT0                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT1                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT2                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT3                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT4                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT5                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT6                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT7                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering production cross sections:

B1_SCATTP0                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP1                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP2                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP3                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP4                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP5                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP6                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP7                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Diffusion parameters:

B1_TRANSPXS               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_DIFFCOEF               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reduced absoption and removal:

B1_RABSXS                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_REMXS                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison cross sections:

B1_I135_YIELD             (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_I135_MICRO_ABS         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Fission spectra:

B1_CHIT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHIP                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHID                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

B1_S0                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S1                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S2                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S3                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S4                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S5                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S6                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S7                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering production matrixes:

B1_SP0                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP1                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP2                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP3                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP4                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP5                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP6                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP7                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Additional diffusion parameters:

CMM_TRANSPXS              (idx, [1:   4]) = [  2.34001E-01 0.00012  9.16132E-01 0.00095 ];
CMM_TRANSPXS_X            (idx, [1:   4]) = [  2.34083E-01 0.00019  9.22921E-01 0.00167 ];
CMM_TRANSPXS_Y            (idx, [1:   4]) = [  2.34108E-01 0.00016  9.20421E-01 0.00158 ];
CMM_TRANSPXS_Z            (idx, [1:   4]) = [  2.33811E-01 0.00022  9.05335E-01 0.00111 ];
CMM_DIFFCOEF              (idx, [1:   4]) = [  1.42450E+00 0.00012  3.63856E-01 0.00095 ];
CMM_DIFFCOEF_X            (idx, [1:   4]) = [  1.42400E+00 0.00019  3.61196E-01 0.00166 ];
CMM_DIFFCOEF_Y            (idx, [1:   4]) = [  1.42384E+00 0.00016  3.62175E-01 0.00158 ];
CMM_DIFFCOEF_Z            (idx, [1:   4]) = [  1.42565E+00 0.00022  3.68199E-01 0.00111 ];

% Delayed neutron parameters (Meulekamp method):

BETA_EFF                  (idx, [1:  14]) = [  2.80972E-03 0.00260  8.76783E-05 0.01446  6.54082E-04 0.00493  4.96311E-04 0.00607  1.14422E-03 0.00395  3.46576E-04 0.00684  8.08567E-05 0.01404 ];
LAMBDA                    (idx, [1:  14]) = [  5.72017E-01 0.00620  1.24766E-02 2.5E-05  3.02560E-02 0.00014  1.08692E-01 0.00019  3.19931E-01 8.4E-05  1.33420E+00 0.00021  8.72215E+00 0.00470 ];

% Pin-power distribution:

PPW_LATTICE               (idx, [1:   4]) = '1000' ;
PPW_LATTICE_TYPE          (idx, 1)        = 1 ;
PPW_PINS                  (idx, 1)        = 289 ;
PPW_POW                   (idx, [1: 1156]) = [  7.85288E-04 0.00182  2.73235E-03 0.00239  7.84386E-04 0.00207  2.68016E-03 0.00205  7.84275E-04 0.00240  2.68546E-03 0.00219  7.85818E-04 0.00212  2.71824E-03 0.00222  7.86883E-04 0.00198  2.76531E-03 0.00165  7.94670E-04 0.00224  2.80485E-03 0.00234  7.86295E-04 0.00261  2.79206E-03 0.00193  7.90168E-04 0.00206  2.79580E-03 0.00246  7.89520E-04 0.00184  2.81008E-03 0.00261  7.88950E-04 0.00172  2.79026E-03 0.00197  7.91660E-04 0.00200  2.79590E-03 0.00240  7.91649E-04 0.00202  2.79491E-03 0.00210  7.88633E-04 0.00243  2.77251E-03 0.00155  7.85766E-04 0.00161  2.71838E-03 0.00170  7.86047E-04 0.00197  2.67750E-03 0.00217  7.86548E-04 0.00207  2.66869E-03 0.00247  7.86602E-04 0.00196  2.73144E-03 0.00200  7.85548E-04 0.00157  2.66306E-03 0.00190  7.83655E-04 0.00233  2.62333E-03 0.00210  7.84326E-04 0.00186  2.65716E-03 0.00241  7.87904E-04 0.00186  2.75065E-03 0.00195  7.90420E-04 0.00152  2.89801E-03 0.00238  8.00008E-04 0.00185  3.12131E-03 0.00220  7.91627E-04 0.00197  2.90485E-03 0.00243  7.94254E-04 0.00175  2.90356E-03 0.00215  8.00015E-04 0.00182  3.11272E-03 0.00214  7.93699E-04 0.00207  2.91990E-03 0.00207  7.92239E-04 0.00183  2.90464E-03 0.00200  8.00524E-04 0.00200  3.11652E-03 0.00201  7.92880E-04 0.00208  2.89613E-03 0.00199  7.88470E-04 0.00147  2.74748E-03 0.00211  7.83606E-04 0.00194  2.66453E-03 0.00217  7.83114E-04 0.00247  2.60949E-03 0.00213  7.85095E-04 0.00234  2.68228E-03 0.00204  7.81177E-04 0.00260  2.67302E-03 0.00200  7.84847E-04 0.00185  2.65548E-03 0.00285  7.88778E-04 0.00166  2.83250E-03 0.00172  7.99808E-04 0.00256  3.15112E-03 0.00199  8.00785E-04 0.00184  3.31268E-03 0.00152  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.02210E-04 0.00172  3.18913E-03 0.00203  8.00377E-04 0.00192  3.17484E-03 0.00241  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.01320E-04 0.00162  3.17972E-03 0.00182  8.02638E-04 0.00243  3.19985E-03 0.00188  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.05388E-04 0.00154  3.30914E-03 0.00165  7.99446E-04 0.00194  3.16287E-03 0.00167  7.90690E-04 0.00223  2.84159E-03 0.00302  7.84109E-04 0.00161  2.66664E-03 0.00186  7.83197E-04 0.00207  2.66963E-03 0.00156  7.86836E-04 0.00199  2.71404E-03 0.00187  7.87203E-04 0.00229  2.74503E-03 0.00228  7.97793E-04 0.00217  3.15502E-03 0.00155  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.04037E-04 0.00246  3.38140E-03 0.00200  8.06240E-04 0.00167  3.29083E-03 0.00222  7.96335E-04 0.00220  3.00449E-03 0.00174  7.95320E-04 0.00223  2.98819E-03 0.00205  8.00906E-04 0.00194  3.20136E-03 0.00209  7.95862E-04 0.00251  2.98549E-03 0.00237  7.95105E-04 0.00190  3.00917E-03 0.00184  8.05121E-04 0.00193  3.26729E-03 0.00206  8.08278E-04 0.00165  3.38762E-03 0.00211  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  7.98489E-04 0.00158  3.16292E-03 0.00170  7.87990E-04 0.00214  2.74926E-03 0.00252  7.83776E-04 0.00222  2.71449E-03 0.00191  7.86288E-04 0.00184  2.76768E-03 0.00207  7.92602E-04 0.00161  2.89667E-03 0.00216  8.06166E-04 0.00189  3.30985E-03 0.00262  8.08941E-04 0.00176  3.38464E-03 0.00206  8.05200E-04 0.00224  3.18997E-03 0.00194  8.03544E-04 0.00181  3.27893E-03 0.00180  8.02179E-04 0.00236  3.01703E-03 0.00216  7.95080E-04 0.00258  2.98993E-03 0.00218  8.02632E-04 0.00199  3.20876E-03 0.00221  7.97829E-04 0.00229  3.00007E-03 0.00217  7.97220E-04 0.00202  2.99800E-03 0.00177  8.02974E-04 0.00234  3.26237E-03 0.00191  8.03288E-04 0.00168  3.20012E-03 0.00192  8.08510E-04 0.00251  3.38610E-03 0.00244  8.03493E-04 0.00233  3.31830E-03 0.00207  7.92717E-04 0.00187  2.89591E-03 0.00191  7.85974E-04 0.00204  2.75609E-03 0.00226  7.91230E-04 0.00215  2.80739E-03 0.00189  7.99408E-04 0.00179  3.12005E-03 0.00200  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.02624E-04 0.00190  3.26940E-03 0.00197  8.06814E-04 0.00253  3.26777E-03 0.00173  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.04290E-04 0.00184  3.23740E-03 0.00211  8.03810E-04 0.00182  3.21548E-03 0.00207  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.01904E-04 0.00184  3.21181E-03 0.00233  8.03807E-04 0.00185  3.22350E-03 0.00209  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.03288E-04 0.00197  3.26774E-03 0.00198  8.05046E-04 0.00218  3.27603E-03 0.00177  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  7.98234E-04 0.00208  3.12194E-03 0.00214  7.92604E-04 0.00185  2.80405E-03 0.00260  7.88442E-04 0.00171  2.78249E-03 0.00189  7.93350E-04 0.00225  2.90682E-03 0.00189  8.02620E-04 0.00189  3.19714E-03 0.00194  7.97209E-04 0.00234  3.00165E-03 0.00210  7.95255E-04 0.00165  3.00828E-03 0.00213  8.00524E-04 0.00250  3.23572E-03 0.00251  8.00288E-04 0.00168  2.99853E-03 0.00210  7.96925E-04 0.00140  2.99519E-03 0.00184  8.02009E-04 0.00190  3.21353E-03 0.00217  7.95946E-04 0.00196  2.99320E-03 0.00210  7.96353E-04 0.00212  2.99968E-03 0.00246  8.00709E-04 0.00195  3.22273E-03 0.00217  7.95759E-04 0.00165  3.01059E-03 0.00167  7.95503E-04 0.00201  2.99862E-03 0.00196  7.98384E-04 0.00258  3.19811E-03 0.00204  7.94283E-04 0.00200  2.91522E-03 0.00241  7.88139E-04 0.00167  2.78839E-03 0.00192  7.91720E-04 0.00180  2.79052E-03 0.00230  7.94289E-04 0.00195  2.90449E-03 0.00160  7.96763E-04 0.00154  3.18546E-03 0.00224  7.96546E-04 0.00252  2.97917E-03 0.00245  7.97502E-04 0.00179  2.99343E-03 0.00163  8.03186E-04 0.00213  3.21246E-03 0.00175  7.95727E-04 0.00163  2.99428E-03 0.00216  7.97601E-04 0.00166  2.99692E-03 0.00177  8.04442E-04 0.00216  3.21185E-03 0.00221  7.95496E-04 0.00169  2.98795E-03 0.00239  7.97024E-04 0.00204  3.00069E-03 0.00207  8.03081E-04 0.00190  3.21546E-03 0.00185  7.96318E-04 0.00177  2.99283E-03 0.00241  7.95645E-04 0.00205  2.99167E-03 0.00173  8.01113E-04 0.00199  3.17619E-03 0.00177  7.92982E-04 0.00206  2.91101E-03 0.00153  7.92639E-04 0.00233  2.79312E-03 0.00211  7.92275E-04 0.00274  2.81235E-03 0.00252  7.97727E-04 0.00213  3.10925E-03 0.00210  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.03885E-04 0.00170  3.20440E-03 0.00234  8.01747E-04 0.00137  3.22074E-03 0.00177  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.02955E-04 0.00208  3.21190E-03 0.00225  8.00867E-04 0.00207  3.22393E-03 0.00184  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.00383E-04 0.00193  3.20818E-03 0.00215  8.05067E-04 0.00230  3.21551E-03 0.00190  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.04473E-04 0.00226  3.21336E-03 0.00183  8.03158E-04 0.00169  3.19816E-03 0.00208  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  7.97698E-04 0.00184  3.10368E-03 0.00228  7.91870E-04 0.00202  2.80540E-03 0.00164  7.89852E-04 0.00227  2.79574E-03 0.00229  7.92514E-04 0.00167  2.90532E-03 0.00281  8.01407E-04 0.00212  3.18737E-03 0.00204  7.97861E-04 0.00180  2.98121E-03 0.00195  7.97184E-04 0.00203  2.99612E-03 0.00161  8.03581E-04 0.00213  3.21355E-03 0.00183  7.97405E-04 0.00203  2.99346E-03 0.00250  7.97598E-04 0.00208  2.99704E-03 0.00174  8.02119E-04 0.00189  3.22030E-03 0.00228  7.97130E-04 0.00203  2.98312E-03 0.00205  7.94702E-04 0.00212  2.99518E-03 0.00204  8.03656E-04 0.00253  3.22826E-03 0.00204  7.95611E-04 0.00246  2.99823E-03 0.00238  7.96641E-04 0.00189  2.98673E-03 0.00228  7.99658E-04 0.00236  3.18086E-03 0.00199  7.93734E-04 0.00232  2.90859E-03 0.00212  7.89386E-04 0.00252  2.79475E-03 0.00229  7.90620E-04 0.00197  2.78211E-03 0.00204  7.93949E-04 0.00181  2.90258E-03 0.00204  8.02437E-04 0.00181  3.19809E-03 0.00215  7.97640E-04 0.00249  2.99093E-03 0.00213  8.01418E-04 0.00213  3.00680E-03 0.00183  8.02083E-04 0.00190  3.22557E-03 0.00207  7.97840E-04 0.00226  2.99580E-03 0.00246  7.99228E-04 0.00222  2.98712E-03 0.00193  8.03345E-04 0.00174  3.21565E-03 0.00201  7.98353E-04 0.00194  2.99143E-03 0.00230  7.98972E-04 0.00187  3.00302E-03 0.00203  8.06760E-04 0.00165  3.23028E-03 0.00206  7.96209E-04 0.00238  3.01724E-03 0.00239  7.97490E-04 0.00215  3.00194E-03 0.00173  8.00208E-04 0.00238  3.18907E-03 0.00211  7.93380E-04 0.00262  2.90262E-03 0.00224  7.92629E-04 0.00232  2.77716E-03 0.00251  7.90634E-04 0.00211  2.79989E-03 0.00233  7.99350E-04 0.00229  3.10703E-03 0.00170  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.05222E-04 0.00217  3.27948E-03 0.00211  8.05583E-04 0.00192  3.26998E-03 0.00236  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.01270E-04 0.00179  3.23428E-03 0.00230  8.03460E-04 0.00213  3.22365E-03 0.00158  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.04964E-04 0.00179  3.21264E-03 0.00166  8.04746E-04 0.00210  3.21520E-03 0.00170  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.05743E-04 0.00193  3.27133E-03 0.00189  8.07124E-04 0.00157  3.27641E-03 0.00180  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  7.97826E-04 0.00194  3.12436E-03 0.00233  7.91299E-04 0.00210  2.80338E-03 0.00266  7.88508E-04 0.00175  2.75982E-03 0.00181  7.93621E-04 0.00173  2.89139E-03 0.00252  8.02436E-04 0.00179  3.31260E-03 0.00210  8.06609E-04 0.00159  3.39290E-03 0.00136  8.04594E-04 0.00162  3.19777E-03 0.00187  8.02944E-04 0.00194  3.27050E-03 0.00210  7.96173E-04 0.00167  3.00627E-03 0.00261  7.94445E-04 0.00165  2.98419E-03 0.00204  8.03884E-04 0.00231  3.21205E-03 0.00188  7.98038E-04 0.00217  3.00030E-03 0.00187  7.96879E-04 0.00184  3.00636E-03 0.00206  8.03552E-04 0.00251  3.28052E-03 0.00180  8.01549E-04 0.00240  3.19253E-03 0.00185  8.06968E-04 0.00193  3.39147E-03 0.00171  8.04117E-04 0.00251  3.31433E-03 0.00184  7.94823E-04 0.00226  2.90935E-03 0.00237  7.88642E-04 0.00205  2.76847E-03 0.00254  7.84832E-04 0.00243  2.72036E-03 0.00233  7.86641E-04 0.00202  2.74990E-03 0.00242  8.01473E-04 0.00238  3.16502E-03 0.00157  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.07440E-04 0.00242  3.38852E-03 0.00224  8.04906E-04 0.00213  3.27709E-03 0.00227  7.97751E-04 0.00192  3.01345E-03 0.00180  7.97849E-04 0.00235  2.98199E-03 0.00208  8.04696E-04 0.00220  3.19704E-03 0.00201  7.97384E-04 0.00258  2.98713E-03 0.00151  7.99674E-04 0.00162  2.99387E-03 0.00181  8.04837E-04 0.00212  3.28472E-03 0.00207  8.06428E-04 0.00183  3.39489E-03 0.00226  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  7.98966E-04 0.00219  3.17903E-03 0.00208  7.88917E-04 0.00286  2.75052E-03 0.00226  7.87435E-04 0.00204  2.71175E-03 0.00168  7.86766E-04 0.00246  2.68272E-03 0.00186  7.87512E-04 0.00184  2.66371E-03 0.00273  7.91143E-04 0.00183  2.84280E-03 0.00190  8.00805E-04 0.00133  3.17196E-03 0.00189  8.02029E-04 0.00187  3.31170E-03 0.00203  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  7.99451E-04 0.00228  3.18965E-03 0.00213  8.00553E-04 0.00197  3.18440E-03 0.00231  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.01630E-04 0.00214  3.17126E-03 0.00181  8.01452E-04 0.00186  3.19604E-03 0.00240  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  8.04353E-04 0.00205  3.30726E-03 0.00217  8.02074E-04 0.00219  3.16572E-03 0.00199  7.90801E-04 0.00260  2.84027E-03 0.00260  7.84778E-04 0.00168  2.66194E-03 0.00225  7.85196E-04 0.00239  2.67319E-03 0.00196  7.86256E-04 0.00212  2.68481E-03 0.00207  7.83798E-04 0.00173  2.61664E-03 0.00189  7.85421E-04 0.00189  2.66455E-03 0.00250  7.87822E-04 0.00217  2.75555E-03 0.00193  7.90052E-04 0.00270  2.89688E-03 0.00205  7.98042E-04 0.00181  3.10865E-03 0.00258  7.91603E-04 0.00249  2.91409E-03 0.00193  7.91907E-04 0.00206  2.91749E-03 0.00175  7.98367E-04 0.00196  3.11148E-03 0.00188  7.93243E-04 0.00192  2.90672E-03 0.00163  7.93082E-04 0.00193  2.92013E-03 0.00175  7.98431E-04 0.00200  3.12921E-03 0.00193  7.95040E-04 0.00264  2.90496E-03 0.00177  7.87076E-04 0.00216  2.75086E-03 0.00231  7.85436E-04 0.00176  2.66312E-03 0.00215  7.82338E-04 0.00212  2.61936E-03 0.00241  7.85747E-04 0.00249  2.67018E-03 0.00197  7.85074E-04 0.00197  2.73897E-03 0.00237  7.84859E-04 0.00268  2.67220E-03 0.00229  7.86356E-04 0.00190  2.66061E-03 0.00134  7.86925E-04 0.00231  2.71676E-03 0.00269  7.88246E-04 0.00243  2.76040E-03 0.00234  7.88871E-04 0.00194  2.80759E-03 0.00237  7.87724E-04 0.00249  2.77784E-03 0.00213  7.90408E-04 0.00210  2.78432E-03 0.00219  7.93006E-04 0.00178  2.79255E-03 0.00199  7.92298E-04 0.00188  2.80297E-03 0.00164  7.88386E-04 0.00247  2.79708E-03 0.00180  7.87680E-04 0.00232  2.79532E-03 0.00261  7.88228E-04 0.00181  2.76451E-03 0.00221  7.85497E-04 0.00238  2.70709E-03 0.00209  7.83236E-04 0.00201  2.67201E-03 0.00251  7.85790E-04 0.00196  2.66711E-03 0.00213  7.84804E-04 0.00304  2.73617E-03 0.00212 ];
PPW_HOM_FLUX              (idx, [1: 1156]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
PPW_FF                    (idx, [1: 1156]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];


% Increase counter:

if (exist('idx', 'var'));
  idx = idx + 1;
else;
  idx = 1;
end;

% Version, title and date:

VERSION                   (idx, [1:  13]) = 'Serpent 2.2.1' ;
COMPILE_DATE              (idx, [1:  20]) = 'Oct 19 2025 23:43:21' ;
DEBUG                     (idx, 1)        = 0 ;
TITLE                     (idx, [1:  59]) = 'D001_homo_Pu239+U235_Th0.700_Pu0.040_U2330.000_U235E0.02000' ;
CONFIDENTIAL_DATA         (idx, 1)        = 0 ;
INPUT_FILE_NAME           (idx, [1:  59]) = '/dssg/home/acct-sc_wang/lu_shiyi/work/results/D001/D001.sss' ;
WORKING_DIRECTORY         (idx, [1:  50]) = '/dssg/home/acct-sc_wang/lu_shiyi/work/results/D001' ;
HOSTNAME                  (idx, [1:  22]) = 'node394.pi.sjtu.edu.cn' ;
CPU_TYPE                  (idx, [1:  44]) = 'Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz' ;
CPU_MHZ                   (idx, 1)        = 218104848.0 ;
START_DATE                (idx, [1:  24]) = 'Wed Apr 29 14:21:36 2026' ;
COMPLETE_DATE             (idx, [1:  24]) = 'Wed Apr 29 14:40:19 2026' ;

% Run parameters:

POP                       (idx, 1)        = 200000 ;
CYCLES                    (idx, 1)        = 500 ;
SKIP                      (idx, 1)        = 20 ;
BATCH_INTERVAL            (idx, 1)        = 1 ;
SRC_NORM_MODE             (idx, 1)        = 2 ;
SEED                      (idx, 1)        = 1777443696418 ;
UFS_MODE                  (idx, 1)        = 0 ;
UFS_ORDER                 (idx, 1)        = 1.00000 ;
NEUTRON_TRANSPORT_MODE    (idx, 1)        = 1 ;
PHOTON_TRANSPORT_MODE     (idx, 1)        = 0 ;
GROUP_CONSTANT_GENERATION (idx, 1)        = 1 ;
B1_CALCULATION            (idx, [1:  3])  = [ 0 0 0 ] ;
B1_IMPLICIT_LEAKAGE       (idx, 1)        = 0 ;
B1_BURNUP_CORRECTION      (idx, 1)        = 0 ;

CRIT_SPEC_MODE            (idx, 1)        = 0 ;
IMPLICIT_REACTION_RATES   (idx, 1)        = 1 ;

% Optimization:

OPTIMIZATION_MODE         (idx, 1)        = 4 ;
RECONSTRUCT_MICROXS       (idx, 1)        = 1 ;
RECONSTRUCT_MACROXS       (idx, 1)        = 1 ;
DOUBLE_INDEXING           (idx, 1)        = 0 ;
MG_MAJORANT_MODE          (idx, 1)        = 0 ;
SPECTRUM_COLLAPSE         (idx, 1)        = 1 ;

% Parallelization:

MPI_TASKS                 (idx, 1)        = 1 ;
OMP_THREADS               (idx, 1)        = 33 ;
MPI_REPRODUCIBILITY       (idx, 1)        = 0 ;
OMP_REPRODUCIBILITY       (idx, 1)        = 1 ;
OMP_HISTORY_PROFILE       (idx, [1:  33]) = [  1.07288E+00  1.08650E+00  1.09001E+00  9.06850E-01  1.07810E+00  9.13394E-01  9.11280E-01  9.06897E-01  1.08552E+00  1.08324E+00  1.03158E+00  9.00171E-01  9.54620E-01  9.13537E-01  1.08900E+00  1.07948E+00  1.07637E+00  9.10429E-01  1.09432E+00  9.04324E-01  1.09136E+00  1.09088E+00  9.18874E-01  1.08718E+00  9.04697E-01  1.09106E+00  9.08299E-01  9.06209E-01  9.11434E-01  1.08799E+00  9.13084E-01  9.07810E-01  1.09264E+00  ];
SHARE_BUF_ARRAY           (idx, 1)        = 0 ;
SHARE_RES2_ARRAY          (idx, 1)        = 1 ;
OMP_SHARED_QUEUE_LIM      (idx, 1)        = 0 ;

% File paths:

XS_DATA_FILE_PATH         (idx, [1:  63]) = '/dssg/home/acct-sc_wang/lu_shiyi/data/endfb7/sss_endfb7u.xsdata' ;
DECAY_DATA_FILE_PATH      (idx, [1:  59]) = '/dssg/home/acct-sc_wang/lu_shiyi/data/endfb7/sss_endfb7.dec' ;
SFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
NFY_DATA_FILE_PATH        (idx, [1:  59]) = '/dssg/home/acct-sc_wang/lu_shiyi/data/endfb7/sss_endfb7.nfy' ;
BRA_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;

% Collision and reaction sampling (neutrons/photons):

MIN_MACROXS               (idx, [1:   4]) = [  5.00000E-02 1.7E-09  0.00000E+00 0.0E+00 ];
DT_THRESH                 (idx, [1:   2]) = [  9.00000E-01  9.00000E-01 ] ;
ST_FRAC                   (idx, [1:   4]) = [  2.64728E-02 0.00014  0.00000E+00 0.0E+00 ];
DT_FRAC                   (idx, [1:   4]) = [  9.73527E-01 3.8E-06  0.00000E+00 0.0E+00 ];
DT_EFF                    (idx, [1:   4]) = [  7.62572E-01 1.4E-05  0.00000E+00 0.0E+00 ];
REA_SAMPLING_EFF          (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
REA_SAMPLING_FAIL         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_COL_EFF               (idx, [1:   4]) = [  7.63135E-01 1.4E-05  0.00000E+00 0.0E+00 ];
AVG_TRACKING_LOOPS        (idx, [1:   8]) = [  2.89584E+00 5.9E-05  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
CELL_SEARCH_FRAC          (idx, [1:  10]) = [  9.08194E-01 9.3E-06  9.18028E-02 9.2E-05  3.50881E-06 0.00631  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
AVG_TRACKS                (idx, [1:   4]) = [  2.45472E+01 4.7E-05  0.00000E+00 0.0E+00 ];
AVG_REAL_COL              (idx, [1:   4]) = [  2.45472E+01 4.7E-05  0.00000E+00 0.0E+00 ];
AVG_VIRT_COL              (idx, [1:   4]) = [  7.61905E+00 7.0E-05  0.00000E+00 0.0E+00 ];
AVG_SURF_CROSS            (idx, [1:   4]) = [  2.64803E+00 9.5E-05  0.00000E+00 0.0E+00 ];
LOST_PARTICLES            (idx, 1)        = 0 ;

% Run statistics:

CYCLE_IDX                 (idx, 1)        = 500 ;
SIMULATED_HISTORIES       (idx, 1)        = 100001571 ;
MEAN_POP_SIZE             (idx, [1:   2]) = [  2.00003E+05 0.00015 ] ;
MEAN_POP_WGT              (idx, [1:   2]) = [  2.00003E+05 0.00015 ] ;
SIMULATION_COMPLETED      (idx, 1)        = 1 ;

% Running times:

TOT_CPU_TIME              (idx, 1)        =  4.53342E+02 ;
RUNNING_TIME              (idx, 1)        =  1.87189E+01 ;
INIT_TIME                 (idx, [1:   2]) = [  7.54283E-01  7.54283E-01 ] ;
PROCESS_TIME              (idx, [1:   2]) = [  8.85000E-03  8.85000E-03 ] ;
TRANSPORT_CYCLE_TIME      (idx, [1:   3]) = [  1.79556E+01  1.79556E+01  0.00000E+00 ] ;
BURNUP_CYCLE_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
BATEMAN_SOLUTION_TIME     (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
MPI_OVERHEAD_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
ESTIMATED_RUNNING_TIME    (idx, [1:   2]) = [  1.87173E+01  0.00000E+00 ] ;
CPU_USAGE                 (idx, 1)        = 24.21839 ;
TRANSPORT_CPU_USAGE       (idx, [1:   2]) = [  2.57926E+01 0.00532 ];
OMP_PARALLEL_FRAC         (idx, 1)        =  7.26804E-01 ;

% Memory usage:

AVAIL_MEM                 (idx, 1)        = 515110.43 ;
ALLOC_MEMSIZE             (idx, 1)        = 13250.86 ;
MEMSIZE                   (idx, 1)        = 12982.37 ;
XS_MEMSIZE                (idx, 1)        = 6854.70 ;
MAT_MEMSIZE               (idx, 1)        = 4767.36 ;
RES_MEMSIZE               (idx, 1)        = 24.37 ;
IFC_MEMSIZE               (idx, 1)        = 0.00 ;
MISC_MEMSIZE              (idx, 1)        = 1335.93 ;
UNKNOWN_MEMSIZE           (idx, 1)        = 0.00 ;
UNUSED_MEMSIZE            (idx, 1)        = 268.49 ;

% Geometry parameters:

TOT_CELLS                 (idx, 1)        = 4 ;
UNION_CELLS               (idx, 1)        = 0 ;

% Neutron energy grid:

NEUTRON_ERG_TOL           (idx, 1)        =  5.00000E-05 ;
NEUTRON_ERG_NE            (idx, 1)        = 282063 ;
NEUTRON_EMIN              (idx, 1)        =  1.00000E-11 ;
NEUTRON_EMAX              (idx, 1)        =  2.00000E+01 ;

% Unresolved resonance probability table sampling:

URES_DILU_CUT             (idx, 1)        =  1.00000E-09 ;
URES_EMIN                 (idx, 1)        =  1.00000E+37 ;
URES_EMAX                 (idx, 1)        = -1.00000E+37 ;
URES_AVAIL                (idx, 1)        = 229 ;
URES_USED                 (idx, 1)        = 0 ;

% Nuclides and reaction channels:

TOT_NUCLIDES              (idx, 1)        = 1366 ;
TOT_TRANSPORT_NUCLIDES    (idx, 1)        = 300 ;
TOT_DOSIMETRY_NUCLIDES    (idx, 1)        = 0 ;
TOT_DECAY_NUCLIDES        (idx, 1)        = 1066 ;
TOT_PHOTON_NUCLIDES       (idx, 1)        = 0 ;
TOT_REA_CHANNELS          (idx, 1)        = 8370 ;
TOT_TRANSMU_REA           (idx, 1)        = 2717 ;

% Neutron physics options:

USE_DELNU                 (idx, 1)        = 1 ;
USE_URES                  (idx, 1)        = 0 ;
USE_DBRC                  (idx, 1)        = 0 ;
IMPL_CAPT                 (idx, 1)        = 0 ;
IMPL_NXN                  (idx, 1)        = 1 ;
IMPL_FISS                 (idx, 1)        = 0 ;
DOPPLER_PREPROCESSOR      (idx, 1)        = 1 ;
TMS_MODE                  (idx, 1)        = 0 ;
SAMPLE_FISS               (idx, 1)        = 1 ;
SAMPLE_CAPT               (idx, 1)        = 1 ;
SAMPLE_SCATT              (idx, 1)        = 1 ;

% Energy deposition:

EDEP_MODE                 (idx, 1)        = 0 ;
EDEP_DELAYED              (idx, 1)        = 1 ;
EDEP_KEFF_CORR            (idx, 1)        = 1 ;
EDEP_LOCAL_EGD            (idx, 1)        = 0 ;
EDEP_COMP                 (idx, [1:   9]) = [ 0 0 0 0 0 0 0 0 0 ] ;
EDEP_CAPT_E               (idx, 1)        =  0.00000E+00 ;

% Radioactivity data:

TOT_ACTIVITY              (idx, 1)        =  1.12787E+11 ;
TOT_DECAY_HEAT            (idx, 1)        =  9.47110E-02 ;
TOT_SF_RATE               (idx, 1)        =  2.12013E+02 ;
ACTINIDE_ACTIVITY         (idx, 1)        =  1.12787E+11 ;
ACTINIDE_DECAY_HEAT       (idx, 1)        =  9.47110E-02 ;
FISSION_PRODUCT_ACTIVITY  (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_DECAY_HEAT(idx, 1)        =  0.00000E+00 ;
INHALATION_TOXICITY       (idx, 1)        =  1.35339E+07 ;
INGESTION_TOXICITY        (idx, 1)        =  2.81958E+04 ;
ACTINIDE_INH_TOX          (idx, 1)        =  1.35339E+07 ;
ACTINIDE_ING_TOX          (idx, 1)        =  2.81958E+04 ;
FISSION_PRODUCT_INH_TOX   (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ING_TOX   (idx, 1)        =  0.00000E+00 ;
SR90_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
TE132_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
I131_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
I132_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
CS134_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
CS137_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
PHOTON_DECAY_SOURCE       (idx, [1:   2]) = [  4.95011E+09  1.18082E-05 ] ;
NEUTRON_DECAY_SOURCE      (idx, 1)        =  0.00000E+00 ;
ALPHA_DECAY_SOURCE        (idx, 1)        =  1.12803E+11 ;
ELECTRON_DECAY_SOURCE     (idx, 1)        =  3.71925E+10 ;

% Normalization coefficient:

NORM_COEF                 (idx, [1:   4]) = [  1.44295E+10 8.5E-05  0.00000E+00 0.0E+00 ];

% Parameters for burnup calculation:

BURN_MATERIALS            (idx, 1)        = 264 ;
BURN_MODE                 (idx, 1)        = 2 ;
BURN_STEP                 (idx, 1)        = 0 ;
BURN_RANDOMIZE_DATA       (idx, [1:   3]) = [ 0 0 0 ] ;
BURNUP                    (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
BURN_DAYS                 (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
FIMA                      (idx, [1:   3]) = [  0.00000E+00  0.00000E+00  3.09488E+24 ] ;

% Analog reaction rate estimators:

CONVERSION_RATIO          (idx, [1:   2]) = [  3.60989E-01 0.00023 ];
TH232_FISS                (idx, [1:   4]) = [  1.45537E+13 0.00141  1.05869E-02 0.00140 ];
U235_FISS                 (idx, [1:   4]) = [  8.69304E+13 0.00060  6.32367E-02 0.00059 ];
U238_FISS                 (idx, [1:   4]) = [  2.20158E+13 0.00118  1.60151E-02 0.00116 ];
PU239_FISS                (idx, [1:   4]) = [  1.25118E+15 0.00012  9.10161E-01 4.8E-05 ];
TH232_CAPT                (idx, [1:   4]) = [  4.66158E+14 0.00027  3.07343E-01 0.00020 ];
U235_CAPT                 (idx, [1:   4]) = [  2.42876E+13 0.00110  1.60131E-02 0.00109 ];
U238_CAPT                 (idx, [1:   4]) = [  2.66979E+14 0.00037  1.76021E-01 0.00031 ];
PU239_CAPT                (idx, [1:   4]) = [  6.68445E+14 0.00018  4.40715E-01 0.00015 ];

% Neutron balance (particles/weight):

BALA_SRC_NEUTRON_SRC      (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_FISS     (idx, [1:   2]) = [ 100001571 1.00000E+08 ] ;
BALA_SRC_NEUTRON_NXN      (idx, [1:   2]) = [ 0 1.91249E+05 ] ;
BALA_SRC_NEUTRON_VR       (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_TOT      (idx, [1:   2]) = [ 100001571 1.00191E+08 ] ;

BALA_LOSS_NEUTRON_CAPT    (idx, [1:   2]) = [ 52455867 5.25567E+07 ] ;
BALA_LOSS_NEUTRON_FISS    (idx, [1:   2]) = [ 47545704 4.76346E+07 ] ;
BALA_LOSS_NEUTRON_LEAK    (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_CUT     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_ERR     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_TOT     (idx, [1:   2]) = [ 100001571 1.00191E+08 ] ;

BALA_NEUTRON_DIFF         (idx, [1:   2]) = [ 0 -4.50611E-05 ] ;

% Normalized total reaction rates (neutrons):

TOT_POWER                 (idx, [1:   6]) = [  4.56722E+04 0.0E+00  4.56722E+04 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_POWDENS               (idx, [1:   6]) = [  3.80000E-02 0.0E+00  3.80000E-02 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_GENRATE               (idx, [1:   6]) = [  3.90502E+15 8.5E-07  3.90502E+15 8.5E-07  0.00000E+00 0.0E+00 ];
TOT_FISSRATE              (idx, [1:   6]) = [  1.37452E+15 1.8E-07  1.37452E+15 1.8E-07  0.00000E+00 0.0E+00 ];
TOT_CAPTRATE              (idx, [1:   6]) = [  1.51664E+15 7.8E-05  1.43052E+15 8.2E-05  8.61220E+13 0.00015 ];
TOT_ABSRATE               (idx, [1:   6]) = [  2.89117E+15 4.1E-05  2.80504E+15 4.2E-05  8.61220E+13 0.00015 ];
TOT_SRCRATE               (idx, [1:   6]) = [  2.88590E+15 8.5E-05  2.88590E+15 8.5E-05  0.00000E+00 0.0E+00 ];
TOT_FLUX                  (idx, [1:   6]) = [  1.12523E+17 7.6E-05  3.37625E+16 9.4E-05  7.87601E+16 7.6E-05 ];
TOT_PHOTON_PRODRATE       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_LEAKRATE              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
ALBEDO_LEAKRATE           (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_LOSSRATE              (idx, [1:   2]) = [  2.89117E+15 4.1E-05 ];
TOT_CUTRATE               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_RR                    (idx, [1:   2]) = [  7.09688E+16 6.6E-05 ];
INI_FMASS                 (idx, 1)        =  1.20190E+00 ;
TOT_FMASS                 (idx, 1)        =  1.20190E+00 ;
INI_BURN_FMASS            (idx, 1)        =  1.20190E+00 ;
TOT_BURN_FMASS            (idx, 1)        =  1.20190E+00 ;

% Six-factor formula:

SIX_FF_ETA                (idx, [1:   2]) = [  1.75742E+00 9.8E-05 ];
SIX_FF_F                  (idx, [1:   2]) = [  9.71318E-01 2.1E-05 ];
SIX_FF_P                  (idx, [1:   2]) = [  6.26705E-01 8.0E-05 ];
SIX_FF_EPSILON            (idx, [1:   2]) = [  1.26502E+00 7.5E-05 ];
SIX_FF_LF                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_LT                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_KINF               (idx, [1:   2]) = [  1.35330E+00 0.00010 ];
SIX_FF_KEFF               (idx, [1:   2]) = [  1.35330E+00 0.00010 ];

% Fission neutron and energy production:

NUBAR                     (idx, [1:   2]) = [  2.84100E+00 8.8E-07 ];
FISSE                     (idx, [1:   2]) = [  2.07391E+02 1.8E-07 ];

% Criticality eigenvalues:

ANA_KEFF                  (idx, [1:   6]) = [  1.35329E+00 0.00011  1.34950E+00 0.00010  3.80839E-03 0.00287 ];
IMP_KEFF                  (idx, [1:   2]) = [  1.35326E+00 4.1E-05 ];
COL_KEFF                  (idx, [1:   2]) = [  1.35314E+00 8.5E-05 ];
ABS_KEFF                  (idx, [1:   2]) = [  1.35326E+00 4.1E-05 ];
ABS_KINF                  (idx, [1:   2]) = [  1.35326E+00 4.1E-05 ];
GEOM_ALBEDO               (idx, [1:   6]) = [  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00 ];

% ALF (Average lethargy of neutrons causing fission):
% Based on E0 = 2.000000E+01 MeV

ANA_ALF                   (idx, [1:   2]) = [  1.73084E+01 3.6E-05 ];
IMP_ALF                   (idx, [1:   2]) = [  1.73087E+01 1.3E-05 ];

% EALF (Energy corresponding to average lethargy of neutrons causing fission):

ANA_EALF                  (idx, [1:   2]) = [  6.08311E-07 0.00062 ];
IMP_EALF                  (idx, [1:   2]) = [  6.08095E-07 0.00023 ];

% AFGE (Average energy of neutrons causing fission):

ANA_AFGE                  (idx, [1:   2]) = [  1.24781E-01 0.00080 ];
IMP_AFGE                  (idx, [1:   2]) = [  1.24826E-01 0.00025 ];

% Forward-weighted delayed neutron parameters:

PRECURSOR_GROUPS          (idx, 1)        = 6 ;
FWD_ANA_BETA_ZERO         (idx, [1:  14]) = [  2.11150E-03 0.00189  6.55499E-05 0.01058  4.91339E-04 0.00388  3.73015E-04 0.00448  8.59740E-04 0.00290  2.60745E-04 0.00548  6.11077E-05 0.01104 ];
FWD_ANA_LAMBDA            (idx, [1:  14]) = [  5.74863E-01 0.00495  1.24765E-02 1.9E-05  3.02558E-02 0.00011  1.08690E-01 0.00014  3.19943E-01 6.3E-05  1.33456E+00 0.00017  8.75205E+00 0.00361 ];

% Beta-eff using Meulekamp's method:

ADJ_MEULEKAMP_BETA_EFF    (idx, [1:  14]) = [  2.80972E-03 0.00260  8.76783E-05 0.01446  6.54082E-04 0.00493  4.96311E-04 0.00607  1.14422E-03 0.00395  3.46576E-04 0.00684  8.08567E-05 0.01404 ];
ADJ_MEULEKAMP_LAMBDA      (idx, [1:  14]) = [  5.72017E-01 0.00620  1.24766E-02 2.5E-05  3.02560E-02 0.00014  1.08692E-01 0.00019  3.19931E-01 8.4E-05  1.33420E+00 0.00021  8.72215E+00 0.00470 ];

% Adjoint weighted time constants using Nauchi's method:

IFP_CHAIN_LENGTH          (idx, 1)        = 15 ;
ADJ_NAUCHI_GEN_TIME       (idx, [1:   6]) = [  8.06542E-06 0.00023  8.06448E-06 0.00023  8.39943E-06 0.00391 ];
ADJ_NAUCHI_LIFETIME       (idx, [1:   6]) = [  1.09148E-05 0.00020  1.09135E-05 0.00020  1.13668E-05 0.00391 ];
ADJ_NAUCHI_BETA_EFF       (idx, [1:  14]) = [  2.81543E-03 0.00291  8.64811E-05 0.01581  6.55231E-04 0.00580  4.99989E-04 0.00662  1.14334E-03 0.00435  3.47948E-04 0.00776  8.24430E-05 0.01572 ];
ADJ_NAUCHI_LAMBDA         (idx, [1:  14]) = [  5.77764E-01 0.00719  1.24767E-02 3.0E-05  3.02553E-02 0.00016  1.08680E-01 0.00021  3.19935E-01 9.1E-05  1.33455E+00 0.00024  8.75478E+00 0.00523 ];

% Adjoint weighted time constants using IFP:

ADJ_IFP_GEN_TIME          (idx, [1:   6]) = [  8.06753E-06 0.00051  8.06672E-06 0.00051  8.36570E-06 0.00958 ];
ADJ_IFP_LIFETIME          (idx, [1:   6]) = [  1.09176E-05 0.00050  1.09165E-05 0.00050  1.13212E-05 0.00958 ];
ADJ_IFP_IMP_BETA_EFF      (idx, [1:  14]) = [  2.86296E-03 0.00823  9.33991E-05 0.04498  6.61719E-04 0.01732  5.08468E-04 0.01982  1.16475E-03 0.01277  3.49570E-04 0.02509  8.50573E-05 0.05015 ];
ADJ_IFP_IMP_LAMBDA        (idx, [1:  14]) = [  5.81625E-01 0.02358  1.24763E-02 7.3E-05  3.02641E-02 0.00050  1.08689E-01 0.00066  3.19928E-01 0.00029  1.33484E+00 0.00075  8.66875E+00 0.01428 ];
ADJ_IFP_ANA_BETA_EFF      (idx, [1:  14]) = [  2.85821E-03 0.00816  9.11079E-05 0.04449  6.61111E-04 0.01690  5.09303E-04 0.01957  1.16202E-03 0.01256  3.49329E-04 0.02423  8.53358E-05 0.04896 ];
ADJ_IFP_ANA_LAMBDA        (idx, [1:  14]) = [  5.82049E-01 0.02283  1.24764E-02 7.2E-05  3.02629E-02 0.00049  1.08687E-01 0.00066  3.19929E-01 0.00029  1.33492E+00 0.00074  8.65582E+00 0.01431 ];
ADJ_IFP_ROSSI_ALPHA       (idx, [1:   2]) = [ -3.55036E+02 0.00830 ];

% Adjoint weighted time constants using perturbation technique:

ADJ_PERT_GEN_TIME         (idx, [1:   2]) = [  8.06425E-06 0.00014 ];
ADJ_PERT_LIFETIME         (idx, [1:   2]) = [  1.09132E-05 8.7E-05 ];
ADJ_PERT_BETA_EFF         (idx, [1:   2]) = [  2.81614E-03 0.00162 ];
ADJ_PERT_ROSSI_ALPHA      (idx, [1:   2]) = [ -3.49217E+02 0.00163 ];

% Inverse neutron speed :

ANA_INV_SPD               (idx, [1:   2]) = [  2.22398E-07 0.00013 ];

% Analog slowing-down and thermal neutron lifetime (total/prompt/delayed):

ANA_SLOW_TIME             (idx, [1:   6]) = [  2.77563E-06 9.6E-05  2.77564E-06 9.6E-05  2.77078E-06 0.00181 ];
ANA_THERM_TIME            (idx, [1:   6]) = [  1.06390E-05 0.00015  1.06390E-05 0.00015  1.06610E-05 0.00277 ];
ANA_THERM_FRAC            (idx, [1:   6]) = [  6.27354E-01 8.1E-05  6.26844E-01 8.1E-05  8.69733E-01 0.00306 ];
ANA_DELAYED_EMTIME        (idx, [1:   2]) = [  1.32257E+01 0.00414 ];
ANA_MEAN_NCOL             (idx, [1:   4]) = [  2.45472E+01 4.7E-05  2.65784E+01 6.1E-05 ];

% Group constant generation:

GC_UNIVERSE_NAME          (idx, [1:   1]) = '0' ;

% Micro- and macro-group structures:

MICRO_NG                  (idx, 1)        = 70 ;
MICRO_E                   (idx, [1:  71]) = [  2.00000E+01  6.06550E+00  3.67900E+00  2.23100E+00  1.35300E+00  8.21000E-01  5.00000E-01  3.02500E-01  1.83000E-01  1.11000E-01  6.74300E-02  4.08500E-02  2.47800E-02  1.50300E-02  9.11800E-03  5.50000E-03  3.51910E-03  2.23945E-03  1.42510E-03  9.06898E-04  3.67262E-04  1.48728E-04  7.55014E-05  4.80520E-05  2.77000E-05  1.59680E-05  9.87700E-06  4.00000E-06  3.30000E-06  2.60000E-06  2.10000E-06  1.85500E-06  1.50000E-06  1.30000E-06  1.15000E-06  1.12300E-06  1.09700E-06  1.07100E-06  1.04500E-06  1.02000E-06  9.96000E-07  9.72000E-07  9.50000E-07  9.10000E-07  8.50000E-07  7.80000E-07  6.25000E-07  5.00000E-07  4.00000E-07  3.50000E-07  3.20000E-07  3.00000E-07  2.80000E-07  2.50000E-07  2.20000E-07  1.80000E-07  1.40000E-07  1.00000E-07  8.00000E-08  6.70000E-08  5.80000E-08  5.00000E-08  4.20000E-08  3.50000E-08  3.00000E-08  2.50000E-08  2.00000E-08  1.50000E-08  1.00000E-08  5.00000E-09  1.00000E-11 ];

MACRO_NG                  (idx, 1)        = 2 ;
MACRO_E                   (idx, [1:   3]) = [  1.00000E+37  6.25000E-07  0.00000E+00 ];

% Micro-group spectrum:

INF_MICRO_FLX             (idx, [1: 140]) = [  1.62059E+06 0.00065  6.00231E+06 0.00028  1.19081E+07 0.00022  1.29202E+07 0.00020  1.18417E+07 0.00015  1.26246E+07 0.00016  8.53865E+06 0.00015  7.51887E+06 0.00017  5.73336E+06 0.00016  4.68833E+06 0.00018  4.05244E+06 0.00019  3.64813E+06 0.00023  3.36824E+06 0.00018  3.19887E+06 0.00016  3.11435E+06 0.00016  2.68643E+06 0.00026  2.65401E+06 0.00021  2.61130E+06 0.00017  2.57299E+06 0.00021  4.98378E+06 0.00014  4.66512E+06 0.00016  3.33908E+06 0.00015  2.04950E+06 0.00018  2.57345E+06 0.00019  2.20403E+06 0.00017  1.97110E+06 0.00024  3.57570E+06 0.00017  8.10804E+05 0.00035  1.01305E+06 0.00033  9.14216E+05 0.00040  5.32975E+05 0.00053  9.17829E+05 0.00034  6.22601E+05 0.00037  5.34495E+05 0.00040  1.03274E+05 0.00101  1.02269E+05 0.00114  1.04846E+05 0.00070  1.07220E+05 0.00100  1.06032E+05 0.00085  1.03970E+05 0.00110  1.07214E+05 0.00089  1.00628E+05 0.00070  1.89147E+05 0.00080  3.00328E+05 0.00054  3.79559E+05 0.00047  9.76201E+05 0.00029  9.51265E+05 0.00034  8.32433E+05 0.00031  3.91283E+05 0.00035  2.20305E+05 0.00058  1.48413E+05 0.00058  1.58963E+05 0.00061  2.71534E+05 0.00055  3.55269E+05 0.00046  6.75701E+05 0.00041  1.03172E+06 0.00030  1.52036E+06 0.00026  9.85396E+05 0.00033  7.10719E+05 0.00035  5.15536E+05 0.00044  4.62135E+05 0.00039  4.59929E+05 0.00037  3.88898E+05 0.00042  2.63427E+05 0.00055  2.46594E+05 0.00045  2.16994E+05 0.00052  1.88432E+05 0.00040  1.45838E+05 0.00056  9.54002E+04 0.00069  3.36775E+04 0.00090 ];

% Integral parameters:

INF_KINF                  (idx, [1:   2]) = [  1.35314E+00 7.7E-05 ];

% Flux spectra in infinite geometry:

INF_FLX                   (idx, [1:   4]) = [  1.04391E+17 6.4E-05  8.13118E+15 0.00018 ];
INF_FISS_FLX              (idx, [1:   4]) = [  3.19353E+16 8.4E-05  1.82720E+15 8.6E-05 ];

% Reaction cross sections:

INF_TOT                   (idx, [1:   4]) = [  5.56106E-01 2.4E-05  1.58847E+00 4.6E-05 ];
INF_CAPT                  (idx, [1:   4]) = [  7.59482E-03 0.00013  8.90168E-02 0.00017 ];
INF_ABS                   (idx, [1:   4]) = [  1.03704E-02 0.00011  2.22427E-01 0.00017 ];
INF_FISS                  (idx, [1:   4]) = [  2.77555E-03 0.00014  1.33410E-01 0.00018 ];
INF_NSF                   (idx, [1:   4]) = [  7.83380E-03 0.00014  3.79681E-01 0.00018 ];
INF_NUBAR                 (idx, [1:   4]) = [  2.82243E+00 4.1E-06  2.84596E+00 2.0E-07 ];
INF_KAPPA                 (idx, [1:   4]) = [  2.06672E+02 8.7E-07  2.07583E+02 8.0E-08 ];
INF_INVV                  (idx, [1:   4]) = [  5.55671E-08 0.00010  2.36425E-06 5.2E-05 ];

% Total scattering cross sections:

INF_SCATT0                (idx, [1:   4]) = [  5.45733E-01 2.5E-05  1.36605E+00 5.3E-05 ];
INF_SCATT1                (idx, [1:   4]) = [  2.49525E-01 3.3E-05  3.82312E-01 0.00011 ];
INF_SCATT2                (idx, [1:   4]) = [  9.83311E-02 6.5E-05  9.87288E-02 0.00037 ];
INF_SCATT3                (idx, [1:   4]) = [  7.58046E-03 0.00065  2.96464E-02 0.00107 ];
INF_SCATT4                (idx, [1:   4]) = [ -1.04052E-02 0.00037 -5.56256E-03 0.00439 ];
INF_SCATT5                (idx, [1:   4]) = [  2.78279E-04 0.01552  5.10202E-03 0.00482 ];
INF_SCATT6                (idx, [1:   4]) = [  5.24133E-03 0.00064 -1.37024E-02 0.00133 ];
INF_SCATT7                (idx, [1:   4]) = [  7.68633E-04 0.00414 -5.45565E-04 0.04133 ];

% Total scattering production cross sections:

INF_SCATTP0               (idx, [1:   4]) = [  5.45786E-01 2.5E-05  1.36605E+00 5.3E-05 ];
INF_SCATTP1               (idx, [1:   4]) = [  2.49526E-01 3.3E-05  3.82312E-01 0.00011 ];
INF_SCATTP2               (idx, [1:   4]) = [  9.83312E-02 6.6E-05  9.87288E-02 0.00037 ];
INF_SCATTP3               (idx, [1:   4]) = [  7.58044E-03 0.00065  2.96464E-02 0.00107 ];
INF_SCATTP4               (idx, [1:   4]) = [ -1.04052E-02 0.00036 -5.56256E-03 0.00439 ];
INF_SCATTP5               (idx, [1:   4]) = [  2.78324E-04 0.01549  5.10202E-03 0.00482 ];
INF_SCATTP6               (idx, [1:   4]) = [  5.24129E-03 0.00064 -1.37024E-02 0.00133 ];
INF_SCATTP7               (idx, [1:   4]) = [  7.68654E-04 0.00414 -5.45565E-04 0.04133 ];

% Diffusion parameters:

INF_TRANSPXS              (idx, [1:   4]) = [  2.19520E-01 6.5E-05  1.07592E+00 6.0E-05 ];
INF_DIFFCOEF              (idx, [1:   4]) = [  1.51847E+00 6.5E-05  3.09811E-01 6.0E-05 ];

% Reduced absoption and removal:

INF_RABSXS                (idx, [1:   4]) = [  1.03175E-02 0.00011  2.22427E-01 0.00017 ];
INF_REMXS                 (idx, [1:   4]) = [  2.79520E-02 4.5E-05  2.25692E-01 0.00016 ];

% Poison cross sections:

INF_I135_YIELD            (idx, [1:   4]) = [  6.49336E-02 1.2E-06  6.52839E-02 1.2E-07 ];
INF_XE135_YIELD           (idx, [1:   4]) = [  8.48569E-03 3.9E-05  1.02439E-02 2.3E-06 ];
INF_PM147_YIELD           (idx, [1:   4]) = [  4.98610E-09 4.4E-05  6.15445E-09 3.1E-06 ];
INF_PM148_YIELD           (idx, [1:   4]) = [  9.68024E-09 4.4E-05  1.19483E-08 3.1E-06 ];
INF_PM148M_YIELD          (idx, [1:   4]) = [  3.45637E-08 4.4E-05  4.26686E-08 3.1E-06 ];
INF_PM149_YIELD           (idx, [1:   4]) = [  1.22674E-02 2.9E-06  1.20955E-02 3.3E-07 ];
INF_SM149_YIELD           (idx, [1:   4]) = [  6.29063E-10 4.4E-05  7.76582E-10 3.1E-06 ];
INF_I135_MICRO_ABS        (idx, [1:   4]) = [  8.98555E-01 0.00017  3.03729E+01 0.00015 ];
INF_XE135_MICRO_ABS       (idx, [1:   4]) = [  1.23400E+02 0.00035  1.12578E+06 0.00014 ];
INF_PM147_MICRO_ABS       (idx, [1:   4]) = [  5.93204E+01 0.00093  6.25805E+01 0.00015 ];
INF_PM148_MICRO_ABS       (idx, [1:   4]) = [  8.40810E+01 0.00019  7.60492E+02 0.00015 ];
INF_PM148M_MICRO_ABS      (idx, [1:   4]) = [  1.30909E+02 0.00016  1.27389E+04 0.00018 ];
INF_PM149_MICRO_ABS       (idx, [1:   4]) = [  4.58190E+01 0.00015  5.32350E+02 0.00015 ];
INF_SM149_MICRO_ABS       (idx, [1:   4]) = [  9.81617E+01 0.00038  3.35345E+04 0.00014 ];
INF_I135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_MACRO_ABS      (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison universe-averaged densities:

I135_ADENS                (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
XE135_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM147_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148M_ADENS              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
SM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Poison decay constants:

PM147_LAMBDA              (idx, 1)        =  8.37254E-09 ;
PM148_LAMBDA              (idx, 1)        =  1.49451E-06 ;
PM148M_LAMBDA             (idx, 1)        =  1.94297E-07 ;
PM149_LAMBDA              (idx, 1)        =  3.62737E-06 ;
I135_LAMBDA               (idx, 1)        =  2.93061E-05 ;
XE135_LAMBDA              (idx, 1)        =  2.10657E-05 ;
XE135M_LAMBDA             (idx, 1)        =  7.55556E-04 ;
I135_BR                   (idx, 1)        =  9.01450E-01 ;

% Fission spectra:

INF_CHIT                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHIP                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHID                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

INF_S0                    (idx, [1:   8]) = [  5.28154E-01 2.4E-05  1.75794E-02 6.3E-05  3.26364E-03 0.00107  1.36278E+00 5.4E-05 ];
INF_S1                    (idx, [1:   8]) = [  2.44363E-01 3.3E-05  5.16142E-03 0.00018  1.17850E-03 0.00166  3.81133E-01 0.00011 ];
INF_S2                    (idx, [1:   8]) = [  9.98901E-02 6.1E-05 -1.55896E-03 0.00060  7.11776E-04 0.00176  9.80170E-02 0.00037 ];
INF_S3                    (idx, [1:   8]) = [  9.44948E-03 0.00049 -1.86901E-03 0.00043  3.10956E-04 0.00448  2.93355E-02 0.00108 ];
INF_S4                    (idx, [1:   8]) = [ -9.79130E-03 0.00040 -6.13913E-04 0.00112  5.56778E-05 0.02414 -5.61823E-03 0.00438 ];
INF_S5                    (idx, [1:   8]) = [  2.50984E-04 0.01707  2.72949E-05 0.02103 -6.59716E-05 0.01571  5.16799E-03 0.00474 ];
INF_S6                    (idx, [1:   8]) = [  5.36772E-03 0.00062 -1.26393E-04 0.00460 -1.10623E-04 0.00839 -1.35918E-02 0.00133 ];
INF_S7                    (idx, [1:   8]) = [  9.30961E-04 0.00327 -1.62328E-04 0.00368 -1.15113E-04 0.00816 -4.30452E-04 0.05181 ];

% Scattering production matrixes:

INF_SP0                   (idx, [1:   8]) = [  5.28207E-01 2.4E-05  1.75794E-02 6.3E-05  3.26364E-03 0.00107  1.36278E+00 5.4E-05 ];
INF_SP1                   (idx, [1:   8]) = [  2.44364E-01 3.4E-05  5.16142E-03 0.00018  1.17850E-03 0.00166  3.81133E-01 0.00011 ];
INF_SP2                   (idx, [1:   8]) = [  9.98902E-02 6.2E-05 -1.55896E-03 0.00060  7.11776E-04 0.00176  9.80170E-02 0.00037 ];
INF_SP3                   (idx, [1:   8]) = [  9.44946E-03 0.00049 -1.86901E-03 0.00043  3.10956E-04 0.00448  2.93355E-02 0.00108 ];
INF_SP4                   (idx, [1:   8]) = [ -9.79125E-03 0.00040 -6.13913E-04 0.00112  5.56778E-05 0.02414 -5.61823E-03 0.00438 ];
INF_SP5                   (idx, [1:   8]) = [  2.51030E-04 0.01703  2.72949E-05 0.02103 -6.59716E-05 0.01571  5.16799E-03 0.00474 ];
INF_SP6                   (idx, [1:   8]) = [  5.36768E-03 0.00062 -1.26393E-04 0.00460 -1.10623E-04 0.00839 -1.35918E-02 0.00133 ];
INF_SP7                   (idx, [1:   8]) = [  9.30982E-04 0.00327 -1.62328E-04 0.00368 -1.15113E-04 0.00816 -4.30452E-04 0.05181 ];

% Micro-group spectrum:

B1_MICRO_FLX              (idx, [1: 140]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Integral parameters:

B1_KINF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_KEFF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_B2                     (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_ERR                    (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Critical spectra in infinite geometry:

B1_FLX                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS_FLX               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reaction cross sections:

B1_TOT                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CAPT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_ABS                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NSF                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NUBAR                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_KAPPA                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_INVV                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering cross sections:

B1_SCATT0                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT1                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT2                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT3                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT4                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT5                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT6                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT7                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering production cross sections:

B1_SCATTP0                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP1                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP2                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP3                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP4                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP5                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP6                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP7                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Diffusion parameters:

B1_TRANSPXS               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_DIFFCOEF               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reduced absoption and removal:

B1_RABSXS                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_REMXS                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison cross sections:

B1_I135_YIELD             (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_I135_MICRO_ABS         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Fission spectra:

B1_CHIT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHIP                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHID                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

B1_S0                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S1                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S2                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S3                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S4                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S5                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S6                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S7                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering production matrixes:

B1_SP0                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP1                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP2                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP3                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP4                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP5                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP6                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP7                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Additional diffusion parameters:

CMM_TRANSPXS              (idx, [1:   4]) = [  2.34001E-01 0.00012  9.16132E-01 0.00095 ];
CMM_TRANSPXS_X            (idx, [1:   4]) = [  2.34083E-01 0.00019  9.22921E-01 0.00167 ];
CMM_TRANSPXS_Y            (idx, [1:   4]) = [  2.34108E-01 0.00016  9.20421E-01 0.00158 ];
CMM_TRANSPXS_Z            (idx, [1:   4]) = [  2.33811E-01 0.00022  9.05335E-01 0.00111 ];
CMM_DIFFCOEF              (idx, [1:   4]) = [  1.42450E+00 0.00012  3.63856E-01 0.00095 ];
CMM_DIFFCOEF_X            (idx, [1:   4]) = [  1.42400E+00 0.00019  3.61196E-01 0.00166 ];
CMM_DIFFCOEF_Y            (idx, [1:   4]) = [  1.42384E+00 0.00016  3.62175E-01 0.00158 ];
CMM_DIFFCOEF_Z            (idx, [1:   4]) = [  1.42565E+00 0.00022  3.68199E-01 0.00111 ];

% Delayed neutron parameters (Meulekamp method):

BETA_EFF                  (idx, [1:  14]) = [  2.80972E-03 0.00260  8.76783E-05 0.01446  6.54082E-04 0.00493  4.96311E-04 0.00607  1.14422E-03 0.00395  3.46576E-04 0.00684  8.08567E-05 0.01404 ];
LAMBDA                    (idx, [1:  14]) = [  5.72017E-01 0.00620  1.24766E-02 2.5E-05  3.02560E-02 0.00014  1.08692E-01 0.00019  3.19931E-01 8.4E-05  1.33420E+00 0.00021  8.72215E+00 0.00470 ];

% Assembly discontinuity factors (order: W-S-E-N / NW-NE-SE-SW):

DF_SURFACE                (idx, [1:   3]) = 'ADF' ;
DF_SURFACE_TYPE           (idx, 1)        = 6 ;
DF_SURFACE_N_PARAM        (idx, 1)        = 3 ;
DF_SURFACE_PARAMS         (idx, [1:   3]) = [ 0.00000E+00  0.00000E+00  1.07500E+01 ];
DF_SYM                    (idx, 1)        = 1 ;
DF_N_SURF                 (idx, 1)        = 4 ;
DF_N_CORN                 (idx, 1)        = 4 ;
DF_N_SGN                  (idx, 1)        = 4 ;
DF_VOLUME                 (idx, 1)        =  4.62250E+02 ;
DF_SURF_AREA              (idx, [1:   4]) = [ 2.15000E+01  2.15000E+01  2.15000E+01  2.15000E+01 ];
DF_MID_AREA               (idx, [1:   4]) = [ 2.15000E+00  2.15000E+00  2.15000E+00  2.15000E+00 ];
DF_CORN_AREA              (idx, [1:   4]) = [ 2.15000E+00  2.15000E+00  2.15000E+00  2.15000E+00 ];
DF_SURF_IN_CURR           (idx, [1:  16]) = [  1.21323E+15 0.00016  9.38072E+13 0.00039  1.21323E+15 0.00016  9.38072E+13 0.00039  1.21323E+15 0.00016  9.38072E+13 0.00039  1.21323E+15 0.00016  9.38072E+13 0.00039 ];
DF_SURF_OUT_CURR          (idx, [1:  16]) = [  1.21323E+15 0.00016  9.38072E+13 0.00039  1.21323E+15 0.00016  9.38072E+13 0.00039  1.21323E+15 0.00016  9.38072E+13 0.00039  1.21323E+15 0.00016  9.38072E+13 0.00039 ];
DF_SURF_NET_CURR          (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_MID_IN_CURR            (idx, [1:  16]) = [  1.21440E+14 0.00029  9.63984E+12 0.00123  1.21440E+14 0.00029  9.63984E+12 0.00123  1.21440E+14 0.00029  9.63984E+12 0.00123  1.21440E+14 0.00029  9.63984E+12 0.00123 ];
DF_MID_OUT_CURR           (idx, [1:  16]) = [  1.21440E+14 0.00029  9.63984E+12 0.00123  1.21440E+14 0.00029  9.63984E+12 0.00123  1.21440E+14 0.00029  9.63984E+12 0.00123  1.21440E+14 0.00029  9.63984E+12 0.00123 ];
DF_MID_NET_CURR           (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_CORN_IN_CURR           (idx, [1:  16]) = [  1.21165E+14 0.00027  9.31563E+12 0.00161  1.21165E+14 0.00027  9.31563E+12 0.00161  1.21165E+14 0.00027  9.31563E+12 0.00161  1.21165E+14 0.00027  9.31563E+12 0.00161 ];
DF_CORN_OUT_CURR          (idx, [1:  16]) = [  1.21165E+14 0.00027  9.31563E+12 0.00161  1.21165E+14 0.00027  9.31563E+12 0.00161  1.21165E+14 0.00027  9.31563E+12 0.00161  1.21165E+14 0.00027  9.31563E+12 0.00161 ];
DF_CORN_NET_CURR          (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_HET_VOL_FLUX           (idx, [1:   4]) = [  2.25833E+14 7.1E-05  1.75912E+13 0.00017 ];
DF_HET_SURF_FLUX          (idx, [1:  16]) = [  2.24114E+14 0.00017  1.86051E+13 0.00061  2.24114E+14 0.00017  1.86051E+13 0.00061  2.24114E+14 0.00017  1.86051E+13 0.00061  2.24114E+14 0.00017  1.86051E+13 0.00061 ];
DF_HET_CORN_FLUX          (idx, [1:  16]) = [  2.23646E+14 0.00039  1.85294E+13 0.00205  2.23646E+14 0.00039  1.85294E+13 0.00205  2.23646E+14 0.00039  1.85294E+13 0.00205  2.23646E+14 0.00039  1.85294E+13 0.00205 ];
DF_HOM_VOL_FLUX           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_HOM_SURF_FLUX          (idx, [1:  16]) = [  2.25833E+14 7.1E-05  1.75912E+13 0.00017  2.25833E+14 7.1E-05  1.75912E+13 0.00017  2.25833E+14 7.1E-05  1.75912E+13 0.00017  2.25833E+14 7.1E-05  1.75912E+13 0.00017 ];
DF_HOM_CORN_FLUX          (idx, [1:  16]) = [  2.25833E+14 7.1E-05  1.75912E+13 0.00017  2.25833E+14 7.1E-05  1.75912E+13 0.00017  2.25833E+14 7.1E-05  1.75912E+13 0.00017  2.25833E+14 7.1E-05  1.75912E+13 0.00017 ];
DF_SURF_DF                (idx, [1:  16]) = [  9.92390E-01 0.00014  1.05764E+00 0.00061  9.92390E-01 0.00014  1.05764E+00 0.00061  9.92390E-01 0.00014  1.05764E+00 0.00061  9.92390E-01 0.00014  1.05764E+00 0.00061 ];
DF_CORN_DF                (idx, [1:  16]) = [  9.90317E-01 0.00036  1.05334E+00 0.00208  9.90317E-01 0.00036  1.05334E+00 0.00208  9.90317E-01 0.00036  1.05334E+00 0.00208  9.90317E-01 0.00036  1.05334E+00 0.00208 ];
DF_SGN_SURF_IN_CURR       (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_SURF_OUT_CURR      (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_SURF_NET_CURR      (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_HET_SURF_FLUX      (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_HOM_SURF_FLUX      (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_SURF_DF            (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
