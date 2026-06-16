
% Increase counter:

if (exist('idx', 'var'));
  idx = idx + 1;
else;
  idx = 1;
end;

% Version, title and date:

VERSION                   (idx, [1:  13]) = 'Serpent 2.2.1' ;
COMPILE_DATE              (idx, [1:  20]) = 'Oct 28 2025 11:28:10' ;
DEBUG                     (idx, 1)        = 0 ;
TITLE                     (idx, [1:  53]) = 'A001_homo_U235_Th0.000_Pu0.000_U2330.000_U235E0.02000' ;
CONFIDENTIAL_DATA         (idx, 1)        = 0 ;
INPUT_FILE_NAME           (idx, [1:   8]) = 'A001.sss' ;
WORKING_DIRECTORY         (idx, [1:  30]) = '/home/sy_lu/Modular/cases/A001' ;
HOSTNAME                  (idx, [1:   6]) = 'master' ;
CPU_TYPE                  (idx, [1:  41]) = 'Intel(R) Xeon(R) Gold 6240R CPU @ 2.40GHz' ;
CPU_MHZ                   (idx, 1)        = 83900417.0 ;
START_DATE                (idx, [1:  24]) = 'Tue Apr 28 21:44:22 2026' ;
COMPLETE_DATE             (idx, [1:  24]) = 'Tue Apr 28 22:34:33 2026' ;

% Run parameters:

POP                       (idx, 1)        = 200000 ;
CYCLES                    (idx, 1)        = 500 ;
SKIP                      (idx, 1)        = 20 ;
BATCH_INTERVAL            (idx, 1)        = 1 ;
SRC_NORM_MODE             (idx, 1)        = 2 ;
SEED                      (idx, 1)        = 1777383862470 ;
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
OMP_THREADS               (idx, 1)        = 80 ;
MPI_REPRODUCIBILITY       (idx, 1)        = 0 ;
OMP_REPRODUCIBILITY       (idx, 1)        = 1 ;
OMP_HISTORY_PROFILE       (idx, [1:  80]) = [  1.10801E+00  9.38548E-01  9.77643E-01  9.48026E-01  1.07679E+00  9.79546E-01  1.04466E+00  9.63636E-01  1.05376E+00  9.39224E-01  1.07575E+00  9.37949E-01  1.06856E+00  9.69706E-01  1.06975E+00  9.48654E-01  1.06301E+00  9.45075E-01  9.34926E-01  1.03789E+00  1.07611E+00  9.65737E-01  1.05380E+00  9.47217E-01  9.89093E-01  1.06595E+00  9.35676E-01  9.53221E-01  1.07316E+00  1.07036E+00  9.47604E-01  1.07475E+00  1.04802E+00  9.34240E-01  9.59185E-01  1.07205E+00  9.44513E-01  9.67274E-01  9.50355E-01  1.07325E+00  9.54890E-01  1.05316E+00  9.54724E-01  9.42351E-01  1.00766E+00  1.06565E+00  1.05758E+00  9.74324E-01  1.03106E+00  1.07204E+00  9.49716E-01  9.64236E-01  1.07576E+00  9.44482E-01  1.06528E+00  1.06590E+00  1.05800E+00  9.49602E-01  9.61010E-01  9.61961E-01  9.34267E-01  1.06338E+00  1.05893E+00  9.60635E-01  9.44842E-01  9.47149E-01  1.06251E+00  9.48474E-01  9.48247E-01  9.75805E-01  9.56175E-01  9.36487E-01  9.32609E-01  9.74066E-01  9.58297E-01  1.05392E+00  1.06665E+00  1.04834E+00  9.60690E-01  9.76453E-01  ];
SHARE_BUF_ARRAY           (idx, 1)        = 0 ;
SHARE_RES2_ARRAY          (idx, 1)        = 1 ;
OMP_SHARED_QUEUE_LIM      (idx, 1)        = 0 ;

% File paths:

XS_DATA_FILE_PATH         (idx, [1:  42]) = '/home/sy_lu/data/endfb7/sss_endfb7u.xsdata' ;
DECAY_DATA_FILE_PATH      (idx, [1:  38]) = '/home/sy_lu/data/endfb7/sss_endfb7.dec' ;
SFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
NFY_DATA_FILE_PATH        (idx, [1:  38]) = '/home/sy_lu/data/endfb7/sss_endfb7.nfy' ;
BRA_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;

% Collision and reaction sampling (neutrons/photons):

MIN_MACROXS               (idx, [1:   4]) = [  5.00000E-02 0.0E+00  0.00000E+00 0.0E+00 ];
DT_THRESH                 (idx, [1:   2]) = [  9.00000E-01  9.00000E-01 ] ;
ST_FRAC                   (idx, [1:   4]) = [  2.42643E-02 0.00013  0.00000E+00 0.0E+00 ];
DT_FRAC                   (idx, [1:   4]) = [  9.75736E-01 3.3E-06  0.00000E+00 0.0E+00 ];
DT_EFF                    (idx, [1:   4]) = [  7.36145E-01 1.2E-05  0.00000E+00 0.0E+00 ];
REA_SAMPLING_EFF          (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
REA_SAMPLING_FAIL         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_COL_EFF               (idx, [1:   4]) = [  7.36637E-01 1.2E-05  0.00000E+00 0.0E+00 ];
AVG_TRACKING_LOOPS        (idx, [1:   8]) = [  3.04459E+00 5.6E-05  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
CELL_SEARCH_FRAC          (idx, [1:  10]) = [  9.24106E-01 7.6E-06  7.58860E-02 9.3E-05  8.12686E-06 0.00332  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
AVG_TRACKS                (idx, [1:   4]) = [  3.62911E+01 6.4E-05  0.00000E+00 0.0E+00 ];
AVG_REAL_COL              (idx, [1:   4]) = [  3.62911E+01 6.4E-05  0.00000E+00 0.0E+00 ];
AVG_VIRT_COL              (idx, [1:   4]) = [  1.29748E+01 8.5E-05  0.00000E+00 0.0E+00 ];
AVG_SURF_CROSS            (idx, [1:   4]) = [  3.38843E+00 9.2E-05  0.00000E+00 0.0E+00 ];
LOST_PARTICLES            (idx, 1)        = 0 ;

% Run statistics:

CYCLE_IDX                 (idx, 1)        = 500 ;
SIMULATED_HISTORIES       (idx, 1)        = 100000983 ;
MEAN_POP_SIZE             (idx, [1:   2]) = [  2.00002E+05 0.00014 ] ;
MEAN_POP_WGT              (idx, [1:   2]) = [  2.00002E+05 0.00014 ] ;
SIMULATION_COMPLETED      (idx, 1)        = 1 ;

% Running times:

TOT_CPU_TIME              (idx, 1)        =  1.57750E+03 ;
RUNNING_TIME              (idx, 1)        =  5.01917E+01 ;
INIT_TIME                 (idx, [1:   2]) = [  1.07990E+00  1.07990E+00 ] ;
PROCESS_TIME              (idx, [1:   2]) = [  2.51667E-02  2.51667E-02 ] ;
TRANSPORT_CYCLE_TIME      (idx, [1:   3]) = [  4.90859E+01  4.90859E+01  0.00000E+00 ] ;
BURNUP_CYCLE_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
BATEMAN_SOLUTION_TIME     (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
MPI_OVERHEAD_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
ESTIMATED_RUNNING_TIME    (idx, [1:   2]) = [  5.01877E+01  0.00000E+00 ] ;
CPU_USAGE                 (idx, 1)        = 31.42945 ;
TRANSPORT_CPU_USAGE       (idx, [1:   2]) = [  3.23320E+01 0.00097 ];
OMP_PARALLEL_FRAC         (idx, 1)        =  5.78199E-01 ;

% Memory usage:

AVAIL_MEM                 (idx, 1)        = 257551.17 ;
ALLOC_MEMSIZE             (idx, 1)        = 13955.87 ;
MEMSIZE                   (idx, 1)        = 13374.75 ;
XS_MEMSIZE                (idx, 1)        = 7212.92 ;
MAT_MEMSIZE               (idx, 1)        = 4774.38 ;
RES_MEMSIZE               (idx, 1)        = 50.52 ;
IFC_MEMSIZE               (idx, 1)        = 0.00 ;
MISC_MEMSIZE              (idx, 1)        = 1336.92 ;
UNKNOWN_MEMSIZE           (idx, 1)        = 0.00 ;
UNUSED_MEMSIZE            (idx, 1)        = 581.12 ;

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

TOT_ACTIVITY              (idx, 1)        =  1.65840E+07 ;
TOT_DECAY_HEAT            (idx, 1)        =  1.14624E-05 ;
TOT_SF_RATE               (idx, 1)        =  8.01655E+02 ;
ACTINIDE_ACTIVITY         (idx, 1)        =  1.65840E+07 ;
ACTINIDE_DECAY_HEAT       (idx, 1)        =  1.14624E-05 ;
FISSION_PRODUCT_ACTIVITY  (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_DECAY_HEAT(idx, 1)        =  0.00000E+00 ;
INHALATION_TOXICITY       (idx, 1)        =  1.33623E+02 ;
INGESTION_TOXICITY        (idx, 1)        =  7.50084E-01 ;
ACTINIDE_INH_TOX          (idx, 1)        =  1.33623E+02 ;
ACTINIDE_ING_TOX          (idx, 1)        =  7.50084E-01 ;
FISSION_PRODUCT_INH_TOX   (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ING_TOX   (idx, 1)        =  0.00000E+00 ;
SR90_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
TE132_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
I131_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
I132_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
CS134_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
CS137_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
PHOTON_DECAY_SOURCE       (idx, [1:   2]) = [  3.37833E+06  5.18849E-08 ] ;
NEUTRON_DECAY_SOURCE      (idx, 1)        =  0.00000E+00 ;
ALPHA_DECAY_SOURCE        (idx, 1)        =  1.65547E+07 ;
ELECTRON_DECAY_SOURCE     (idx, 1)        =  7.32728E+06 ;

% Normalization coefficient:

NORM_COEF                 (idx, [1:   4]) = [  1.38969E+10 0.00011  0.00000E+00 0.0E+00 ];

% Parameters for burnup calculation:

BURN_MATERIALS            (idx, 1)        = 264 ;
BURN_MODE                 (idx, 1)        = 2 ;
BURN_STEP                 (idx, 1)        = 0 ;
BURN_RANDOMIZE_DATA       (idx, [1:   3]) = [ 0 0 0 ] ;
BURNUP                    (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
BURN_DAYS                 (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
FIMA                      (idx, [1:   3]) = [  0.00000E+00  0.00000E+00  3.04761E+24 ] ;

% Analog reaction rate estimators:

CONVERSION_RATIO          (idx, [1:   2]) = [  5.36048E-01 0.00023 ];
U235_FISS                 (idx, [1:   4]) = [  1.33356E+15 0.00012  9.45566E-01 3.2E-05 ];
U238_FISS                 (idx, [1:   4]) = [  7.67695E+13 0.00059  5.44336E-02 0.00056 ];
U235_CAPT                 (idx, [1:   4]) = [  2.67305E+14 0.00031  1.94669E-01 0.00029 ];
U238_CAPT                 (idx, [1:   4]) = [  8.58168E+14 0.00021  6.24972E-01 0.00012 ];

% Neutron balance (particles/weight):

BALA_SRC_NEUTRON_SRC      (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_FISS     (idx, [1:   2]) = [ 100000983 1.00000E+08 ] ;
BALA_SRC_NEUTRON_NXN      (idx, [1:   2]) = [ 0 1.46852E+05 ] ;
BALA_SRC_NEUTRON_VR       (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_TOT      (idx, [1:   2]) = [ 100000983 1.00147E+08 ] ;

BALA_LOSS_NEUTRON_CAPT    (idx, [1:   2]) = [ 49330739 4.94042E+07 ] ;
BALA_LOSS_NEUTRON_FISS    (idx, [1:   2]) = [ 50670244 5.07426E+07 ] ;
BALA_LOSS_NEUTRON_LEAK    (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_CUT     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_ERR     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_TOT     (idx, [1:   2]) = [ 100000983 1.00147E+08 ] ;

BALA_NEUTRON_DIFF         (idx, [1:   2]) = [ 0 -6.67572E-06 ] ;

% Normalized total reaction rates (neutrons):

TOT_POWER                 (idx, [1:   6]) = [  4.57677E+04 4.4E-09  4.57677E+04 4.4E-09  0.00000E+00 0.0E+00 ];
TOT_POWDENS               (idx, [1:   6]) = [  3.80000E-02 0.0E+00  3.80000E-02 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_GENRATE               (idx, [1:   6]) = [  3.46560E+15 2.2E-06  3.46560E+15 2.2E-06  0.00000E+00 0.0E+00 ];
TOT_FISSRATE              (idx, [1:   6]) = [  1.41046E+15 2.7E-07  1.41046E+15 2.7E-07  0.00000E+00 0.0E+00 ];
TOT_CAPTRATE              (idx, [1:   6]) = [  1.37325E+15 8.8E-05  1.12962E+15 0.00010  2.43627E+14 8.8E-05 ];
TOT_ABSRATE               (idx, [1:   6]) = [  2.78371E+15 4.3E-05  2.54009E+15 4.6E-05  2.43627E+14 8.8E-05 ];
TOT_SRCRATE               (idx, [1:   6]) = [  2.77937E+15 0.00011  2.77937E+15 0.00011  0.00000E+00 0.0E+00 ];
TOT_FLUX                  (idx, [1:   6]) = [  1.32639E+17 8.8E-05  3.99385E+16 9.6E-05  9.27006E+16 9.0E-05 ];
TOT_PHOTON_PRODRATE       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_LEAKRATE              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
ALBEDO_LEAKRATE           (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_LOSSRATE              (idx, [1:   2]) = [  2.78371E+15 4.3E-05 ];
TOT_CUTRATE               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_RR                    (idx, [1:   2]) = [  1.01011E+17 7.2E-05 ];
INI_FMASS                 (idx, 1)        =  1.20441E+00 ;
TOT_FMASS                 (idx, 1)        =  1.20441E+00 ;
INI_BURN_FMASS            (idx, 1)        =  1.20441E+00 ;
TOT_BURN_FMASS            (idx, 1)        =  1.20441E+00 ;

% Six-factor formula:

SIX_FF_ETA                (idx, [1:   2]) = [  1.71550E+00 8.0E-05 ];
SIX_FF_F                  (idx, [1:   2]) = [  8.91563E-01 4.0E-05 ];
SIX_FF_P                  (idx, [1:   2]) = [  6.95890E-01 6.7E-05 ];
SIX_FF_EPSILON            (idx, [1:   2]) = [  1.17141E+00 5.8E-05 ];
SIX_FF_LF                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_LT                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_KINF               (idx, [1:   2]) = [  1.24679E+00 9.7E-05 ];
SIX_FF_KEFF               (idx, [1:   2]) = [  1.24679E+00 9.7E-05 ];

% Fission neutron and energy production:

NUBAR                     (idx, [1:   2]) = [  2.45706E+00 2.4E-06 ];
FISSE                     (idx, [1:   2]) = [  2.02529E+02 2.7E-07 ];

% Criticality eigenvalues:

ANA_KEFF                  (idx, [1:   6]) = [  1.24681E+00 9.8E-05  1.23828E+00 9.8E-05  8.50810E-03 0.00173 ];
IMP_KEFF                  (idx, [1:   2]) = [  1.24679E+00 4.3E-05 ];
COL_KEFF                  (idx, [1:   2]) = [  1.24691E+00 0.00011 ];
ABS_KEFF                  (idx, [1:   2]) = [  1.24679E+00 4.3E-05 ];
ABS_KINF                  (idx, [1:   2]) = [  1.24679E+00 4.3E-05 ];
GEOM_ALBEDO               (idx, [1:   6]) = [  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00 ];

% ALF (Average lethargy of neutrons causing fission):
% Based on E0 = 2.000000E+01 MeV

ANA_ALF                   (idx, [1:   2]) = [  1.81343E+01 3.4E-05 ];
IMP_ALF                   (idx, [1:   2]) = [  1.81353E+01 1.5E-05 ];

% EALF (Energy corresponding to average lethargy of neutrons causing fission):

ANA_EALF                  (idx, [1:   2]) = [  2.66355E-07 0.00061 ];
IMP_EALF                  (idx, [1:   2]) = [  2.66052E-07 0.00027 ];

% AFGE (Average energy of neutrons causing fission):

ANA_AFGE                  (idx, [1:   2]) = [  1.80715E-01 0.00061 ];
IMP_AFGE                  (idx, [1:   2]) = [  1.80472E-01 0.00026 ];

% Forward-weighted delayed neutron parameters:

PRECURSOR_GROUPS          (idx, 1)        = 6 ;
FWD_ANA_BETA_ZERO         (idx, [1:  14]) = [  5.66540E-03 0.00126  1.64194E-04 0.00716  9.07056E-04 0.00301  8.89175E-04 0.00299  2.59364E-03 0.00180  8.33097E-04 0.00306  2.78230E-04 0.00551 ];
FWD_ANA_LAMBDA            (idx, [1:  14]) = [  8.02204E-01 0.00291  1.24907E-02 4.8E-07  3.16726E-02 4.3E-05  1.10090E-01 5.4E-05  3.20213E-01 4.3E-05  1.34650E+00 3.3E-05  8.85524E+00 0.00030 ];

% Beta-eff using Meulekamp's method:

ADJ_MEULEKAMP_BETA_EFF    (idx, [1:  14]) = [  6.88401E-03 0.00172  1.98795E-04 0.01066  1.09927E-03 0.00443  1.08504E-03 0.00437  3.14855E-03 0.00240  1.01087E-03 0.00451  3.41485E-04 0.00777 ];
ADJ_MEULEKAMP_LAMBDA      (idx, [1:  14]) = [  8.06311E-01 0.00410  1.24907E-02 6.9E-07  3.16690E-02 6.2E-05  1.10089E-01 7.8E-05  3.20207E-01 6.7E-05  1.34652E+00 4.7E-05  8.85685E+00 0.00046 ];

% Adjoint weighted time constants using Nauchi's method:

IFP_CHAIN_LENGTH          (idx, 1)        = 15 ;
ADJ_NAUCHI_GEN_TIME       (idx, [1:   6]) = [  3.22307E-05 0.00021  3.22159E-05 0.00021  3.43821E-05 0.00213 ];
ADJ_NAUCHI_LIFETIME       (idx, [1:   6]) = [  4.01855E-05 0.00019  4.01670E-05 0.00019  4.28678E-05 0.00213 ];
ADJ_NAUCHI_BETA_EFF       (idx, [1:  14]) = [  6.82216E-03 0.00175  1.98288E-04 0.01030  1.09024E-03 0.00410  1.07043E-03 0.00424  3.12556E-03 0.00252  1.00136E-03 0.00435  3.36280E-04 0.00774 ];
ADJ_NAUCHI_LAMBDA         (idx, [1:  14]) = [  8.03561E-01 0.00408  1.24907E-02 6.7E-07  3.16702E-02 6.2E-05  1.10094E-01 7.6E-05  3.20198E-01 6.2E-05  1.34648E+00 4.9E-05  8.85595E+00 0.00042 ];

% Adjoint weighted time constants using IFP:

ADJ_IFP_GEN_TIME          (idx, [1:   6]) = [  3.22487E-05 0.00043  3.22328E-05 0.00043  3.45467E-05 0.00494 ];
ADJ_IFP_LIFETIME          (idx, [1:   6]) = [  4.02079E-05 0.00042  4.01881E-05 0.00042  4.30731E-05 0.00494 ];
ADJ_IFP_IMP_BETA_EFF      (idx, [1:  14]) = [  6.86873E-03 0.00481  1.96011E-04 0.02867  1.07984E-03 0.01315  1.08035E-03 0.01243  3.15541E-03 0.00720  1.02763E-03 0.01282  3.29486E-04 0.02223 ];
ADJ_IFP_IMP_LAMBDA        (idx, [1:  14]) = [  7.96414E-01 0.01155  1.24908E-02 2.0E-06  3.16643E-02 0.00020  1.10114E-01 0.00025  3.20154E-01 0.00019  1.34608E+00 0.00014  8.84851E+00 0.00123 ];
ADJ_IFP_ANA_BETA_EFF      (idx, [1:  14]) = [  6.86871E-03 0.00467  1.94523E-04 0.02754  1.07847E-03 0.01275  1.08221E-03 0.01211  3.16056E-03 0.00705  1.02502E-03 0.01240  3.27928E-04 0.02140 ];
ADJ_IFP_ANA_LAMBDA        (idx, [1:  14]) = [  7.93790E-01 0.01107  1.24908E-02 2.0E-06  3.16622E-02 0.00019  1.10114E-01 0.00024  3.20165E-01 0.00019  1.34614E+00 0.00014  8.84636E+00 0.00119 ];
ADJ_IFP_ROSSI_ALPHA       (idx, [1:   2]) = [ -2.13133E+02 0.00486 ];

% Adjoint weighted time constants using perturbation technique:

ADJ_PERT_GEN_TIME         (idx, [1:   2]) = [  3.22629E-05 0.00013 ];
ADJ_PERT_LIFETIME         (idx, [1:   2]) = [  4.02257E-05 7.7E-05 ];
ADJ_PERT_BETA_EFF         (idx, [1:   2]) = [  6.82751E-03 0.00093 ];
ADJ_PERT_ROSSI_ALPHA      (idx, [1:   2]) = [ -2.11621E+02 0.00093 ];

% Inverse neutron speed :

ANA_INV_SPD               (idx, [1:   2]) = [  6.84042E-07 9.9E-05 ];

% Analog slowing-down and thermal neutron lifetime (total/prompt/delayed):

ANA_SLOW_TIME             (idx, [1:   6]) = [  2.85013E-06 8.6E-05  2.85016E-06 8.6E-05  2.84612E-06 0.00104 ];
ANA_THERM_TIME            (idx, [1:   6]) = [  4.37346E-05 0.00012  4.37347E-05 0.00012  4.37212E-05 0.00136 ];
ANA_THERM_FRAC            (idx, [1:   6]) = [  6.96187E-01 6.7E-05  6.95050E-01 6.8E-05  8.96511E-01 0.00200 ];
ANA_DELAYED_EMTIME        (idx, [1:   2]) = [  1.03568E+01 0.00286 ];
ANA_MEAN_NCOL             (idx, [1:   4]) = [  3.62911E+01 6.4E-05  4.07194E+01 8.0E-05 ];

% Group constant generation:

GC_UNIVERSE_NAME          (idx, [1:   4]) = '1001' ;

% Micro- and macro-group structures:

MICRO_NG                  (idx, 1)        = 70 ;
MICRO_E                   (idx, [1:  71]) = [  2.00000E+01  6.06550E+00  3.67900E+00  2.23100E+00  1.35300E+00  8.21000E-01  5.00000E-01  3.02500E-01  1.83000E-01  1.11000E-01  6.74300E-02  4.08500E-02  2.47800E-02  1.50300E-02  9.11800E-03  5.50000E-03  3.51910E-03  2.23945E-03  1.42510E-03  9.06898E-04  3.67262E-04  1.48728E-04  7.55014E-05  4.80520E-05  2.77000E-05  1.59680E-05  9.87700E-06  4.00000E-06  3.30000E-06  2.60000E-06  2.10000E-06  1.85500E-06  1.50000E-06  1.30000E-06  1.15000E-06  1.12300E-06  1.09700E-06  1.07100E-06  1.04500E-06  1.02000E-06  9.96000E-07  9.72000E-07  9.50000E-07  9.10000E-07  8.50000E-07  7.80000E-07  6.25000E-07  5.00000E-07  4.00000E-07  3.50000E-07  3.20000E-07  3.00000E-07  2.80000E-07  2.50000E-07  2.20000E-07  1.80000E-07  1.40000E-07  1.00000E-07  8.00000E-08  6.70000E-08  5.80000E-08  5.00000E-08  4.20000E-08  3.50000E-08  3.00000E-08  2.50000E-08  2.00000E-08  1.50000E-08  1.00000E-08  5.00000E-09  1.00000E-11 ];

MACRO_NG                  (idx, 1)        = 2 ;
MACRO_E                   (idx, [1:   3]) = [  1.00000E+37  6.25000E-07  0.00000E+00 ];

% Micro-group spectrum:

INF_MICRO_FLX             (idx, [1: 140]) = [  1.38355E+06 0.00094  5.56574E+06 0.00030  1.15150E+07 0.00020  1.25177E+07 0.00017  1.15541E+07 0.00017  1.24095E+07 0.00016  8.45779E+06 0.00015  7.48495E+06 0.00016  5.73285E+06 0.00019  4.68027E+06 0.00017  4.04138E+06 0.00021  3.64293E+06 0.00021  3.36659E+06 0.00022  3.20148E+06 0.00022  3.12175E+06 0.00020  2.69796E+06 0.00021  2.66657E+06 0.00017  2.64535E+06 0.00027  2.60096E+06 0.00023  5.08660E+06 0.00014  4.91984E+06 0.00017  3.56518E+06 0.00018  2.31920E+06 0.00022  2.68501E+06 0.00023  2.54360E+06 0.00023  2.32857E+06 0.00028  3.83725E+06 0.00017  8.78852E+05 0.00036  1.10339E+06 0.00032  1.00244E+06 0.00037  5.82784E+05 0.00049  1.01284E+06 0.00036  6.88765E+05 0.00041  5.89535E+05 0.00048  1.12928E+05 0.00099  1.12078E+05 0.00100  1.14823E+05 0.00068  1.18108E+05 0.00094  1.17337E+05 0.00095  1.15382E+05 0.00083  1.19316E+05 0.00083  1.12027E+05 0.00078  2.11450E+05 0.00053  3.37724E+05 0.00052  4.29803E+05 0.00037  1.13328E+06 0.00038  1.18424E+06 0.00031  1.25266E+06 0.00032  8.18749E+05 0.00041  6.03381E+05 0.00043  4.71305E+05 0.00035  5.48030E+05 0.00047  9.96314E+05 0.00027  1.37201E+06 0.00037  2.72173E+06 0.00023  4.43366E+06 0.00018  7.02925E+06 0.00015  4.76717E+06 0.00020  3.53299E+06 0.00019  2.60733E+06 0.00018  2.36452E+06 0.00023  2.37972E+06 0.00020  2.02740E+06 0.00024  1.38197E+06 0.00021  1.29521E+06 0.00031  1.15800E+06 0.00025  1.01104E+06 0.00025  7.78386E+05 0.00022  5.13049E+05 0.00029  1.78401E+05 0.00044 ];

% Integral parameters:

INF_KINF                  (idx, [1:   2]) = [  1.24691E+00 0.00010 ];

% Flux spectra in infinite geometry:

INF_FLX                   (idx, [1:   4]) = [  1.01075E+17 0.00011  3.15643E+16 7.4E-05 ];
INF_FISS_FLX              (idx, [1:   4]) = [  3.10006E+16 0.00012  8.93803E+15 3.9E-05 ];

% Reaction cross sections:

INF_TOT                   (idx, [1:   4]) = [  5.59021E-01 2.5E-05  1.41008E+00 3.4E-05 ];
INF_CAPT                  (idx, [1:   4]) = [  6.46132E-03 0.00014  2.28161E-02 3.9E-05 ];
INF_ABS                   (idx, [1:   4]) = [  8.40236E-03 0.00012  6.12863E-02 5.7E-05 ];
INF_FISS                  (idx, [1:   4]) = [  1.94104E-03 0.00012  3.84701E-02 6.8E-05 ];
INF_NSF                   (idx, [1:   4]) = [  5.01384E-03 0.00011  9.37402E-02 6.8E-05 ];
INF_NUBAR                 (idx, [1:   4]) = [  2.58308E+00 1.6E-05  2.43670E+00 0.0E+00 ];
INF_KAPPA                 (idx, [1:   4]) = [  2.04128E+02 1.6E-06  2.02270E+02 0.0E+00 ];
INF_INVV                  (idx, [1:   4]) = [  6.08726E-08 7.3E-05  2.67956E-06 2.5E-05 ];

% Total scattering cross sections:

INF_SCATT0                (idx, [1:   4]) = [  5.50618E-01 2.5E-05  1.34880E+00 3.6E-05 ];
INF_SCATT1                (idx, [1:   4]) = [  2.53804E-01 4.2E-05  3.44550E-01 7.7E-05 ];
INF_SCATT2                (idx, [1:   4]) = [  9.97288E-02 5.1E-05  8.18637E-02 0.00018 ];
INF_SCATT3                (idx, [1:   4]) = [  7.53175E-03 0.00061  2.45833E-02 0.00062 ];
INF_SCATT4                (idx, [1:   4]) = [ -1.08180E-02 0.00050 -7.26829E-03 0.00141 ];
INF_SCATT5                (idx, [1:   4]) = [  1.02308E-04 0.03796  5.76549E-03 0.00184 ];
INF_SCATT6                (idx, [1:   4]) = [  5.23602E-03 0.00063 -1.43689E-02 0.00089 ];
INF_SCATT7                (idx, [1:   4]) = [  7.73313E-04 0.00449  4.13735E-04 0.02482 ];

% Total scattering production cross sections:

INF_SCATTP0               (idx, [1:   4]) = [  5.50659E-01 2.5E-05  1.34880E+00 3.6E-05 ];
INF_SCATTP1               (idx, [1:   4]) = [  2.53805E-01 4.2E-05  3.44550E-01 7.7E-05 ];
INF_SCATTP2               (idx, [1:   4]) = [  9.97291E-02 5.1E-05  8.18637E-02 0.00018 ];
INF_SCATTP3               (idx, [1:   4]) = [  7.53178E-03 0.00060  2.45833E-02 0.00062 ];
INF_SCATTP4               (idx, [1:   4]) = [ -1.08180E-02 0.00050 -7.26829E-03 0.00141 ];
INF_SCATTP5               (idx, [1:   4]) = [  1.02207E-04 0.03794  5.76549E-03 0.00184 ];
INF_SCATTP6               (idx, [1:   4]) = [  5.23602E-03 0.00063 -1.43689E-02 0.00089 ];
INF_SCATTP7               (idx, [1:   4]) = [  7.73259E-04 0.00450  4.13735E-04 0.02482 ];

% Diffusion parameters:

INF_TRANSPXS              (idx, [1:   4]) = [  2.22626E-01 6.2E-05  9.39551E-01 3.8E-05 ];
INF_DIFFCOEF              (idx, [1:   4]) = [  1.49728E+00 6.2E-05  3.54779E-01 3.8E-05 ];

% Reduced absoption and removal:

INF_RABSXS                (idx, [1:   4]) = [  8.36198E-03 0.00012  6.12863E-02 5.7E-05 ];
INF_REMXS                 (idx, [1:   4]) = [  2.78385E-02 5.0E-05  6.22367E-02 0.00011 ];

% Poison cross sections:

INF_I135_YIELD            (idx, [1:   4]) = [  6.53937E-02 7.1E-06  6.28187E-02 0.0E+00 ];
INF_XE135_YIELD           (idx, [1:   4]) = [  1.66832E-03 9.7E-05  2.56634E-03 2.7E-09 ];
INF_PM147_YIELD           (idx, [1:   4]) = [  1.52785E-11 0.00011  2.48982E-11 2.7E-09 ];
INF_PM148_YIELD           (idx, [1:   4]) = [  2.95017E-11 9.2E-05  4.44968E-11 2.7E-09 ];
INF_PM148M_YIELD          (idx, [1:   4]) = [  5.58267E-11 8.1E-05  8.09942E-11 4.7E-09 ];
INF_PM149_YIELD           (idx, [1:   4]) = [  1.29411E-02 3.0E-05  1.08163E-02 0.0E+00 ];
INF_SM149_YIELD           (idx, [1:   4]) = [  1.04773E-12 0.00011  1.70988E-12 2.7E-09 ];
INF_I135_MICRO_ABS        (idx, [1:   4]) = [  9.95208E-01 0.00018  4.33225E+01 6.8E-05 ];
INF_XE135_MICRO_ABS       (idx, [1:   4]) = [  1.41358E+02 0.00032  1.69747E+06 6.4E-05 ];
INF_PM147_MICRO_ABS       (idx, [1:   4]) = [  6.08332E+01 0.00067  8.95492E+01 6.8E-05 ];
INF_PM148_MICRO_ABS       (idx, [1:   4]) = [  9.19409E+01 0.00018  1.08441E+03 6.9E-05 ];
INF_PM148M_MICRO_ABS      (idx, [1:   4]) = [  1.44355E+02 0.00018  1.80188E+04 0.00012 ];
INF_PM149_MICRO_ABS       (idx, [1:   4]) = [  5.01441E+01 0.00019  7.59094E+02 6.9E-05 ];
INF_SM149_MICRO_ABS       (idx, [1:   4]) = [  1.10622E+02 0.00039  4.91740E+04 8.9E-05 ];
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

INF_S0                    (idx, [1:   8]) = [  5.31183E-01 2.4E-05  1.94356E-02 8.1E-05  9.60572E-04 0.00102  1.34784E+00 3.6E-05 ];
INF_S1                    (idx, [1:   8]) = [  2.48073E-01 4.2E-05  5.73106E-03 0.00021  3.51275E-04 0.00204  3.44199E-01 7.8E-05 ];
INF_S2                    (idx, [1:   8]) = [  1.01418E-01 4.9E-05 -1.68892E-03 0.00062  2.10818E-04 0.00251  8.16529E-02 0.00018 ];
INF_S3                    (idx, [1:   8]) = [  9.58465E-03 0.00050 -2.05290E-03 0.00038  9.12875E-05 0.00340  2.44920E-02 0.00063 ];
INF_S4                    (idx, [1:   8]) = [ -1.01309E-02 0.00053 -6.87120E-04 0.00122  1.52960E-05 0.01637 -7.28359E-03 0.00141 ];
INF_S5                    (idx, [1:   8]) = [  8.41972E-05 0.04321  1.81104E-05 0.03200 -2.06838E-05 0.01193  5.78617E-03 0.00182 ];
INF_S6                    (idx, [1:   8]) = [  5.38113E-03 0.00061 -1.45101E-04 0.00404 -3.32470E-05 0.00803 -1.43357E-02 0.00089 ];
INF_S7                    (idx, [1:   8]) = [  9.52766E-04 0.00362 -1.79453E-04 0.00272 -3.42696E-05 0.00825  4.48005E-04 0.02286 ];

% Scattering production matrixes:

INF_SP0                   (idx, [1:   8]) = [  5.31223E-01 2.4E-05  1.94356E-02 8.1E-05  9.60572E-04 0.00102  1.34784E+00 3.6E-05 ];
INF_SP1                   (idx, [1:   8]) = [  2.48073E-01 4.2E-05  5.73106E-03 0.00021  3.51275E-04 0.00204  3.44199E-01 7.8E-05 ];
INF_SP2                   (idx, [1:   8]) = [  1.01418E-01 4.9E-05 -1.68892E-03 0.00062  2.10818E-04 0.00251  8.16529E-02 0.00018 ];
INF_SP3                   (idx, [1:   8]) = [  9.58469E-03 0.00050 -2.05290E-03 0.00038  9.12875E-05 0.00340  2.44920E-02 0.00063 ];
INF_SP4                   (idx, [1:   8]) = [ -1.01309E-02 0.00053 -6.87120E-04 0.00122  1.52960E-05 0.01637 -7.28359E-03 0.00141 ];
INF_SP5                   (idx, [1:   8]) = [  8.40964E-05 0.04320  1.81104E-05 0.03200 -2.06838E-05 0.01193  5.78617E-03 0.00182 ];
INF_SP6                   (idx, [1:   8]) = [  5.38112E-03 0.00061 -1.45101E-04 0.00404 -3.32470E-05 0.00803 -1.43357E-02 0.00089 ];
INF_SP7                   (idx, [1:   8]) = [  9.52712E-04 0.00363 -1.79453E-04 0.00272 -3.42696E-05 0.00825  4.48005E-04 0.02286 ];

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

CMM_TRANSPXS              (idx, [1:   4]) = [  2.36920E-01 0.00013  8.54022E-01 0.00045 ];
CMM_TRANSPXS_X            (idx, [1:   4]) = [  2.37021E-01 0.00021  8.56796E-01 0.00060 ];
CMM_TRANSPXS_Y            (idx, [1:   4]) = [  2.36997E-01 0.00017  8.56925E-01 0.00059 ];
CMM_TRANSPXS_Z            (idx, [1:   4]) = [  2.36742E-01 0.00019  8.48416E-01 0.00080 ];
CMM_DIFFCOEF              (idx, [1:   4]) = [  1.40695E+00 0.00013  3.90312E-01 0.00045 ];
CMM_DIFFCOEF_X            (idx, [1:   4]) = [  1.40635E+00 0.00021  3.89050E-01 0.00060 ];
CMM_DIFFCOEF_Y            (idx, [1:   4]) = [  1.40649E+00 0.00017  3.88991E-01 0.00059 ];
CMM_DIFFCOEF_Z            (idx, [1:   4]) = [  1.40800E+00 0.00019  3.92895E-01 0.00080 ];

% Delayed neutron parameters (Meulekamp method):

BETA_EFF                  (idx, [1:  14]) = [  6.88401E-03 0.00172  1.98795E-04 0.01066  1.09927E-03 0.00443  1.08504E-03 0.00437  3.14855E-03 0.00240  1.01087E-03 0.00451  3.41485E-04 0.00777 ];
LAMBDA                    (idx, [1:  14]) = [  8.06311E-01 0.00410  1.24907E-02 6.9E-07  3.16690E-02 6.2E-05  1.10089E-01 7.8E-05  3.20207E-01 6.7E-05  1.34652E+00 4.7E-05  8.85685E+00 0.00046 ];

% Pin-power distribution:

PPW_LATTICE               (idx, [1:   4]) = '1000' ;
PPW_LATTICE_TYPE          (idx, 1)        = 1 ;
PPW_PINS                  (idx, 1)        = 289 ;
PPW_POW                   (idx, [1: 1156]) = [  5.28751E-04 0.00186  3.05193E-03 0.00165  5.29875E-04 0.00197  3.03327E-03 0.00179  5.30028E-04 0.00197  3.05218E-03 0.00150  5.30421E-04 0.00185  3.09001E-03 0.00182  5.31681E-04 0.00138  3.13246E-03 0.00161  5.31349E-04 0.00151  3.16624E-03 0.00111  5.29226E-04 0.00155  3.14563E-03 0.00215  5.30132E-04 0.00178  3.15546E-03 0.00143  5.29524E-04 0.00174  3.16919E-03 0.00157  5.28853E-04 0.00190  3.16231E-03 0.00170  5.29256E-04 0.00168  3.16111E-03 0.00202  5.31040E-04 0.00188  3.16797E-03 0.00159  5.29365E-04 0.00191  3.13091E-03 0.00203  5.27991E-04 0.00147  3.08378E-03 0.00147  5.27175E-04 0.00156  3.05087E-03 0.00156  5.28331E-04 0.00202  3.03516E-03 0.00173  5.27721E-04 0.00150  3.04212E-03 0.00157  5.27625E-04 0.00181  3.03633E-03 0.00136  5.30652E-04 0.00241  3.02357E-03 0.00162  5.29944E-04 0.00182  3.06239E-03 0.00162  5.31613E-04 0.00189  3.13565E-03 0.00146  5.29547E-04 0.00178  3.18602E-03 0.00209  5.30179E-04 0.00182  3.28517E-03 0.00170  5.32334E-04 0.00170  3.21351E-03 0.00189  5.32605E-04 0.00160  3.21575E-03 0.00174  5.30761E-04 0.00117  3.29180E-03 0.00138  5.28347E-04 0.00146  3.20904E-03 0.00134  5.30678E-04 0.00187  3.20750E-03 0.00185  5.30992E-04 0.00135  3.28438E-03 0.00162  5.30128E-04 0.00147  3.19483E-03 0.00164  5.29498E-04 0.00194  3.12851E-03 0.00175  5.29746E-04 0.00152  3.06172E-03 0.00204  5.29805E-04 0.00154  3.02127E-03 0.00179  5.27826E-04 0.00178  3.02788E-03 0.00143  5.29569E-04 0.00196  3.05062E-03 0.00197  5.28757E-04 0.00157  3.05896E-03 0.00121  5.29555E-04 0.00178  3.15847E-03 0.00102  5.31816E-04 0.00174  3.31323E-03 0.00172  5.32257E-04 0.00176  3.36991E-03 0.00161  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.33002E-04 0.00160  3.35685E-03 0.00119  5.31698E-04 0.00174  3.35154E-03 0.00140  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.30837E-04 0.00179  3.34874E-03 0.00140  5.30303E-04 0.00170  3.35896E-03 0.00143  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32664E-04 0.00152  3.37098E-03 0.00175  5.31460E-04 0.00206  3.30010E-03 0.00127  5.29568E-04 0.00215  3.14766E-03 0.00196  5.29254E-04 0.00119  3.05399E-03 0.00097  5.26758E-04 0.00160  3.04134E-03 0.00134  5.30194E-04 0.00181  3.09006E-03 0.00189  5.30259E-04 0.00133  3.12707E-03 0.00176  5.30828E-04 0.00194  3.31765E-03 0.00151  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.31882E-04 0.00156  3.43296E-03 0.00168  5.33100E-04 0.00132  3.41732E-03 0.00135  5.31604E-04 0.00150  3.29939E-03 0.00173  5.31843E-04 0.00152  3.28734E-03 0.00159  5.32861E-04 0.00157  3.37897E-03 0.00132  5.31204E-04 0.00155  3.29141E-03 0.00135  5.31385E-04 0.00139  3.29614E-03 0.00168  5.30662E-04 0.00178  3.42219E-03 0.00192  5.32900E-04 0.00202  3.43227E-03 0.00161  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.31054E-04 0.00165  3.30697E-03 0.00217  5.29724E-04 0.00186  3.12610E-03 0.00161  5.28941E-04 0.00176  3.08798E-03 0.00185  5.31160E-04 0.00179  3.14096E-03 0.00211  5.31081E-04 0.00180  3.19654E-03 0.00149  5.33480E-04 0.00148  3.37496E-03 0.00147  5.33574E-04 0.00166  3.43325E-03 0.00144  5.33087E-04 0.00172  3.37266E-03 0.00191  5.32458E-04 0.00199  3.43918E-03 0.00188  5.30334E-04 0.00162  3.31442E-03 0.00128  5.31578E-04 0.00159  3.30089E-03 0.00119  5.33125E-04 0.00175  3.38575E-03 0.00148  5.30689E-04 0.00178  3.31040E-03 0.00145  5.31332E-04 0.00155  3.31017E-03 0.00177  5.32361E-04 0.00203  3.42100E-03 0.00157  5.31477E-04 0.00171  3.38039E-03 0.00142  5.32630E-04 0.00136  3.43068E-03 0.00156  5.30483E-04 0.00122  3.37077E-03 0.00180  5.30880E-04 0.00170  3.19078E-03 0.00153  5.30355E-04 0.00207  3.12726E-03 0.00144  5.31285E-04 0.00155  3.16973E-03 0.00193  5.31128E-04 0.00178  3.28825E-03 0.00178  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32474E-04 0.00159  3.42476E-03 0.00151  5.33456E-04 0.00247  3.42642E-03 0.00147  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32173E-04 0.00187  3.40389E-03 0.00114  5.32481E-04 0.00184  3.39597E-03 0.00122  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.31761E-04 0.00158  3.40334E-03 0.00142  5.32540E-04 0.00154  3.40232E-03 0.00149  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.33081E-04 0.00199  3.42203E-03 0.00138  5.32967E-04 0.00172  3.42058E-03 0.00154  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.29829E-04 0.00208  3.29240E-03 0.00129  5.30589E-04 0.00146  3.15651E-03 0.00175  5.29445E-04 0.00177  3.16536E-03 0.00159  5.30549E-04 0.00176  3.20748E-03 0.00139  5.31670E-04 0.00168  3.35494E-03 0.00143  5.31637E-04 0.00160  3.29807E-03 0.00155  5.31215E-04 0.00194  3.31530E-03 0.00179  5.33669E-04 0.00132  3.40430E-03 0.00145  5.30170E-04 0.00130  3.30397E-03 0.00181  5.31955E-04 0.00153  3.30922E-03 0.00149  5.32011E-04 0.00230  3.40278E-03 0.00163  5.33122E-04 0.00178  3.31052E-03 0.00144  5.31347E-04 0.00160  3.31297E-03 0.00129  5.30528E-04 0.00157  3.39668E-03 0.00156  5.30143E-04 0.00183  3.31142E-03 0.00181  5.31866E-04 0.00144  3.29223E-03 0.00134  5.31553E-04 0.00194  3.35507E-03 0.00187  5.30539E-04 0.00148  3.21619E-03 0.00185  5.31271E-04 0.00157  3.16233E-03 0.00144  5.30902E-04 0.00247  3.16129E-03 0.00155  5.31181E-04 0.00137  3.21395E-03 0.00169  5.31481E-04 0.00176  3.35280E-03 0.00145  5.30803E-04 0.00145  3.28690E-03 0.00145  5.30911E-04 0.00175  3.30194E-03 0.00137  5.34060E-04 0.00177  3.39694E-03 0.00182  5.29695E-04 0.00186  3.31875E-03 0.00215  5.29940E-04 0.00151  3.30731E-03 0.00167  5.33915E-04 0.00162  3.40454E-03 0.00155  5.31555E-04 0.00175  3.31043E-03 0.00148  5.31734E-04 0.00181  3.30899E-03 0.00137  5.32969E-04 0.00151  3.40776E-03 0.00166  5.31723E-04 0.00210  3.30236E-03 0.00163  5.32455E-04 0.00170  3.28486E-03 0.00214  5.31750E-04 0.00158  3.36171E-03 0.00174  5.29259E-04 0.00174  3.22245E-03 0.00196  5.30943E-04 0.00120  3.16794E-03 0.00158  5.31286E-04 0.00146  3.16995E-03 0.00140  5.32098E-04 0.00134  3.28349E-03 0.00171  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.31383E-04 0.00180  3.37277E-03 0.00166  5.32088E-04 0.00215  3.39679E-03 0.00177  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.33183E-04 0.00157  3.39584E-03 0.00178  5.32448E-04 0.00129  3.40203E-03 0.00123  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32422E-04 0.00169  3.40421E-03 0.00126  5.31817E-04 0.00204  3.39128E-03 0.00145  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32694E-04 0.00185  3.39080E-03 0.00155  5.31958E-04 0.00131  3.37206E-03 0.00134  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.31629E-04 0.00172  3.29870E-03 0.00196  5.31829E-04 0.00201  3.17166E-03 0.00185  5.29372E-04 0.00176  3.15918E-03 0.00152  5.30733E-04 0.00186  3.21750E-03 0.00144  5.30731E-04 0.00173  3.34339E-03 0.00165  5.32474E-04 0.00184  3.28948E-03 0.00163  5.32683E-04 0.00128  3.29587E-03 0.00119  5.32307E-04 0.00161  3.38985E-03 0.00157  5.30978E-04 0.00142  3.31102E-03 0.00144  5.31989E-04 0.00157  3.31433E-03 0.00131  5.31501E-04 0.00151  3.39279E-03 0.00147  5.32307E-04 0.00140  3.31504E-03 0.00156  5.30713E-04 0.00163  3.30520E-03 0.00108  5.31325E-04 0.00131  3.39567E-03 0.00209  5.32028E-04 0.00187  3.31132E-03 0.00135  5.32362E-04 0.00176  3.28491E-03 0.00182  5.31479E-04 0.00124  3.34572E-03 0.00156  5.30492E-04 0.00111  3.21984E-03 0.00157  5.31141E-04 0.00186  3.16349E-03 0.00192  5.30644E-04 0.00164  3.15948E-03 0.00179  5.30695E-04 0.00147  3.21790E-03 0.00126  5.33504E-04 0.00205  3.36188E-03 0.00139  5.31739E-04 0.00161  3.29787E-03 0.00164  5.31063E-04 0.00202  3.31032E-03 0.00149  5.32557E-04 0.00169  3.40018E-03 0.00190  5.32026E-04 0.00202  3.30983E-03 0.00150  5.30656E-04 0.00174  3.31153E-03 0.00178  5.32324E-04 0.00163  3.39781E-03 0.00146  5.32160E-04 0.00143  3.30474E-03 0.00141  5.32439E-04 0.00179  3.30853E-03 0.00128  5.33022E-04 0.00132  3.39838E-03 0.00138  5.31341E-04 0.00127  3.30755E-03 0.00201  5.32489E-04 0.00169  3.30158E-03 0.00157  5.32699E-04 0.00112  3.36135E-03 0.00171  5.31743E-04 0.00198  3.21322E-03 0.00182  5.30762E-04 0.00159  3.15942E-03 0.00159  5.31242E-04 0.00165  3.15805E-03 0.00144  5.30454E-04 0.00155  3.28628E-03 0.00193  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.33641E-04 0.00137  3.41116E-03 0.00133  5.31520E-04 0.00157  3.42545E-03 0.00151  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.33069E-04 0.00188  3.40796E-03 0.00193  5.32965E-04 0.00190  3.40701E-03 0.00130  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32680E-04 0.00183  3.40106E-03 0.00156  5.33490E-04 0.00194  3.39878E-03 0.00142  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.33001E-04 0.00193  3.42192E-03 0.00158  5.30645E-04 0.00152  3.42169E-03 0.00187  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.31778E-04 0.00143  3.29060E-03 0.00155  5.31702E-04 0.00166  3.16359E-03 0.00133  5.28815E-04 0.00185  3.12734E-03 0.00186  5.30459E-04 0.00166  3.19390E-03 0.00144  5.31578E-04 0.00203  3.37208E-03 0.00176  5.32956E-04 0.00152  3.43271E-03 0.00152  5.32443E-04 0.00156  3.37681E-03 0.00173  5.33560E-04 0.00127  3.42911E-03 0.00132  5.32636E-04 0.00146  3.31822E-03 0.00191  5.31905E-04 0.00143  3.30347E-03 0.00174  5.31629E-04 0.00158  3.39105E-03 0.00125  5.31596E-04 0.00180  3.30682E-03 0.00183  5.30701E-04 0.00160  3.31555E-03 0.00182  5.31141E-04 0.00176  3.42335E-03 0.00125  5.32076E-04 0.00196  3.36812E-03 0.00150  5.31798E-04 0.00195  3.42632E-03 0.00157  5.30151E-04 0.00190  3.37391E-03 0.00175  5.30392E-04 0.00202  3.19490E-03 0.00150  5.29676E-04 0.00197  3.14077E-03 0.00133  5.30361E-04 0.00172  3.09070E-03 0.00213  5.30964E-04 0.00192  3.12453E-03 0.00187  5.30377E-04 0.00161  3.30728E-03 0.00147  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32442E-04 0.00176  3.43721E-03 0.00141  5.33280E-04 0.00161  3.41885E-03 0.00147  5.30496E-04 0.00159  3.30462E-03 0.00170  5.31893E-04 0.00172  3.29445E-03 0.00136  5.31625E-04 0.00162  3.37246E-03 0.00142  5.33242E-04 0.00163  3.27393E-03 0.00161  5.30506E-04 0.00176  3.29202E-03 0.00144  5.32881E-04 0.00213  3.41065E-03 0.00142  5.29906E-04 0.00199  3.42930E-03 0.00160  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.30930E-04 0.00154  3.30501E-03 0.00140  5.30196E-04 0.00132  3.12408E-03 0.00144  5.30892E-04 0.00206  3.07809E-03 0.00129  5.28997E-04 0.00174  3.05308E-03 0.00147  5.28186E-04 0.00155  3.05949E-03 0.00163  5.29149E-04 0.00191  3.15397E-03 0.00132  5.32860E-04 0.00217  3.31371E-03 0.00175  5.29914E-04 0.00128  3.37197E-03 0.00171  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32329E-04 0.00187  3.34710E-03 0.00156  5.32813E-04 0.00199  3.34487E-03 0.00135  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32707E-04 0.00139  3.35793E-03 0.00144  5.32055E-04 0.00201  3.34595E-03 0.00164  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  5.32447E-04 0.00153  3.37213E-03 0.00194  5.32972E-04 0.00182  3.31095E-03 0.00117  5.28513E-04 0.00191  3.15464E-03 0.00136  5.28937E-04 0.00143  3.06441E-03 0.00174  5.30543E-04 0.00147  3.04370E-03 0.00156  5.29116E-04 0.00185  3.02609E-03 0.00148  5.26689E-04 0.00151  3.02115E-03 0.00172  5.27109E-04 0.00148  3.06195E-03 0.00199  5.30753E-04 0.00154  3.12309E-03 0.00168  5.32247E-04 0.00199  3.19364E-03 0.00158  5.31945E-04 0.00189  3.28868E-03 0.00156  5.30771E-04 0.00185  3.21112E-03 0.00201  5.31851E-04 0.00149  3.21468E-03 0.00161  5.30652E-04 0.00182  3.29749E-03 0.00172  5.31934E-04 0.00164  3.21726E-03 0.00143  5.30535E-04 0.00203  3.22248E-03 0.00110  5.30047E-04 0.00159  3.28927E-03 0.00137  5.29193E-04 0.00175  3.19277E-03 0.00167  5.30815E-04 0.00174  3.12682E-03 0.00177  5.30071E-04 0.00149  3.05667E-03 0.00143  5.28568E-04 0.00145  3.02149E-03 0.00199  5.29447E-04 0.00182  3.03157E-03 0.00146  5.28356E-04 0.00168  3.04802E-03 0.00224  5.28321E-04 0.00138  3.01915E-03 0.00172  5.30146E-04 0.00120  3.05736E-03 0.00217  5.29382E-04 0.00168  3.08724E-03 0.00133  5.29059E-04 0.00154  3.12993E-03 0.00141  5.30774E-04 0.00174  3.15012E-03 0.00189  5.30042E-04 0.00170  3.15478E-03 0.00194  5.30371E-04 0.00162  3.16279E-03 0.00108  5.30181E-04 0.00201  3.17790E-03 0.00155  5.29841E-04 0.00195  3.15879E-03 0.00106  5.28394E-04 0.00170  3.14923E-03 0.00168  5.30084E-04 0.00180  3.16360E-03 0.00151  5.28752E-04 0.00201  3.12240E-03 0.00171  5.28387E-04 0.00172  3.07829E-03 0.00152  5.30697E-04 0.00164  3.05800E-03 0.00134  5.27529E-04 0.00181  3.02933E-03 0.00123  5.28049E-04 0.00158  3.04466E-03 0.00198 ];
PPW_HOM_FLUX              (idx, [1: 1156]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
PPW_FF                    (idx, [1: 1156]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];