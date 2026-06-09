
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
TITLE                     (idx, [1:  63]) = 'A008_d076_homo_U235_Th0.600_Pu0.000_U2330.000_U235E0.03000_w076' ;
CONFIDENTIAL_DATA         (idx, 1)        = 0 ;
INPUT_FILE_NAME           (idx, [1:  13]) = 'A008_d076.sss' ;
WORKING_DIRECTORY         (idx, [1:  25]) = '/home/sy_lu/test/nodl1000' ;
HOSTNAME                  (idx, [1:  17]) = 'tjzs-MZ73-LM1-000' ;
CPU_TYPE                  (idx, [1:  31]) = 'AMD EPYC 9V74 80-Core Processor' ;
CPU_MHZ                   (idx, 1)        = 168825172.0 ;
START_DATE                (idx, [1:  24]) = 'Mon Jun  8 10:04:16 2026' ;
COMPLETE_DATE             (idx, [1:  24]) = 'Mon Jun  8 10:18:51 2026' ;

% Run parameters:

POP                       (idx, 1)        = 200000 ;
CYCLES                    (idx, 1)        = 500 ;
SKIP                      (idx, 1)        = 20 ;
BATCH_INTERVAL            (idx, 1)        = 1 ;
SRC_NORM_MODE             (idx, 1)        = 2 ;
SEED                      (idx, 1)        = 1780884256024 ;
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

% Parallelization:

MPI_TASKS                 (idx, 1)        = 1 ;
OMP_THREADS               (idx, 1)        = 80 ;
MPI_REPRODUCIBILITY       (idx, 1)        = 0 ;
OMP_REPRODUCIBILITY       (idx, 1)        = 1 ;
OMP_HISTORY_PROFILE       (idx, [1:  80]) = [  1.00123E+00  9.95659E-01  1.00538E+00  9.97595E-01  9.99999E-01  1.00127E+00  1.00307E+00  1.00518E+00  1.00203E+00  9.98592E-01  1.00185E+00  1.00308E+00  1.00027E+00  9.89030E-01  9.91816E-01  9.98301E-01  1.00131E+00  1.00370E+00  1.00846E+00  1.00307E+00  9.92467E-01  9.96478E-01  1.00144E+00  9.97338E-01  1.00085E+00  1.00675E+00  9.93859E-01  1.00340E+00  1.00607E+00  9.98552E-01  9.88067E-01  1.00173E+00  1.00307E+00  9.99098E-01  1.00347E+00  9.98636E-01  9.95291E-01  9.95859E-01  1.00151E+00  9.96892E-01  9.95549E-01  1.00567E+00  9.99624E-01  1.00494E+00  1.00101E+00  1.00434E+00  9.97931E-01  1.00000E+00  9.96519E-01  1.00255E+00  9.91607E-01  9.93670E-01  1.00524E+00  9.97005E-01  9.99831E-01  1.00693E+00  9.93518E-01  1.00179E+00  1.00019E+00  1.00341E+00  9.95464E-01  1.00097E+00  1.00194E+00  9.92600E-01  1.00209E+00  1.00583E+00  1.00424E+00  1.00164E+00  1.00295E+00  1.00456E+00  9.96985E-01  1.00022E+00  9.97573E-01  1.00357E+00  1.00216E+00  1.00373E+00  9.95316E-01  9.99831E-01  1.00101E+00  9.94253E-01  ];
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

MIN_MACROXS               (idx, [1:   4]) = [  5.00000E-02 4.6E-09  0.00000E+00 0.0E+00 ];
DT_THRESH                 (idx, [1:   2]) = [  9.00000E-01  9.00000E-01 ] ;
ST_FRAC                   (idx, [1:   4]) = [  2.42858E-02 0.00012  0.00000E+00 0.0E+00 ];
DT_FRAC                   (idx, [1:   4]) = [  9.75714E-01 2.9E-06  0.00000E+00 0.0E+00 ];
DT_EFF                    (idx, [1:   4]) = [  7.36032E-01 1.2E-05  0.00000E+00 0.0E+00 ];
REA_SAMPLING_EFF          (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
REA_SAMPLING_FAIL         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_COL_EFF               (idx, [1:   4]) = [  7.36482E-01 1.2E-05  0.00000E+00 0.0E+00 ];
AVG_TRACKING_LOOPS        (idx, [1:   8]) = [  3.08094E+00 5.4E-05  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
CELL_SEARCH_FRAC          (idx, [1:  10]) = [  9.26192E-01 7.8E-06  7.37996E-02 9.8E-05  8.60517E-06 0.00316  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
AVG_TRACKS                (idx, [1:   4]) = [  3.87085E+01 6.8E-05  0.00000E+00 0.0E+00 ];
AVG_REAL_COL              (idx, [1:   4]) = [  3.87085E+01 6.8E-05  0.00000E+00 0.0E+00 ];
AVG_VIRT_COL              (idx, [1:   4]) = [  1.38501E+01 8.4E-05  0.00000E+00 0.0E+00 ];
AVG_SURF_CROSS            (idx, [1:   4]) = [  3.55000E+00 9.0E-05  0.00000E+00 0.0E+00 ];
LOST_PARTICLES            (idx, 1)        = 0 ;

% Run statistics:

CYCLE_IDX                 (idx, 1)        = 500 ;
SIMULATED_HISTORIES       (idx, 1)        = 100000243 ;
MEAN_POP_SIZE             (idx, [1:   2]) = [  2.00000E+05 0.00019 ] ;
MEAN_POP_WGT              (idx, [1:   2]) = [  2.00000E+05 0.00019 ] ;
SIMULATION_COMPLETED      (idx, 1)        = 1 ;

% Running times:

TOT_CPU_TIME              (idx, 1)        =  6.18624E+02 ;
RUNNING_TIME              (idx, 1)        =  1.45887E+01 ;
INIT_TIME                 (idx, [1:   2]) = [  7.78500E-02  7.78500E-02 ] ;
PROCESS_TIME              (idx, [1:   2]) = [  3.11667E-03  3.11667E-03 ] ;
TRANSPORT_CYCLE_TIME      (idx, [1:   3]) = [  1.45077E+01  1.45077E+01  0.00000E+00 ] ;
MPI_OVERHEAD_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
ESTIMATED_RUNNING_TIME    (idx, [1:   2]) = [  1.45857E+01  0.00000E+00 ] ;
CPU_USAGE                 (idx, 1)        = 42.40425 ;
TRANSPORT_CPU_USAGE       (idx, [1:   2]) = [  4.29963E+01 0.00110 ];
OMP_PARALLEL_FRAC         (idx, 1)        =  5.08994E-01 ;

% Memory usage:

AVAIL_MEM                 (idx, 1)        = 257398.64 ;
ALLOC_MEMSIZE             (idx, 1)        = 6046.10 ;
MEMSIZE                   (idx, 1)        = 5475.89 ;
XS_MEMSIZE                (idx, 1)        = 787.24 ;
MAT_MEMSIZE               (idx, 1)        = 3110.35 ;
RES_MEMSIZE               (idx, 1)        = 241.39 ;
IFC_MEMSIZE               (idx, 1)        = 0.00 ;
MISC_MEMSIZE              (idx, 1)        = 1336.92 ;
UNKNOWN_MEMSIZE           (idx, 1)        = 0.00 ;
UNUSED_MEMSIZE            (idx, 1)        = 570.20 ;

% Geometry parameters:

TOT_CELLS                 (idx, 1)        = 4 ;
UNION_CELLS               (idx, 1)        = 0 ;

% Neutron energy grid:

NEUTRON_ERG_TOL           (idx, 1)        =  0.00000E+00 ;
NEUTRON_ERG_NE            (idx, 1)        = 213707 ;
NEUTRON_EMIN              (idx, 1)        =  1.00000E-11 ;
NEUTRON_EMAX              (idx, 1)        =  2.00000E+01 ;

% Unresolved resonance probability table sampling:

URES_DILU_CUT             (idx, 1)        =  1.00000E-09 ;
URES_EMIN                 (idx, 1)        =  1.00000E+37 ;
URES_EMAX                 (idx, 1)        = -1.00000E+37 ;
URES_AVAIL                (idx, 1)        = 15 ;
URES_USED                 (idx, 1)        = 0 ;

% Nuclides and reaction channels:

TOT_NUCLIDES              (idx, 1)        = 30 ;
TOT_TRANSPORT_NUCLIDES    (idx, 1)        = 30 ;
TOT_DOSIMETRY_NUCLIDES    (idx, 1)        = 0 ;
TOT_DECAY_NUCLIDES        (idx, 1)        = 0 ;
TOT_PHOTON_NUCLIDES       (idx, 1)        = 0 ;
TOT_REA_CHANNELS          (idx, 1)        = 713 ;
TOT_TRANSMU_REA           (idx, 1)        = 0 ;

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

TOT_ACTIVITY              (idx, 1)        =  9.94462E+06 ;
TOT_DECAY_HEAT            (idx, 1)        =  6.78269E-06 ;
TOT_SF_RATE               (idx, 1)        =  3.21659E+02 ;
ACTINIDE_ACTIVITY         (idx, 1)        =  9.94462E+06 ;
ACTINIDE_DECAY_HEAT       (idx, 1)        =  6.78269E-06 ;
FISSION_PRODUCT_ACTIVITY  (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_DECAY_HEAT(idx, 1)        =  0.00000E+00 ;
INHALATION_TOXICITY       (idx, 1)        =  3.75636E+02 ;
INGESTION_TOXICITY        (idx, 1)        =  9.85778E-01 ;
ACTINIDE_INH_TOX          (idx, 1)        =  3.75636E+02 ;
ACTINIDE_ING_TOX          (idx, 1)        =  9.85778E-01 ;
FISSION_PRODUCT_INH_TOX   (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ING_TOX   (idx, 1)        =  0.00000E+00 ;
SR90_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
TE132_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
I131_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
I132_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
CS134_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
CS137_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
PHOTON_DECAY_SOURCE       (idx, [1:   2]) = [  2.04579E+06  3.15684E-08 ] ;
NEUTRON_DECAY_SOURCE      (idx, 1)        =  0.00000E+00 ;
ALPHA_DECAY_SOURCE        (idx, 1)        =  9.92658E+06 ;
ELECTRON_DECAY_SOURCE     (idx, 1)        =  4.44927E+06 ;

% Normalization coefficient:

NORM_COEF                 (idx, [1:   4]) = [  2.02420E+10 0.00011  0.00000E+00 0.0E+00 ];

% Analog reaction rate estimators:

CONVERSION_RATIO          (idx, [1:   2]) = [  1.22578E+00 0.00022 ];
TH232_FISS                (idx, [1:   4]) = [  1.64962E+13 0.00156  1.17073E-02 0.00155 ];
U235_FISS                 (idx, [1:   4]) = [  1.34771E+15 0.00016  9.56473E-01 3.5E-05 ];
U238_FISS                 (idx, [1:   4]) = [  4.48359E+13 0.00095  3.18200E-02 0.00093 ];
TH232_CAPT                (idx, [1:   4]) = [  1.30405E+15 0.00019  4.92897E-01 0.00012 ];
U235_CAPT                 (idx, [1:   4]) = [  2.65659E+14 0.00036  1.00413E-01 0.00035 ];
U238_CAPT                 (idx, [1:   4]) = [  6.73637E+14 0.00026  2.54617E-01 0.00020 ];

% Neutron balance (particles/weight):

BALA_SRC_NEUTRON_SRC      (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_FISS     (idx, [1:   2]) = [ 100000243 1.00000E+08 ] ;
BALA_SRC_NEUTRON_NXN      (idx, [1:   2]) = [ 0 1.56046E+05 ] ;
BALA_SRC_NEUTRON_VR       (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_TOT      (idx, [1:   2]) = [ 100000243 1.00156E+08 ] ;

BALA_LOSS_NEUTRON_CAPT    (idx, [1:   2]) = [ 65248169 6.53510E+07 ] ;
BALA_LOSS_NEUTRON_FISS    (idx, [1:   2]) = [ 34752074 3.48050E+07 ] ;
BALA_LOSS_NEUTRON_LEAK    (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_CUT     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_ERR     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_TOT     (idx, [1:   2]) = [ 100000243 1.00156E+08 ] ;

BALA_NEUTRON_DIFF         (idx, [1:   2]) = [ 0 -1.71363E-06 ] ;

% Normalized total reaction rates (neutrons):

TOT_POWER                 (idx, [1:   2]) = [  4.56849E+04 0.0E+00 ];
TOT_POWDENS               (idx, [1:   2]) = [  3.80000E-02 0.0E+00 ];
TOT_GENRATE               (idx, [1:   2]) = [  3.45036E+15 1.6E-06 ];
TOT_FISSRATE              (idx, [1:   2]) = [  1.40909E+15 9.4E-08 ];
TOT_CAPTRATE              (idx, [1:   2]) = [  2.64535E+15 6.8E-05 ];
TOT_ABSRATE               (idx, [1:   2]) = [  4.05443E+15 4.4E-05 ];
TOT_SRCRATE               (idx, [1:   2]) = [  4.04841E+15 0.00011 ];
TOT_FLUX                  (idx, [1:   2]) = [  1.99796E+17 8.5E-05 ];
TOT_PHOTON_PRODRATE       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_LEAKRATE              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
ALBEDO_LEAKRATE           (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_LOSSRATE              (idx, [1:   2]) = [  4.05443E+15 4.4E-05 ];
TOT_CUTRATE               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_RR                    (idx, [1:   2]) = [  1.56945E+17 6.8E-05 ];
INI_FMASS                 (idx, 1)        =  1.20223E+00 ;
TOT_FMASS                 (idx, 1)        =  1.20223E+00 ;

% Six-factor formula:

SIX_FF_ETA                (idx, [1:   2]) = [  1.22039E+00 0.00013 ];
SIX_FF_F                  (idx, [1:   2]) = [  8.77254E-01 4.4E-05 ];
SIX_FF_P                  (idx, [1:   2]) = [  6.98225E-01 7.0E-05 ];
SIX_FF_EPSILON            (idx, [1:   2]) = [  1.14012E+00 6.6E-05 ];
SIX_FF_LF                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_LT                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_KINF               (idx, [1:   2]) = [  8.52251E-01 0.00014 ];
SIX_FF_KEFF               (idx, [1:   2]) = [  8.52251E-01 0.00014 ];

% Fission neutron and energy production:

NUBAR                     (idx, [1:   2]) = [  2.44865E+00 1.6E-06 ];
FISSE                     (idx, [1:   2]) = [  2.02360E+02 9.4E-08 ];

% Criticality eigenvalues:

ANA_KEFF                  (idx, [1:   6]) = [  8.52246E-01 0.00014  8.46441E-01 0.00014  5.81020E-03 0.00190 ];
IMP_KEFF                  (idx, [1:   2]) = [  8.52334E-01 4.4E-05 ];
COL_KEFF                  (idx, [1:   2]) = [  8.52280E-01 0.00011 ];
ABS_KEFF                  (idx, [1:   2]) = [  8.52334E-01 4.4E-05 ];
ABS_KINF                  (idx, [1:   2]) = [  8.52334E-01 4.4E-05 ];
GEOM_ALBEDO               (idx, [1:   6]) = [  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00 ];

% ALF (Average lethargy of neutrons causing fission):
% Based on E0 = 2.000000E+01 MeV

ANA_ALF                   (idx, [1:   2]) = [  1.84206E+01 3.7E-05 ];
IMP_ALF                   (idx, [1:   2]) = [  1.84199E+01 1.2E-05 ];

% EALF (Energy corresponding to average lethargy of neutrons causing fission):

ANA_EALF                  (idx, [1:   2]) = [  2.00045E-07 0.00069 ];
IMP_EALF                  (idx, [1:   2]) = [  2.00166E-07 0.00023 ];

% AFGE (Average energy of neutrons causing fission):

ANA_AFGE                  (idx, [1:   2]) = [  1.47794E-01 0.00088 ];
IMP_AFGE                  (idx, [1:   2]) = [  1.47908E-01 0.00027 ];

% Forward-weighted delayed neutron parameters:

PRECURSOR_GROUPS          (idx, 1)        = 6 ;
FWD_ANA_BETA_ZERO         (idx, [1:  14]) = [  8.23028E-03 0.00121  2.49701E-04 0.00691  1.32583E-03 0.00293  1.30963E-03 0.00300  3.76617E-03 0.00181  1.17017E-03 0.00335  4.08779E-04 0.00548 ];
FWD_ANA_LAMBDA            (idx, [1:  14]) = [  7.80206E-01 0.00283  1.24867E-02 1.0E-05  3.17795E-02 4.4E-05  1.10177E-01 7.3E-05  3.19040E-01 3.6E-05  1.34352E+00 7.0E-05  8.45936E+00 0.00085 ];

% Beta-eff using Meulekamp's method:

ADJ_MEULEKAMP_BETA_EFF    (idx, [1:  14]) = [  6.83747E-03 0.00174  2.05460E-04 0.01010  1.09838E-03 0.00432  1.08925E-03 0.00438  3.13012E-03 0.00275  9.76508E-04 0.00463  3.37750E-04 0.00784 ];
ADJ_MEULEKAMP_LAMBDA      (idx, [1:  14]) = [  7.78372E-01 0.00405  1.24869E-02 1.5E-05  3.17790E-02 6.5E-05  1.10178E-01 0.00011  3.19066E-01 5.7E-05  1.34342E+00 0.00011  8.45035E+00 0.00129 ];

% Adjoint weighted time constants using Nauchi's method:

IFP_CHAIN_LENGTH          (idx, 1)        = 15 ;
ADJ_NAUCHI_GEN_TIME       (idx, [1:   6]) = [  5.46172E-05 0.00026  5.45993E-05 0.00027  5.72313E-05 0.00263 ];
ADJ_NAUCHI_LIFETIME       (idx, [1:   6]) = [  4.65468E-05 0.00023  4.65316E-05 0.00023  4.87747E-05 0.00263 ];
ADJ_NAUCHI_BETA_EFF       (idx, [1:  14]) = [  6.81656E-03 0.00190  2.07938E-04 0.01143  1.09432E-03 0.00532  1.08380E-03 0.00518  3.12252E-03 0.00291  9.71561E-04 0.00583  3.36429E-04 0.00920 ];
ADJ_NAUCHI_LAMBDA         (idx, [1:  14]) = [  7.77995E-01 0.00476  1.24869E-02 1.9E-05  3.17788E-02 7.3E-05  1.10192E-01 0.00013  3.19019E-01 6.4E-05  1.34350E+00 0.00013  8.45897E+00 0.00150 ];

% Adjoint weighted time constants using IFP:

ADJ_IFP_GEN_TIME          (idx, [1:   6]) = [  5.45719E-05 0.00061  5.45482E-05 0.00061  5.80545E-05 0.00668 ];
ADJ_IFP_LIFETIME          (idx, [1:   6]) = [  4.65082E-05 0.00059  4.64880E-05 0.00059  4.94749E-05 0.00666 ];
ADJ_IFP_IMP_BETA_EFF      (idx, [1:  14]) = [  6.74631E-03 0.00667  2.05287E-04 0.03783  1.11241E-03 0.01625  1.04025E-03 0.01768  3.09861E-03 0.00939  9.69523E-04 0.01850  3.20226E-04 0.03040 ];
ADJ_IFP_IMP_LAMBDA        (idx, [1:  14]) = [  7.61820E-01 0.01589  1.24883E-02 4.3E-05  3.17832E-02 0.00026  1.10238E-01 0.00043  3.19024E-01 0.00022  1.34413E+00 0.00038  8.46200E+00 0.00459 ];
ADJ_IFP_ANA_BETA_EFF      (idx, [1:  14]) = [  6.74587E-03 0.00653  2.04597E-04 0.03780  1.11016E-03 0.01579  1.04097E-03 0.01719  3.09900E-03 0.00920  9.68981E-04 0.01806  3.22171E-04 0.02999 ];
ADJ_IFP_ANA_LAMBDA        (idx, [1:  14]) = [  7.63875E-01 0.01566  1.24882E-02 4.3E-05  3.17825E-02 0.00026  1.10234E-01 0.00042  3.19031E-01 0.00022  1.34397E+00 0.00037  8.46019E+00 0.00446 ];
ADJ_IFP_ROSSI_ALPHA       (idx, [1:   2]) = [ -1.23679E+02 0.00665 ];

% Adjoint weighted time constants using perturbation technique:

ADJ_PERT_GEN_TIME         (idx, [1:   2]) = [  5.46284E-05 0.00017 ];
ADJ_PERT_LIFETIME         (idx, [1:   2]) = [  4.65563E-05 1.0E-04 ];
ADJ_PERT_BETA_EFF         (idx, [1:   2]) = [  6.81312E-03 0.00113 ];
ADJ_PERT_ROSSI_ALPHA      (idx, [1:   2]) = [ -1.24718E+02 0.00113 ];

% Inverse neutron speed :

ANA_INV_SPD               (idx, [1:   2]) = [  7.48205E-07 9.7E-05 ];

% Analog slowing-down and thermal neutron lifetime (total/prompt/delayed):

ANA_SLOW_TIME             (idx, [1:   6]) = [  2.88009E-06 9.2E-05  2.88010E-06 9.2E-05  2.87891E-06 0.00106 ];
ANA_THERM_TIME            (idx, [1:   6]) = [  4.97177E-05 0.00012  4.97175E-05 0.00012  4.97386E-05 0.00127 ];
ANA_THERM_FRAC            (idx, [1:   6]) = [  6.98501E-01 7.0E-05  6.99260E-01 7.2E-05  6.07518E-01 0.00183 ];
ANA_DELAYED_EMTIME        (idx, [1:   2]) = [  1.05087E+01 0.00287 ];
ANA_MEAN_NCOL             (idx, [1:   4]) = [  3.87085E+01 6.8E-05  4.43277E+01 0.00010 ];

% Group constant generation:

GC_UNIVERSE_NAME          (idx, [1:   4]) = '1001' ;

% Micro- and macro-group structures:

MICRO_NG                  (idx, 1)        = 70 ;
MICRO_E                   (idx, [1:  71]) = [  2.00000E+01  6.06550E+00  3.67900E+00  2.23100E+00  1.35300E+00  8.21000E-01  5.00000E-01  3.02500E-01  1.83000E-01  1.11000E-01  6.74300E-02  4.08500E-02  2.47800E-02  1.50300E-02  9.11800E-03  5.50000E-03  3.51910E-03  2.23945E-03  1.42510E-03  9.06898E-04  3.67262E-04  1.48728E-04  7.55014E-05  4.80520E-05  2.77000E-05  1.59680E-05  9.87700E-06  4.00000E-06  3.30000E-06  2.60000E-06  2.10000E-06  1.85500E-06  1.50000E-06  1.30000E-06  1.15000E-06  1.12300E-06  1.09700E-06  1.07100E-06  1.04500E-06  1.02000E-06  9.96000E-07  9.72000E-07  9.50000E-07  9.10000E-07  8.50000E-07  7.80000E-07  6.25000E-07  5.00000E-07  4.00000E-07  3.50000E-07  3.20000E-07  3.00000E-07  2.80000E-07  2.50000E-07  2.20000E-07  1.80000E-07  1.40000E-07  1.00000E-07  8.00000E-08  6.70000E-08  5.80000E-08  5.00000E-08  4.20000E-08  3.50000E-08  3.00000E-08  2.50000E-08  2.00000E-08  1.50000E-08  1.00000E-08  5.00000E-09  1.00000E-11 ];

MACRO_NG                  (idx, 1)        = 2 ;
MACRO_E                   (idx, [1:   3]) = [  1.00000E+37  6.25000E-07  0.00000E+00 ];

% Micro-group spectrum:

INF_MICRO_FLX             (idx, [1: 140]) = [  1.35866E+06 0.00088  5.49512E+06 0.00036  1.14895E+07 0.00027  1.27439E+07 0.00016  1.17956E+07 0.00018  1.26695E+07 0.00017  8.59471E+06 0.00011  7.57837E+06 0.00015  5.78273E+06 0.00018  4.72882E+06 0.00016  4.08517E+06 0.00024  3.68112E+06 0.00014  3.39907E+06 0.00022  3.23063E+06 0.00019  3.14718E+06 0.00020  2.71767E+06 0.00022  2.68725E+06 0.00017  2.64891E+06 0.00023  2.61392E+06 0.00030  5.07930E+06 0.00012  4.80921E+06 0.00015  3.49382E+06 0.00019  2.20595E+06 0.00020  2.71090E+06 0.00018  2.36166E+06 0.00021  2.29038E+06 0.00022  3.92412E+06 0.00019  8.84012E+05 0.00035  1.10892E+06 0.00031  1.00323E+06 0.00037  5.85429E+05 0.00044  1.01428E+06 0.00031  6.89961E+05 0.00030  5.93061E+05 0.00033  1.14268E+05 0.00078  1.13538E+05 0.00114  1.16237E+05 0.00092  1.19563E+05 0.00103  1.18281E+05 0.00085  1.16355E+05 0.00091  1.20076E+05 0.00071  1.12731E+05 0.00068  2.12881E+05 0.00068  3.39990E+05 0.00056  4.32564E+05 0.00051  1.14006E+06 0.00036  1.19351E+06 0.00035  1.27138E+06 0.00028  8.42148E+05 0.00032  6.29483E+05 0.00046  4.96916E+05 0.00039  5.82985E+05 0.00058  1.06943E+06 0.00032  1.49119E+06 0.00027  3.00090E+06 0.00021  4.95630E+06 0.00016  7.95763E+06 0.00014  5.43888E+06 0.00016  4.04803E+06 0.00021  2.99610E+06 0.00025  2.72516E+06 0.00019  2.74857E+06 0.00018  2.34758E+06 0.00018  1.60244E+06 0.00020  1.50418E+06 0.00020  1.34764E+06 0.00029  1.17892E+06 0.00025  9.08949E+05 0.00026  6.01093E+05 0.00032  2.09690E+05 0.00054 ];

% Integral parameters:

INF_KINF                  (idx, [1:   2]) = [  8.52280E-01 0.00011 ];

% Flux spectra in infinite geometry:

INF_FLX                   (idx, [1:   4]) = [  1.48029E+17 0.00012  5.17681E+16 6.5E-05 ];
INF_FISS_FLX              (idx, [1:   4]) = [  4.53960E+16 0.00014  1.47708E+16 4.6E-05 ];

% Reaction cross sections:

INF_TOT                   (idx, [1:   4]) = [  5.62481E-01 3.1E-05  1.42332E+00 2.4E-05 ];
INF_CAPT                  (idx, [1:   4]) = [  7.16552E-03 0.00015  3.06106E-02 4.7E-05 ];
INF_ABS                   (idx, [1:   4]) = [  8.29468E-03 0.00013  5.46012E-02 5.6E-05 ];
INF_FISS                  (idx, [1:   4]) = [  1.12916E-03 7.9E-05  2.39906E-02 6.7E-05 ];
INF_NSF                   (idx, [1:   4]) = [  2.86514E-03 8.1E-05  5.84579E-02 6.7E-05 ];
INF_NUBAR                 (idx, [1:   4]) = [  2.53742E+00 1.1E-05  2.43670E+00 3.8E-09 ];
INF_KAPPA                 (idx, [1:   4]) = [  2.03029E+02 6.8E-07  2.02270E+02 4.7E-09 ];
INF_INVV                  (idx, [1:   4]) = [  6.05583E-08 0.00012  2.71451E-06 2.7E-05 ];

% Total scattering cross sections:

INF_SCATT0                (idx, [1:   4]) = [  5.54185E-01 3.3E-05  1.36871E+00 2.5E-05 ];
INF_SCATT1                (idx, [1:   4]) = [  2.53393E-01 3.9E-05  3.42975E-01 5.2E-05 ];
INF_SCATT2                (idx, [1:   4]) = [  9.96267E-02 5.0E-05  8.08209E-02 0.00020 ];
INF_SCATT3                (idx, [1:   4]) = [  7.56749E-03 0.00067  2.42514E-02 0.00042 ];
INF_SCATT4                (idx, [1:   4]) = [ -1.07671E-02 0.00046 -7.43917E-03 0.00132 ];
INF_SCATT5                (idx, [1:   4]) = [  7.63382E-05 0.06057  5.82247E-03 0.00174 ];
INF_SCATT6                (idx, [1:   4]) = [  5.19492E-03 0.00069 -1.45267E-02 0.00074 ];
INF_SCATT7                (idx, [1:   4]) = [  7.60262E-04 0.00387  5.12193E-04 0.01650 ];

% Total scattering production cross sections:

INF_SCATTP0               (idx, [1:   4]) = [  5.54228E-01 3.3E-05  1.36871E+00 2.5E-05 ];
INF_SCATTP1               (idx, [1:   4]) = [  2.53393E-01 3.9E-05  3.42975E-01 5.2E-05 ];
INF_SCATTP2               (idx, [1:   4]) = [  9.96268E-02 5.0E-05  8.08209E-02 0.00020 ];
INF_SCATTP3               (idx, [1:   4]) = [  7.56753E-03 0.00067  2.42514E-02 0.00042 ];
INF_SCATTP4               (idx, [1:   4]) = [ -1.07671E-02 0.00046 -7.43917E-03 0.00132 ];
INF_SCATTP5               (idx, [1:   4]) = [  7.63728E-05 0.06046  5.82247E-03 0.00174 ];
INF_SCATTP6               (idx, [1:   4]) = [  5.19491E-03 0.00069 -1.45267E-02 0.00074 ];
INF_SCATTP7               (idx, [1:   4]) = [  7.60226E-04 0.00385  5.12193E-04 0.01650 ];

% Diffusion parameters:

INF_TRANSPXS              (idx, [1:   4]) = [  2.24136E-01 7.6E-05  9.57950E-01 4.0E-05 ];
INF_DIFFCOEF              (idx, [1:   4]) = [  1.48719E+00 7.6E-05  3.47965E-01 4.0E-05 ];

% Reduced absoption and removal:

INF_RABSXS                (idx, [1:   4]) = [  8.25200E-03 0.00013  5.46012E-02 5.6E-05 ];
INF_REMXS                 (idx, [1:   4]) = [  2.77013E-02 4.7E-05  5.54890E-02 9.3E-05 ];

% Poison cross sections:

INF_I135_YIELD            (idx, [1:   4]) = [  6.38332E-02 2.9E-06  6.28187E-02 3.8E-09 ];
INF_XE135_YIELD           (idx, [1:   4]) = [  1.70574E-03 9.2E-05  2.56634E-03 3.8E-09 ];
INF_PM147_YIELD           (idx, [1:   4]) = [  1.58275E-11 0.00010  2.48982E-11 2.7E-09 ];
INF_PM148_YIELD           (idx, [1:   4]) = [  2.98150E-11 8.9E-05  4.44969E-11 4.7E-09 ];
INF_PM148M_YIELD          (idx, [1:   4]) = [  5.57484E-11 8.2E-05  8.09942E-11 0.0E+00 ];
INF_PM149_YIELD           (idx, [1:   4]) = [  1.22782E-02 2.2E-05  1.08163E-02 3.8E-09 ];
INF_SM149_YIELD           (idx, [1:   4]) = [  1.08591E-12 0.00010  1.70988E-12 0.0E+00 ];
INF_I135_MICRO_ABS        (idx, [1:   4]) = [  9.92470E-01 0.00017  4.43433E+01 6.3E-05 ];
INF_XE135_MICRO_ABS       (idx, [1:   4]) = [  1.41584E+02 0.00044  1.74803E+06 6.4E-05 ];
INF_PM147_MICRO_ABS       (idx, [1:   4]) = [  6.30477E+01 0.00076  9.17023E+01 6.3E-05 ];
INF_PM148_MICRO_ABS       (idx, [1:   4]) = [  9.19335E+01 0.00017  1.10992E+03 6.3E-05 ];
INF_PM148M_MICRO_ABS      (idx, [1:   4]) = [  1.43949E+02 0.00016  1.81987E+04 6.4E-05 ];
INF_PM149_MICRO_ABS       (idx, [1:   4]) = [  5.01023E+01 0.00016  7.76950E+02 6.3E-05 ];
INF_SM149_MICRO_ABS       (idx, [1:   4]) = [  1.09787E+02 0.00039  5.03748E+04 7.4E-05 ];
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

INF_S0                    (idx, [1:   8]) = [  5.34780E-01 3.2E-05  1.94054E-02 8.5E-05  8.85896E-04 0.00085  1.36783E+00 2.5E-05 ];
INF_S1                    (idx, [1:   8]) = [  2.47669E-01 3.8E-05  5.72364E-03 0.00018  3.10238E-04 0.00179  3.42664E-01 5.3E-05 ];
INF_S2                    (idx, [1:   8]) = [  1.01301E-01 4.9E-05 -1.67467E-03 0.00033  1.87405E-04 0.00281  8.06335E-02 0.00020 ];
INF_S3                    (idx, [1:   8]) = [  9.61481E-03 0.00052 -2.04732E-03 0.00032  8.05053E-05 0.00470  2.41709E-02 0.00042 ];
INF_S4                    (idx, [1:   8]) = [ -1.00755E-02 0.00048 -6.91602E-04 0.00089  1.32278E-05 0.02299 -7.45239E-03 0.00133 ];
INF_S5                    (idx, [1:   8]) = [  6.05398E-05 0.07596  1.57984E-05 0.03836 -1.86605E-05 0.01648  5.84113E-03 0.00174 ];
INF_S6                    (idx, [1:   8]) = [  5.33840E-03 0.00069 -1.43479E-04 0.00383 -3.03431E-05 0.00747 -1.44964E-02 0.00075 ];
INF_S7                    (idx, [1:   8]) = [  9.39598E-04 0.00313 -1.79336E-04 0.00295 -3.08744E-05 0.00655  5.43067E-04 0.01534 ];

% Scattering production matrixes:

INF_SP0                   (idx, [1:   8]) = [  5.34823E-01 3.2E-05  1.94054E-02 8.5E-05  8.85896E-04 0.00085  1.36783E+00 2.5E-05 ];
INF_SP1                   (idx, [1:   8]) = [  2.47670E-01 3.8E-05  5.72364E-03 0.00018  3.10238E-04 0.00179  3.42664E-01 5.3E-05 ];
INF_SP2                   (idx, [1:   8]) = [  1.01301E-01 4.9E-05 -1.67467E-03 0.00033  1.87405E-04 0.00281  8.06335E-02 0.00020 ];
INF_SP3                   (idx, [1:   8]) = [  9.61485E-03 0.00052 -2.04732E-03 0.00032  8.05053E-05 0.00470  2.41709E-02 0.00042 ];
INF_SP4                   (idx, [1:   8]) = [ -1.00755E-02 0.00048 -6.91602E-04 0.00089  1.32278E-05 0.02299 -7.45239E-03 0.00133 ];
INF_SP5                   (idx, [1:   8]) = [  6.05744E-05 0.07580  1.57984E-05 0.03836 -1.86605E-05 0.01648  5.84113E-03 0.00174 ];
INF_SP6                   (idx, [1:   8]) = [  5.33839E-03 0.00069 -1.43479E-04 0.00383 -3.03431E-05 0.00747 -1.44964E-02 0.00075 ];
INF_SP7                   (idx, [1:   8]) = [  9.39562E-04 0.00312 -1.79336E-04 0.00295 -3.08744E-05 0.00655  5.43067E-04 0.01534 ];

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

CMM_TRANSPXS              (idx, [1:   4]) = [  2.38739E-01 0.00013  8.79565E-01 0.00040 ];
CMM_TRANSPXS_X            (idx, [1:   4]) = [  2.38882E-01 0.00016  8.82364E-01 0.00061 ];
CMM_TRANSPXS_Y            (idx, [1:   4]) = [  2.38810E-01 0.00019  8.82845E-01 0.00066 ];
CMM_TRANSPXS_Z            (idx, [1:   4]) = [  2.38527E-01 0.00020  8.73571E-01 0.00085 ];
CMM_DIFFCOEF              (idx, [1:   4]) = [  1.39622E+00 0.00013  3.78977E-01 0.00040 ];
CMM_DIFFCOEF_X            (idx, [1:   4]) = [  1.39539E+00 0.00016  3.77776E-01 0.00061 ];
CMM_DIFFCOEF_Y            (idx, [1:   4]) = [  1.39581E+00 0.00019  3.77571E-01 0.00066 ];
CMM_DIFFCOEF_Z            (idx, [1:   4]) = [  1.39747E+00 0.00020  3.81582E-01 0.00085 ];

% Delayed neutron parameters (Meulekamp method):

BETA_EFF                  (idx, [1:  14]) = [  6.83747E-03 0.00174  2.05460E-04 0.01010  1.09838E-03 0.00432  1.08925E-03 0.00438  3.13012E-03 0.00275  9.76508E-04 0.00463  3.37750E-04 0.00784 ];
LAMBDA                    (idx, [1:  14]) = [  7.78372E-01 0.00405  1.24869E-02 1.5E-05  3.17790E-02 6.5E-05  1.10178E-01 0.00011  3.19066E-01 5.7E-05  1.34342E+00 0.00011  8.45035E+00 0.00129 ];

% Pin-power distribution:

PPW_LATTICE               (idx, [1:   4]) = '1000' ;
PPW_LATTICE_TYPE          (idx, 1)        = 1 ;
PPW_PINS                  (idx, 1)        = 289 ;
PPW_POW                   (idx, [1: 1156]) = [  4.49790E-04 0.00230  3.14061E-03 0.00161  4.48668E-04 0.00185  3.11537E-03 0.00116  4.48592E-04 0.00165  3.13195E-03 0.00143  4.51470E-04 0.00216  3.17268E-03 0.00164  4.49693E-04 0.00196  3.21864E-03 0.00168  4.49613E-04 0.00206  3.24527E-03 0.00163  4.49305E-04 0.00238  3.24996E-03 0.00168  4.50286E-04 0.00254  3.24293E-03 0.00132  4.50682E-04 0.00185  3.26168E-03 0.00168  4.49869E-04 0.00172  3.24931E-03 0.00184  4.50130E-04 0.00168  3.24515E-03 0.00127  4.51298E-04 0.00163  3.24922E-03 0.00134  4.49565E-04 0.00139  3.21243E-03 0.00175  4.49455E-04 0.00167  3.16840E-03 0.00176  4.48994E-04 0.00228  3.14718E-03 0.00166  4.48084E-04 0.00188  3.11699E-03 0.00175  4.50475E-04 0.00186  3.12739E-03 0.00210  4.47511E-04 0.00189  3.11684E-03 0.00148  4.48825E-04 0.00180  3.11416E-03 0.00160  4.49886E-04 0.00162  3.14999E-03 0.00133  4.49415E-04 0.00159  3.21211E-03 0.00151  4.49917E-04 0.00156  3.27033E-03 0.00145  4.51672E-04 0.00165  3.36360E-03 0.00139  4.48203E-04 0.00222  3.30633E-03 0.00123  4.50714E-04 0.00196  3.30533E-03 0.00145  4.50213E-04 0.00185  3.37411E-03 0.00168  4.49852E-04 0.00162  3.29859E-03 0.00192  4.52234E-04 0.00162  3.29857E-03 0.00170  4.50308E-04 0.00183  3.35642E-03 0.00134  4.51369E-04 0.00211  3.27613E-03 0.00142  4.51556E-04 0.00199  3.21609E-03 0.00149  4.50988E-04 0.00200  3.14938E-03 0.00131  4.48097E-04 0.00153  3.10613E-03 0.00154  4.48642E-04 0.00227  3.11880E-03 0.00190  4.48480E-04 0.00214  3.14127E-03 0.00094  4.49328E-04 0.00210  3.14870E-03 0.00180  4.50265E-04 0.00157  3.23440E-03 0.00138  4.52010E-04 0.00189  3.38169E-03 0.00151  4.51180E-04 0.00225  3.44612E-03 0.00126  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.51941E-04 0.00160  3.42775E-03 0.00128  4.52586E-04 0.00178  3.42421E-03 0.00138  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52285E-04 0.00158  3.42774E-03 0.00123  4.51467E-04 0.00175  3.42998E-03 0.00154  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52393E-04 0.00192  3.43845E-03 0.00162  4.51542E-04 0.00148  3.37521E-03 0.00155  4.50425E-04 0.00142  3.22233E-03 0.00117  4.49276E-04 0.00188  3.14510E-03 0.00173  4.47663E-04 0.00167  3.13357E-03 0.00137  4.49807E-04 0.00135  3.17226E-03 0.00181  4.49639E-04 0.00207  3.21180E-03 0.00125  4.50334E-04 0.00173  3.37726E-03 0.00171  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.51959E-04 0.00235  3.49837E-03 0.00141  4.52671E-04 0.00175  3.48474E-03 0.00138  4.51627E-04 0.00143  3.38001E-03 0.00139  4.52060E-04 0.00138  3.37308E-03 0.00146  4.51497E-04 0.00207  3.44467E-03 0.00168  4.49970E-04 0.00162  3.36734E-03 0.00193  4.51901E-04 0.00154  3.38046E-03 0.00157  4.52202E-04 0.00186  3.48808E-03 0.00143  4.50547E-04 0.00199  3.49841E-03 0.00152  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52247E-04 0.00154  3.37559E-03 0.00138  4.49735E-04 0.00185  3.21126E-03 0.00201  4.49672E-04 0.00189  3.16790E-03 0.00140  4.51003E-04 0.00176  3.20968E-03 0.00197  4.49181E-04 0.00175  3.27886E-03 0.00155  4.51690E-04 0.00230  3.44461E-03 0.00163  4.51593E-04 0.00176  3.49316E-03 0.00163  4.52661E-04 0.00142  3.44792E-03 0.00139  4.53648E-04 0.00165  3.49032E-03 0.00127  4.50527E-04 0.00207  3.39250E-03 0.00117  4.50721E-04 0.00193  3.38522E-03 0.00140  4.51979E-04 0.00170  3.46721E-03 0.00149  4.53133E-04 0.00188  3.37665E-03 0.00154  4.51771E-04 0.00182  3.39747E-03 0.00145  4.52015E-04 0.00152  3.49124E-03 0.00172  4.51920E-04 0.00185  3.45221E-03 0.00119  4.52227E-04 0.00168  3.49758E-03 0.00195  4.50196E-04 0.00158  3.44411E-03 0.00166  4.51355E-04 0.00140  3.27166E-03 0.00185  4.48224E-04 0.00198  3.21057E-03 0.00188  4.50253E-04 0.00184  3.24990E-03 0.00160  4.51442E-04 0.00196  3.37125E-03 0.00165  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52614E-04 0.00151  3.48522E-03 0.00159  4.52386E-04 0.00217  3.49750E-03 0.00110  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.50769E-04 0.00173  3.48057E-03 0.00174  4.53266E-04 0.00153  3.47498E-03 0.00122  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52463E-04 0.00182  3.47281E-03 0.00178  4.51736E-04 0.00199  3.47693E-03 0.00152  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.51066E-04 0.00126  3.49382E-03 0.00098  4.51650E-04 0.00208  3.48643E-03 0.00182  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.49529E-04 0.00148  3.37074E-03 0.00157  4.50043E-04 0.00151  3.25242E-03 0.00192  4.51076E-04 0.00193  3.24943E-03 0.00162  4.49398E-04 0.00244  3.30151E-03 0.00149  4.52147E-04 0.00125  3.42030E-03 0.00125  4.52390E-04 0.00156  3.38388E-03 0.00170  4.53081E-04 0.00182  3.39499E-03 0.00171  4.51668E-04 0.00136  3.48648E-03 0.00152  4.51493E-04 0.00223  3.38902E-03 0.00134  4.52281E-04 0.00190  3.38848E-03 0.00159  4.51699E-04 0.00160  3.48591E-03 0.00120  4.51480E-04 0.00161  3.39446E-03 0.00129  4.52758E-04 0.00134  3.39355E-03 0.00157  4.51345E-04 0.00181  3.47735E-03 0.00136  4.52298E-04 0.00167  3.39183E-03 0.00164  4.50706E-04 0.00142  3.38544E-03 0.00117  4.50598E-04 0.00158  3.42130E-03 0.00123  4.50493E-04 0.00152  3.30253E-03 0.00167  4.48262E-04 0.00192  3.24941E-03 0.00145  4.49044E-04 0.00193  3.24569E-03 0.00149  4.51936E-04 0.00200  3.29386E-03 0.00205  4.51829E-04 0.00214  3.43022E-03 0.00119  4.51734E-04 0.00189  3.37286E-03 0.00152  4.50903E-04 0.00192  3.38670E-03 0.00151  4.51200E-04 0.00183  3.47899E-03 0.00149  4.51707E-04 0.00161  3.39381E-03 0.00121  4.51596E-04 0.00156  3.39678E-03 0.00162  4.52390E-04 0.00192  3.47988E-03 0.00158  4.54341E-04 0.00192  3.38836E-03 0.00152  4.51129E-04 0.00176  3.39503E-03 0.00127  4.50725E-04 0.00124  3.46960E-03 0.00132  4.51362E-04 0.00186  3.38552E-03 0.00155  4.51054E-04 0.00158  3.36682E-03 0.00140  4.50619E-04 0.00195  3.43230E-03 0.00145  4.50040E-04 0.00150  3.30312E-03 0.00169  4.50277E-04 0.00149  3.23879E-03 0.00153  4.50358E-04 0.00183  3.26178E-03 0.00149  4.50997E-04 0.00186  3.37600E-03 0.00170  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.50767E-04 0.00180  3.45850E-03 0.00177  4.51686E-04 0.00159  3.47189E-03 0.00115  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.53980E-04 0.00138  3.48307E-03 0.00156  4.52207E-04 0.00239  3.47238E-03 0.00158  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52382E-04 0.00225  3.48132E-03 0.00165  4.51130E-04 0.00162  3.47708E-03 0.00185  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52903E-04 0.00137  3.46956E-03 0.00189  4.51629E-04 0.00168  3.45479E-03 0.00162  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.49360E-04 0.00153  3.38046E-03 0.00182  4.49527E-04 0.00188  3.26957E-03 0.00144  4.50426E-04 0.00195  3.23941E-03 0.00129  4.50135E-04 0.00202  3.30009E-03 0.00105  4.51752E-04 0.00205  3.42563E-03 0.00163  4.50534E-04 0.00177  3.36282E-03 0.00135  4.50819E-04 0.00143  3.39090E-03 0.00126  4.51707E-04 0.00141  3.47932E-03 0.00160  4.51454E-04 0.00149  3.39925E-03 0.00130  4.51458E-04 0.00165  3.40976E-03 0.00172  4.52517E-04 0.00182  3.48051E-03 0.00125  4.51947E-04 0.00173  3.39456E-03 0.00155  4.50523E-04 0.00196  3.38503E-03 0.00166  4.53283E-04 0.00239  3.46952E-03 0.00152  4.52111E-04 0.00137  3.38798E-03 0.00191  4.52186E-04 0.00180  3.36685E-03 0.00146  4.51552E-04 0.00171  3.41795E-03 0.00136  4.49784E-04 0.00200  3.29854E-03 0.00172  4.48473E-04 0.00158  3.23958E-03 0.00122  4.51382E-04 0.00217  3.25137E-03 0.00167  4.50116E-04 0.00156  3.29798E-03 0.00146  4.51091E-04 0.00173  3.42634E-03 0.00137  4.50878E-04 0.00181  3.37491E-03 0.00165  4.53345E-04 0.00209  3.39474E-03 0.00158  4.54254E-04 0.00187  3.48276E-03 0.00160  4.51385E-04 0.00138  3.39124E-03 0.00167  4.50876E-04 0.00201  3.39024E-03 0.00146  4.51545E-04 0.00140  3.47373E-03 0.00138  4.50405E-04 0.00178  3.39337E-03 0.00121  4.51993E-04 0.00177  3.39696E-03 0.00140  4.51474E-04 0.00179  3.47679E-03 0.00142  4.51353E-04 0.00172  3.39107E-03 0.00186  4.49606E-04 0.00166  3.37325E-03 0.00146  4.50742E-04 0.00159  3.42595E-03 0.00164  4.49739E-04 0.00169  3.29836E-03 0.00137  4.49065E-04 0.00177  3.25326E-03 0.00143  4.51063E-04 0.00149  3.24878E-03 0.00162  4.51222E-04 0.00190  3.36129E-03 0.00164  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52270E-04 0.00188  3.49061E-03 0.00131  4.53785E-04 0.00164  3.49956E-03 0.00119  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.53120E-04 0.00201  3.48259E-03 0.00130  4.51388E-04 0.00137  3.47810E-03 0.00106  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.51532E-04 0.00198  3.46921E-03 0.00154  4.49538E-04 0.00180  3.47873E-03 0.00145  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.51734E-04 0.00165  3.49218E-03 0.00123  4.52654E-04 0.00173  3.48643E-03 0.00172  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.50222E-04 0.00197  3.36369E-03 0.00135  4.48981E-04 0.00172  3.23238E-03 0.00163  4.50133E-04 0.00198  3.21696E-03 0.00159  4.50324E-04 0.00186  3.27495E-03 0.00196  4.50425E-04 0.00237  3.45572E-03 0.00103  4.52377E-04 0.00221  3.51022E-03 0.00139  4.52141E-04 0.00145  3.45078E-03 0.00226  4.52816E-04 0.00154  3.49547E-03 0.00142  4.50547E-04 0.00147  3.39157E-03 0.00130  4.51390E-04 0.00213  3.38997E-03 0.00126  4.51205E-04 0.00193  3.46624E-03 0.00194  4.50534E-04 0.00158  3.38921E-03 0.00114  4.52020E-04 0.00181  3.38660E-03 0.00145  4.52520E-04 0.00174  3.49241E-03 0.00149  4.53015E-04 0.00188  3.44615E-03 0.00154  4.50760E-04 0.00163  3.50383E-03 0.00183  4.50639E-04 0.00191  3.44833E-03 0.00146  4.49311E-04 0.00168  3.27607E-03 0.00147  4.50100E-04 0.00151  3.21246E-03 0.00215  4.51212E-04 0.00152  3.17621E-03 0.00168  4.51674E-04 0.00199  3.21533E-03 0.00139  4.52225E-04 0.00197  3.38692E-03 0.00142  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.52279E-04 0.00122  3.50497E-03 0.00140  4.53302E-04 0.00151  3.48203E-03 0.00167  4.51426E-04 0.00162  3.37935E-03 0.00164  4.49649E-04 0.00162  3.37263E-03 0.00126  4.51088E-04 0.00197  3.45565E-03 0.00161  4.50788E-04 0.00173  3.36863E-03 0.00135  4.50541E-04 0.00208  3.37748E-03 0.00139  4.52360E-04 0.00198  3.48492E-03 0.00130  4.51913E-04 0.00237  3.50105E-03 0.00138  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.51743E-04 0.00221  3.37953E-03 0.00155  4.50486E-04 0.00179  3.20846E-03 0.00142  4.48963E-04 0.00193  3.17480E-03 0.00147  4.49111E-04 0.00188  3.13715E-03 0.00150  4.49307E-04 0.00166  3.15277E-03 0.00180  4.50617E-04 0.00203  3.23276E-03 0.00169  4.51905E-04 0.00166  3.38143E-03 0.00126  4.51072E-04 0.00184  3.44465E-03 0.00099  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.51811E-04 0.00152  3.42910E-03 0.00148  4.51619E-04 0.00170  3.42159E-03 0.00173  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.50271E-04 0.00179  3.41657E-03 0.00134  4.52045E-04 0.00155  3.42369E-03 0.00176  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  4.50672E-04 0.00177  3.43290E-03 0.00206  4.50825E-04 0.00128  3.37676E-03 0.00175  4.50260E-04 0.00173  3.23390E-03 0.00172  4.48035E-04 0.00121  3.14496E-03 0.00161  4.49442E-04 0.00159  3.13926E-03 0.00188  4.49519E-04 0.00188  3.11713E-03 0.00128  4.48015E-04 0.00167  3.11764E-03 0.00166  4.51045E-04 0.00162  3.15304E-03 0.00141  4.49896E-04 0.00153  3.21475E-03 0.00143  4.50466E-04 0.00179  3.27127E-03 0.00122  4.50639E-04 0.00153  3.36269E-03 0.00125  4.49114E-04 0.00189  3.29939E-03 0.00164  4.49345E-04 0.00166  3.28758E-03 0.00139  4.48741E-04 0.00164  3.37373E-03 0.00159  4.49936E-04 0.00179  3.30376E-03 0.00145  4.50696E-04 0.00185  3.29728E-03 0.00157  4.49757E-04 0.00157  3.37070E-03 0.00205  4.49760E-04 0.00154  3.27555E-03 0.00129  4.49192E-04 0.00174  3.20612E-03 0.00150  4.48333E-04 0.00207  3.15184E-03 0.00160  4.48918E-04 0.00157  3.11709E-03 0.00173  4.47691E-04 0.00166  3.12635E-03 0.00162  4.50370E-04 0.00152  3.13811E-03 0.00157  4.48862E-04 0.00173  3.12671E-03 0.00133  4.49363E-04 0.00195  3.13510E-03 0.00170  4.49742E-04 0.00196  3.17949E-03 0.00160  4.49756E-04 0.00220  3.20955E-03 0.00143  4.50643E-04 0.00173  3.24718E-03 0.00107  4.50959E-04 0.00156  3.24127E-03 0.00145  4.50252E-04 0.00185  3.23365E-03 0.00172  4.49951E-04 0.00167  3.24564E-03 0.00141  4.49909E-04 0.00160  3.24452E-03 0.00128  4.49523E-04 0.00179  3.23389E-03 0.00163  4.49370E-04 0.00143  3.24221E-03 0.00178  4.50374E-04 0.00183  3.21595E-03 0.00164  4.48308E-04 0.00165  3.16383E-03 0.00158  4.47663E-04 0.00196  3.14169E-03 0.00195  4.49144E-04 0.00152  3.11805E-03 0.00201  4.47961E-04 0.00170  3.12876E-03 0.00159 ];
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
COMPILE_DATE              (idx, [1:  20]) = 'Oct 28 2025 11:28:10' ;
DEBUG                     (idx, 1)        = 0 ;
TITLE                     (idx, [1:  63]) = 'A008_d076_homo_U235_Th0.600_Pu0.000_U2330.000_U235E0.03000_w076' ;
CONFIDENTIAL_DATA         (idx, 1)        = 0 ;
INPUT_FILE_NAME           (idx, [1:  13]) = 'A008_d076.sss' ;
WORKING_DIRECTORY         (idx, [1:  25]) = '/home/sy_lu/test/nodl1000' ;
HOSTNAME                  (idx, [1:  17]) = 'tjzs-MZ73-LM1-000' ;
CPU_TYPE                  (idx, [1:  31]) = 'AMD EPYC 9V74 80-Core Processor' ;
CPU_MHZ                   (idx, 1)        = 168825172.0 ;
START_DATE                (idx, [1:  24]) = 'Mon Jun  8 10:04:16 2026' ;
COMPLETE_DATE             (idx, [1:  24]) = 'Mon Jun  8 10:18:51 2026' ;

% Run parameters:

POP                       (idx, 1)        = 200000 ;
CYCLES                    (idx, 1)        = 500 ;
SKIP                      (idx, 1)        = 20 ;
BATCH_INTERVAL            (idx, 1)        = 1 ;
SRC_NORM_MODE             (idx, 1)        = 2 ;
SEED                      (idx, 1)        = 1780884256024 ;
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

% Parallelization:

MPI_TASKS                 (idx, 1)        = 1 ;
OMP_THREADS               (idx, 1)        = 80 ;
MPI_REPRODUCIBILITY       (idx, 1)        = 0 ;
OMP_REPRODUCIBILITY       (idx, 1)        = 1 ;
OMP_HISTORY_PROFILE       (idx, [1:  80]) = [  1.00123E+00  9.95659E-01  1.00538E+00  9.97595E-01  9.99999E-01  1.00127E+00  1.00307E+00  1.00518E+00  1.00203E+00  9.98592E-01  1.00185E+00  1.00308E+00  1.00027E+00  9.89030E-01  9.91816E-01  9.98301E-01  1.00131E+00  1.00370E+00  1.00846E+00  1.00307E+00  9.92467E-01  9.96478E-01  1.00144E+00  9.97338E-01  1.00085E+00  1.00675E+00  9.93859E-01  1.00340E+00  1.00607E+00  9.98552E-01  9.88067E-01  1.00173E+00  1.00307E+00  9.99098E-01  1.00347E+00  9.98636E-01  9.95291E-01  9.95859E-01  1.00151E+00  9.96892E-01  9.95549E-01  1.00567E+00  9.99624E-01  1.00494E+00  1.00101E+00  1.00434E+00  9.97931E-01  1.00000E+00  9.96519E-01  1.00255E+00  9.91607E-01  9.93670E-01  1.00524E+00  9.97005E-01  9.99831E-01  1.00693E+00  9.93518E-01  1.00179E+00  1.00019E+00  1.00341E+00  9.95464E-01  1.00097E+00  1.00194E+00  9.92600E-01  1.00209E+00  1.00583E+00  1.00424E+00  1.00164E+00  1.00295E+00  1.00456E+00  9.96985E-01  1.00022E+00  9.97573E-01  1.00357E+00  1.00216E+00  1.00373E+00  9.95316E-01  9.99831E-01  1.00101E+00  9.94253E-01  ];
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

MIN_MACROXS               (idx, [1:   4]) = [  5.00000E-02 4.6E-09  0.00000E+00 0.0E+00 ];
DT_THRESH                 (idx, [1:   2]) = [  9.00000E-01  9.00000E-01 ] ;
ST_FRAC                   (idx, [1:   4]) = [  2.42858E-02 0.00012  0.00000E+00 0.0E+00 ];
DT_FRAC                   (idx, [1:   4]) = [  9.75714E-01 2.9E-06  0.00000E+00 0.0E+00 ];
DT_EFF                    (idx, [1:   4]) = [  7.36032E-01 1.2E-05  0.00000E+00 0.0E+00 ];
REA_SAMPLING_EFF          (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
REA_SAMPLING_FAIL         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_COL_EFF               (idx, [1:   4]) = [  7.36482E-01 1.2E-05  0.00000E+00 0.0E+00 ];
AVG_TRACKING_LOOPS        (idx, [1:   8]) = [  3.08094E+00 5.4E-05  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
CELL_SEARCH_FRAC          (idx, [1:  10]) = [  9.26192E-01 7.8E-06  7.37996E-02 9.8E-05  8.60517E-06 0.00316  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
AVG_TRACKS                (idx, [1:   4]) = [  3.87085E+01 6.8E-05  0.00000E+00 0.0E+00 ];
AVG_REAL_COL              (idx, [1:   4]) = [  3.87085E+01 6.8E-05  0.00000E+00 0.0E+00 ];
AVG_VIRT_COL              (idx, [1:   4]) = [  1.38501E+01 8.4E-05  0.00000E+00 0.0E+00 ];
AVG_SURF_CROSS            (idx, [1:   4]) = [  3.55000E+00 9.0E-05  0.00000E+00 0.0E+00 ];
LOST_PARTICLES            (idx, 1)        = 0 ;

% Run statistics:

CYCLE_IDX                 (idx, 1)        = 500 ;
SIMULATED_HISTORIES       (idx, 1)        = 100000243 ;
MEAN_POP_SIZE             (idx, [1:   2]) = [  2.00000E+05 0.00019 ] ;
MEAN_POP_WGT              (idx, [1:   2]) = [  2.00000E+05 0.00019 ] ;
SIMULATION_COMPLETED      (idx, 1)        = 1 ;

% Running times:

TOT_CPU_TIME              (idx, 1)        =  6.18625E+02 ;
RUNNING_TIME              (idx, 1)        =  1.45887E+01 ;
INIT_TIME                 (idx, [1:   2]) = [  7.78500E-02  7.78500E-02 ] ;
PROCESS_TIME              (idx, [1:   2]) = [  3.11667E-03  3.11667E-03 ] ;
TRANSPORT_CYCLE_TIME      (idx, [1:   3]) = [  1.45077E+01  1.45077E+01  0.00000E+00 ] ;
MPI_OVERHEAD_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
ESTIMATED_RUNNING_TIME    (idx, [1:   2]) = [  1.45857E+01  0.00000E+00 ] ;
CPU_USAGE                 (idx, 1)        = 42.40429 ;
TRANSPORT_CPU_USAGE       (idx, [1:   2]) = [  4.29963E+01 0.00110 ];
OMP_PARALLEL_FRAC         (idx, 1)        =  5.08993E-01 ;

% Memory usage:

AVAIL_MEM                 (idx, 1)        = 257398.64 ;
ALLOC_MEMSIZE             (idx, 1)        = 6046.10 ;
MEMSIZE                   (idx, 1)        = 5475.89 ;
XS_MEMSIZE                (idx, 1)        = 787.24 ;
MAT_MEMSIZE               (idx, 1)        = 3110.35 ;
RES_MEMSIZE               (idx, 1)        = 241.39 ;
IFC_MEMSIZE               (idx, 1)        = 0.00 ;
MISC_MEMSIZE              (idx, 1)        = 1336.92 ;
UNKNOWN_MEMSIZE           (idx, 1)        = 0.00 ;
UNUSED_MEMSIZE            (idx, 1)        = 570.20 ;

% Geometry parameters:

TOT_CELLS                 (idx, 1)        = 4 ;
UNION_CELLS               (idx, 1)        = 0 ;

% Neutron energy grid:

NEUTRON_ERG_TOL           (idx, 1)        =  0.00000E+00 ;
NEUTRON_ERG_NE            (idx, 1)        = 213707 ;
NEUTRON_EMIN              (idx, 1)        =  1.00000E-11 ;
NEUTRON_EMAX              (idx, 1)        =  2.00000E+01 ;

% Unresolved resonance probability table sampling:

URES_DILU_CUT             (idx, 1)        =  1.00000E-09 ;
URES_EMIN                 (idx, 1)        =  1.00000E+37 ;
URES_EMAX                 (idx, 1)        = -1.00000E+37 ;
URES_AVAIL                (idx, 1)        = 15 ;
URES_USED                 (idx, 1)        = 0 ;

% Nuclides and reaction channels:

TOT_NUCLIDES              (idx, 1)        = 30 ;
TOT_TRANSPORT_NUCLIDES    (idx, 1)        = 30 ;
TOT_DOSIMETRY_NUCLIDES    (idx, 1)        = 0 ;
TOT_DECAY_NUCLIDES        (idx, 1)        = 0 ;
TOT_PHOTON_NUCLIDES       (idx, 1)        = 0 ;
TOT_REA_CHANNELS          (idx, 1)        = 713 ;
TOT_TRANSMU_REA           (idx, 1)        = 0 ;

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

TOT_ACTIVITY              (idx, 1)        =  9.94462E+06 ;
TOT_DECAY_HEAT            (idx, 1)        =  6.78269E-06 ;
TOT_SF_RATE               (idx, 1)        =  3.21659E+02 ;
ACTINIDE_ACTIVITY         (idx, 1)        =  9.94462E+06 ;
ACTINIDE_DECAY_HEAT       (idx, 1)        =  6.78269E-06 ;
FISSION_PRODUCT_ACTIVITY  (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_DECAY_HEAT(idx, 1)        =  0.00000E+00 ;
INHALATION_TOXICITY       (idx, 1)        =  3.75636E+02 ;
INGESTION_TOXICITY        (idx, 1)        =  9.85778E-01 ;
ACTINIDE_INH_TOX          (idx, 1)        =  3.75636E+02 ;
ACTINIDE_ING_TOX          (idx, 1)        =  9.85778E-01 ;
FISSION_PRODUCT_INH_TOX   (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ING_TOX   (idx, 1)        =  0.00000E+00 ;
SR90_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
TE132_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
I131_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
I132_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
CS134_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
CS137_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
PHOTON_DECAY_SOURCE       (idx, [1:   2]) = [  2.04579E+06  3.15684E-08 ] ;
NEUTRON_DECAY_SOURCE      (idx, 1)        =  0.00000E+00 ;
ALPHA_DECAY_SOURCE        (idx, 1)        =  9.92658E+06 ;
ELECTRON_DECAY_SOURCE     (idx, 1)        =  4.44927E+06 ;

% Normalization coefficient:

NORM_COEF                 (idx, [1:   4]) = [  2.02420E+10 0.00011  0.00000E+00 0.0E+00 ];

% Analog reaction rate estimators:

CONVERSION_RATIO          (idx, [1:   2]) = [  1.22578E+00 0.00022 ];
TH232_FISS                (idx, [1:   4]) = [  1.64962E+13 0.00156  1.17073E-02 0.00155 ];
U235_FISS                 (idx, [1:   4]) = [  1.34771E+15 0.00016  9.56473E-01 3.5E-05 ];
U238_FISS                 (idx, [1:   4]) = [  4.48359E+13 0.00095  3.18200E-02 0.00093 ];
TH232_CAPT                (idx, [1:   4]) = [  1.30405E+15 0.00019  4.92897E-01 0.00012 ];
U235_CAPT                 (idx, [1:   4]) = [  2.65659E+14 0.00036  1.00413E-01 0.00035 ];
U238_CAPT                 (idx, [1:   4]) = [  6.73637E+14 0.00026  2.54617E-01 0.00020 ];

% Neutron balance (particles/weight):

BALA_SRC_NEUTRON_SRC      (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_FISS     (idx, [1:   2]) = [ 100000243 1.00000E+08 ] ;
BALA_SRC_NEUTRON_NXN      (idx, [1:   2]) = [ 0 1.56046E+05 ] ;
BALA_SRC_NEUTRON_VR       (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_TOT      (idx, [1:   2]) = [ 100000243 1.00156E+08 ] ;

BALA_LOSS_NEUTRON_CAPT    (idx, [1:   2]) = [ 65248169 6.53510E+07 ] ;
BALA_LOSS_NEUTRON_FISS    (idx, [1:   2]) = [ 34752074 3.48050E+07 ] ;
BALA_LOSS_NEUTRON_LEAK    (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_CUT     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_ERR     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_TOT     (idx, [1:   2]) = [ 100000243 1.00156E+08 ] ;

BALA_NEUTRON_DIFF         (idx, [1:   2]) = [ 0 -1.71363E-06 ] ;

% Normalized total reaction rates (neutrons):

TOT_POWER                 (idx, [1:   2]) = [  4.56849E+04 0.0E+00 ];
TOT_POWDENS               (idx, [1:   2]) = [  3.80000E-02 0.0E+00 ];
TOT_GENRATE               (idx, [1:   2]) = [  3.45036E+15 1.6E-06 ];
TOT_FISSRATE              (idx, [1:   2]) = [  1.40909E+15 9.4E-08 ];
TOT_CAPTRATE              (idx, [1:   2]) = [  2.64535E+15 6.8E-05 ];
TOT_ABSRATE               (idx, [1:   2]) = [  4.05443E+15 4.4E-05 ];
TOT_SRCRATE               (idx, [1:   2]) = [  4.04841E+15 0.00011 ];
TOT_FLUX                  (idx, [1:   2]) = [  1.99796E+17 8.5E-05 ];
TOT_PHOTON_PRODRATE       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_LEAKRATE              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
ALBEDO_LEAKRATE           (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_LOSSRATE              (idx, [1:   2]) = [  4.05443E+15 4.4E-05 ];
TOT_CUTRATE               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_RR                    (idx, [1:   2]) = [  1.56945E+17 6.8E-05 ];
INI_FMASS                 (idx, 1)        =  1.20223E+00 ;
TOT_FMASS                 (idx, 1)        =  1.20223E+00 ;

% Six-factor formula:

SIX_FF_ETA                (idx, [1:   2]) = [  1.22039E+00 0.00013 ];
SIX_FF_F                  (idx, [1:   2]) = [  8.77254E-01 4.4E-05 ];
SIX_FF_P                  (idx, [1:   2]) = [  6.98225E-01 7.0E-05 ];
SIX_FF_EPSILON            (idx, [1:   2]) = [  1.14012E+00 6.6E-05 ];
SIX_FF_LF                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_LT                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_KINF               (idx, [1:   2]) = [  8.52251E-01 0.00014 ];
SIX_FF_KEFF               (idx, [1:   2]) = [  8.52251E-01 0.00014 ];

% Fission neutron and energy production:

NUBAR                     (idx, [1:   2]) = [  2.44865E+00 1.6E-06 ];
FISSE                     (idx, [1:   2]) = [  2.02360E+02 9.4E-08 ];

% Criticality eigenvalues:

ANA_KEFF                  (idx, [1:   6]) = [  8.52246E-01 0.00014  8.46441E-01 0.00014  5.81020E-03 0.00190 ];
IMP_KEFF                  (idx, [1:   2]) = [  8.52334E-01 4.4E-05 ];
COL_KEFF                  (idx, [1:   2]) = [  8.52280E-01 0.00011 ];
ABS_KEFF                  (idx, [1:   2]) = [  8.52334E-01 4.4E-05 ];
ABS_KINF                  (idx, [1:   2]) = [  8.52334E-01 4.4E-05 ];
GEOM_ALBEDO               (idx, [1:   6]) = [  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00 ];

% ALF (Average lethargy of neutrons causing fission):
% Based on E0 = 2.000000E+01 MeV

ANA_ALF                   (idx, [1:   2]) = [  1.84206E+01 3.7E-05 ];
IMP_ALF                   (idx, [1:   2]) = [  1.84199E+01 1.2E-05 ];

% EALF (Energy corresponding to average lethargy of neutrons causing fission):

ANA_EALF                  (idx, [1:   2]) = [  2.00045E-07 0.00069 ];
IMP_EALF                  (idx, [1:   2]) = [  2.00166E-07 0.00023 ];

% AFGE (Average energy of neutrons causing fission):

ANA_AFGE                  (idx, [1:   2]) = [  1.47794E-01 0.00088 ];
IMP_AFGE                  (idx, [1:   2]) = [  1.47908E-01 0.00027 ];

% Forward-weighted delayed neutron parameters:

PRECURSOR_GROUPS          (idx, 1)        = 6 ;
FWD_ANA_BETA_ZERO         (idx, [1:  14]) = [  8.23028E-03 0.00121  2.49701E-04 0.00691  1.32583E-03 0.00293  1.30963E-03 0.00300  3.76617E-03 0.00181  1.17017E-03 0.00335  4.08779E-04 0.00548 ];
FWD_ANA_LAMBDA            (idx, [1:  14]) = [  7.80206E-01 0.00283  1.24867E-02 1.0E-05  3.17795E-02 4.4E-05  1.10177E-01 7.3E-05  3.19040E-01 3.6E-05  1.34352E+00 7.0E-05  8.45936E+00 0.00085 ];

% Beta-eff using Meulekamp's method:

ADJ_MEULEKAMP_BETA_EFF    (idx, [1:  14]) = [  6.83747E-03 0.00174  2.05460E-04 0.01010  1.09838E-03 0.00432  1.08925E-03 0.00438  3.13012E-03 0.00275  9.76508E-04 0.00463  3.37750E-04 0.00784 ];
ADJ_MEULEKAMP_LAMBDA      (idx, [1:  14]) = [  7.78372E-01 0.00405  1.24869E-02 1.5E-05  3.17790E-02 6.5E-05  1.10178E-01 0.00011  3.19066E-01 5.7E-05  1.34342E+00 0.00011  8.45035E+00 0.00129 ];

% Adjoint weighted time constants using Nauchi's method:

IFP_CHAIN_LENGTH          (idx, 1)        = 15 ;
ADJ_NAUCHI_GEN_TIME       (idx, [1:   6]) = [  5.46172E-05 0.00026  5.45993E-05 0.00027  5.72313E-05 0.00263 ];
ADJ_NAUCHI_LIFETIME       (idx, [1:   6]) = [  4.65468E-05 0.00023  4.65316E-05 0.00023  4.87747E-05 0.00263 ];
ADJ_NAUCHI_BETA_EFF       (idx, [1:  14]) = [  6.81656E-03 0.00190  2.07938E-04 0.01143  1.09432E-03 0.00532  1.08380E-03 0.00518  3.12252E-03 0.00291  9.71561E-04 0.00583  3.36429E-04 0.00920 ];
ADJ_NAUCHI_LAMBDA         (idx, [1:  14]) = [  7.77995E-01 0.00476  1.24869E-02 1.9E-05  3.17788E-02 7.3E-05  1.10192E-01 0.00013  3.19019E-01 6.4E-05  1.34350E+00 0.00013  8.45897E+00 0.00150 ];

% Adjoint weighted time constants using IFP:

ADJ_IFP_GEN_TIME          (idx, [1:   6]) = [  5.45719E-05 0.00061  5.45482E-05 0.00061  5.80545E-05 0.00668 ];
ADJ_IFP_LIFETIME          (idx, [1:   6]) = [  4.65082E-05 0.00059  4.64880E-05 0.00059  4.94749E-05 0.00666 ];
ADJ_IFP_IMP_BETA_EFF      (idx, [1:  14]) = [  6.74631E-03 0.00667  2.05287E-04 0.03783  1.11241E-03 0.01625  1.04025E-03 0.01768  3.09861E-03 0.00939  9.69523E-04 0.01850  3.20226E-04 0.03040 ];
ADJ_IFP_IMP_LAMBDA        (idx, [1:  14]) = [  7.61820E-01 0.01589  1.24883E-02 4.3E-05  3.17832E-02 0.00026  1.10238E-01 0.00043  3.19024E-01 0.00022  1.34413E+00 0.00038  8.46200E+00 0.00459 ];
ADJ_IFP_ANA_BETA_EFF      (idx, [1:  14]) = [  6.74587E-03 0.00653  2.04597E-04 0.03780  1.11016E-03 0.01579  1.04097E-03 0.01719  3.09900E-03 0.00920  9.68981E-04 0.01806  3.22171E-04 0.02999 ];
ADJ_IFP_ANA_LAMBDA        (idx, [1:  14]) = [  7.63875E-01 0.01566  1.24882E-02 4.3E-05  3.17825E-02 0.00026  1.10234E-01 0.00042  3.19031E-01 0.00022  1.34397E+00 0.00037  8.46019E+00 0.00446 ];
ADJ_IFP_ROSSI_ALPHA       (idx, [1:   2]) = [ -1.23679E+02 0.00665 ];

% Adjoint weighted time constants using perturbation technique:

ADJ_PERT_GEN_TIME         (idx, [1:   2]) = [  5.46284E-05 0.00017 ];
ADJ_PERT_LIFETIME         (idx, [1:   2]) = [  4.65563E-05 1.0E-04 ];
ADJ_PERT_BETA_EFF         (idx, [1:   2]) = [  6.81312E-03 0.00113 ];
ADJ_PERT_ROSSI_ALPHA      (idx, [1:   2]) = [ -1.24718E+02 0.00113 ];

% Inverse neutron speed :

ANA_INV_SPD               (idx, [1:   2]) = [  7.48205E-07 9.7E-05 ];

% Analog slowing-down and thermal neutron lifetime (total/prompt/delayed):

ANA_SLOW_TIME             (idx, [1:   6]) = [  2.88009E-06 9.2E-05  2.88010E-06 9.2E-05  2.87891E-06 0.00106 ];
ANA_THERM_TIME            (idx, [1:   6]) = [  4.97177E-05 0.00012  4.97175E-05 0.00012  4.97386E-05 0.00127 ];
ANA_THERM_FRAC            (idx, [1:   6]) = [  6.98501E-01 7.0E-05  6.99260E-01 7.2E-05  6.07518E-01 0.00183 ];
ANA_DELAYED_EMTIME        (idx, [1:   2]) = [  1.05087E+01 0.00287 ];
ANA_MEAN_NCOL             (idx, [1:   4]) = [  3.87085E+01 6.8E-05  4.43277E+01 0.00010 ];

% Group constant generation:

GC_UNIVERSE_NAME          (idx, [1:   1]) = '0' ;

% Micro- and macro-group structures:

MICRO_NG                  (idx, 1)        = 70 ;
MICRO_E                   (idx, [1:  71]) = [  2.00000E+01  6.06550E+00  3.67900E+00  2.23100E+00  1.35300E+00  8.21000E-01  5.00000E-01  3.02500E-01  1.83000E-01  1.11000E-01  6.74300E-02  4.08500E-02  2.47800E-02  1.50300E-02  9.11800E-03  5.50000E-03  3.51910E-03  2.23945E-03  1.42510E-03  9.06898E-04  3.67262E-04  1.48728E-04  7.55014E-05  4.80520E-05  2.77000E-05  1.59680E-05  9.87700E-06  4.00000E-06  3.30000E-06  2.60000E-06  2.10000E-06  1.85500E-06  1.50000E-06  1.30000E-06  1.15000E-06  1.12300E-06  1.09700E-06  1.07100E-06  1.04500E-06  1.02000E-06  9.96000E-07  9.72000E-07  9.50000E-07  9.10000E-07  8.50000E-07  7.80000E-07  6.25000E-07  5.00000E-07  4.00000E-07  3.50000E-07  3.20000E-07  3.00000E-07  2.80000E-07  2.50000E-07  2.20000E-07  1.80000E-07  1.40000E-07  1.00000E-07  8.00000E-08  6.70000E-08  5.80000E-08  5.00000E-08  4.20000E-08  3.50000E-08  3.00000E-08  2.50000E-08  2.00000E-08  1.50000E-08  1.00000E-08  5.00000E-09  1.00000E-11 ];

MACRO_NG                  (idx, 1)        = 2 ;
MACRO_E                   (idx, [1:   3]) = [  1.00000E+37  6.25000E-07  0.00000E+00 ];

% Micro-group spectrum:

INF_MICRO_FLX             (idx, [1: 140]) = [  1.35866E+06 0.00088  5.49512E+06 0.00036  1.14895E+07 0.00027  1.27439E+07 0.00016  1.17956E+07 0.00018  1.26695E+07 0.00017  8.59471E+06 0.00011  7.57837E+06 0.00015  5.78273E+06 0.00018  4.72882E+06 0.00016  4.08517E+06 0.00024  3.68112E+06 0.00014  3.39907E+06 0.00022  3.23063E+06 0.00019  3.14718E+06 0.00020  2.71767E+06 0.00022  2.68725E+06 0.00017  2.64891E+06 0.00023  2.61392E+06 0.00030  5.07930E+06 0.00012  4.80921E+06 0.00015  3.49382E+06 0.00019  2.20595E+06 0.00020  2.71090E+06 0.00018  2.36166E+06 0.00021  2.29038E+06 0.00022  3.92412E+06 0.00019  8.84012E+05 0.00035  1.10892E+06 0.00031  1.00323E+06 0.00037  5.85429E+05 0.00044  1.01428E+06 0.00031  6.89961E+05 0.00030  5.93061E+05 0.00033  1.14268E+05 0.00078  1.13538E+05 0.00114  1.16237E+05 0.00092  1.19563E+05 0.00103  1.18281E+05 0.00085  1.16355E+05 0.00091  1.20076E+05 0.00071  1.12731E+05 0.00068  2.12881E+05 0.00068  3.39990E+05 0.00056  4.32564E+05 0.00051  1.14006E+06 0.00036  1.19351E+06 0.00035  1.27138E+06 0.00028  8.42148E+05 0.00032  6.29483E+05 0.00046  4.96916E+05 0.00039  5.82985E+05 0.00058  1.06943E+06 0.00032  1.49119E+06 0.00027  3.00090E+06 0.00021  4.95630E+06 0.00016  7.95763E+06 0.00014  5.43888E+06 0.00016  4.04803E+06 0.00021  2.99610E+06 0.00025  2.72516E+06 0.00019  2.74857E+06 0.00018  2.34758E+06 0.00018  1.60244E+06 0.00020  1.50418E+06 0.00020  1.34764E+06 0.00029  1.17892E+06 0.00025  9.08949E+05 0.00026  6.01093E+05 0.00032  2.09690E+05 0.00054 ];

% Integral parameters:

INF_KINF                  (idx, [1:   2]) = [  8.52280E-01 0.00011 ];

% Flux spectra in infinite geometry:

INF_FLX                   (idx, [1:   4]) = [  1.48029E+17 0.00012  5.17681E+16 6.5E-05 ];
INF_FISS_FLX              (idx, [1:   4]) = [  4.53960E+16 0.00014  1.47708E+16 4.6E-05 ];

% Reaction cross sections:

INF_TOT                   (idx, [1:   4]) = [  5.62481E-01 3.1E-05  1.42332E+00 2.4E-05 ];
INF_CAPT                  (idx, [1:   4]) = [  7.16552E-03 0.00015  3.06106E-02 4.7E-05 ];
INF_ABS                   (idx, [1:   4]) = [  8.29468E-03 0.00013  5.46012E-02 5.6E-05 ];
INF_FISS                  (idx, [1:   4]) = [  1.12916E-03 7.9E-05  2.39906E-02 6.7E-05 ];
INF_NSF                   (idx, [1:   4]) = [  2.86514E-03 8.1E-05  5.84579E-02 6.7E-05 ];
INF_NUBAR                 (idx, [1:   4]) = [  2.53742E+00 1.1E-05  2.43670E+00 3.8E-09 ];
INF_KAPPA                 (idx, [1:   4]) = [  2.03029E+02 6.8E-07  2.02270E+02 4.7E-09 ];
INF_INVV                  (idx, [1:   4]) = [  6.05583E-08 0.00012  2.71451E-06 2.7E-05 ];

% Total scattering cross sections:

INF_SCATT0                (idx, [1:   4]) = [  5.54185E-01 3.3E-05  1.36871E+00 2.5E-05 ];
INF_SCATT1                (idx, [1:   4]) = [  2.53393E-01 3.9E-05  3.42975E-01 5.2E-05 ];
INF_SCATT2                (idx, [1:   4]) = [  9.96267E-02 5.0E-05  8.08209E-02 0.00020 ];
INF_SCATT3                (idx, [1:   4]) = [  7.56749E-03 0.00067  2.42514E-02 0.00042 ];
INF_SCATT4                (idx, [1:   4]) = [ -1.07671E-02 0.00046 -7.43917E-03 0.00132 ];
INF_SCATT5                (idx, [1:   4]) = [  7.63382E-05 0.06057  5.82247E-03 0.00174 ];
INF_SCATT6                (idx, [1:   4]) = [  5.19492E-03 0.00069 -1.45267E-02 0.00074 ];
INF_SCATT7                (idx, [1:   4]) = [  7.60262E-04 0.00387  5.12193E-04 0.01650 ];

% Total scattering production cross sections:

INF_SCATTP0               (idx, [1:   4]) = [  5.54228E-01 3.3E-05  1.36871E+00 2.5E-05 ];
INF_SCATTP1               (idx, [1:   4]) = [  2.53393E-01 3.9E-05  3.42975E-01 5.2E-05 ];
INF_SCATTP2               (idx, [1:   4]) = [  9.96268E-02 5.0E-05  8.08209E-02 0.00020 ];
INF_SCATTP3               (idx, [1:   4]) = [  7.56753E-03 0.00067  2.42514E-02 0.00042 ];
INF_SCATTP4               (idx, [1:   4]) = [ -1.07671E-02 0.00046 -7.43917E-03 0.00132 ];
INF_SCATTP5               (idx, [1:   4]) = [  7.63728E-05 0.06046  5.82247E-03 0.00174 ];
INF_SCATTP6               (idx, [1:   4]) = [  5.19491E-03 0.00069 -1.45267E-02 0.00074 ];
INF_SCATTP7               (idx, [1:   4]) = [  7.60226E-04 0.00385  5.12193E-04 0.01650 ];

% Diffusion parameters:

INF_TRANSPXS              (idx, [1:   4]) = [  2.24136E-01 7.6E-05  9.57950E-01 4.0E-05 ];
INF_DIFFCOEF              (idx, [1:   4]) = [  1.48719E+00 7.6E-05  3.47965E-01 4.0E-05 ];

% Reduced absoption and removal:

INF_RABSXS                (idx, [1:   4]) = [  8.25200E-03 0.00013  5.46012E-02 5.6E-05 ];
INF_REMXS                 (idx, [1:   4]) = [  2.77013E-02 4.7E-05  5.54890E-02 9.3E-05 ];

% Poison cross sections:

INF_I135_YIELD            (idx, [1:   4]) = [  6.38332E-02 2.9E-06  6.28187E-02 3.8E-09 ];
INF_XE135_YIELD           (idx, [1:   4]) = [  1.70574E-03 9.2E-05  2.56634E-03 3.8E-09 ];
INF_PM147_YIELD           (idx, [1:   4]) = [  1.58275E-11 0.00010  2.48982E-11 2.7E-09 ];
INF_PM148_YIELD           (idx, [1:   4]) = [  2.98150E-11 8.9E-05  4.44969E-11 4.7E-09 ];
INF_PM148M_YIELD          (idx, [1:   4]) = [  5.57484E-11 8.2E-05  8.09942E-11 0.0E+00 ];
INF_PM149_YIELD           (idx, [1:   4]) = [  1.22782E-02 2.2E-05  1.08163E-02 3.8E-09 ];
INF_SM149_YIELD           (idx, [1:   4]) = [  1.08591E-12 0.00010  1.70988E-12 0.0E+00 ];
INF_I135_MICRO_ABS        (idx, [1:   4]) = [  9.92470E-01 0.00017  4.43433E+01 6.3E-05 ];
INF_XE135_MICRO_ABS       (idx, [1:   4]) = [  1.41584E+02 0.00044  1.74803E+06 6.4E-05 ];
INF_PM147_MICRO_ABS       (idx, [1:   4]) = [  6.30477E+01 0.00076  9.17023E+01 6.3E-05 ];
INF_PM148_MICRO_ABS       (idx, [1:   4]) = [  9.19335E+01 0.00017  1.10992E+03 6.3E-05 ];
INF_PM148M_MICRO_ABS      (idx, [1:   4]) = [  1.43949E+02 0.00016  1.81987E+04 6.4E-05 ];
INF_PM149_MICRO_ABS       (idx, [1:   4]) = [  5.01023E+01 0.00016  7.76950E+02 6.3E-05 ];
INF_SM149_MICRO_ABS       (idx, [1:   4]) = [  1.09787E+02 0.00039  5.03748E+04 7.4E-05 ];
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

INF_S0                    (idx, [1:   8]) = [  5.34780E-01 3.2E-05  1.94054E-02 8.5E-05  8.85896E-04 0.00085  1.36783E+00 2.5E-05 ];
INF_S1                    (idx, [1:   8]) = [  2.47669E-01 3.8E-05  5.72364E-03 0.00018  3.10238E-04 0.00179  3.42664E-01 5.3E-05 ];
INF_S2                    (idx, [1:   8]) = [  1.01301E-01 4.9E-05 -1.67467E-03 0.00033  1.87405E-04 0.00281  8.06335E-02 0.00020 ];
INF_S3                    (idx, [1:   8]) = [  9.61481E-03 0.00052 -2.04732E-03 0.00032  8.05053E-05 0.00470  2.41709E-02 0.00042 ];
INF_S4                    (idx, [1:   8]) = [ -1.00755E-02 0.00048 -6.91602E-04 0.00089  1.32278E-05 0.02299 -7.45239E-03 0.00133 ];
INF_S5                    (idx, [1:   8]) = [  6.05398E-05 0.07596  1.57984E-05 0.03836 -1.86605E-05 0.01648  5.84113E-03 0.00174 ];
INF_S6                    (idx, [1:   8]) = [  5.33840E-03 0.00069 -1.43479E-04 0.00383 -3.03431E-05 0.00747 -1.44964E-02 0.00075 ];
INF_S7                    (idx, [1:   8]) = [  9.39598E-04 0.00313 -1.79336E-04 0.00295 -3.08744E-05 0.00655  5.43067E-04 0.01534 ];

% Scattering production matrixes:

INF_SP0                   (idx, [1:   8]) = [  5.34823E-01 3.2E-05  1.94054E-02 8.5E-05  8.85896E-04 0.00085  1.36783E+00 2.5E-05 ];
INF_SP1                   (idx, [1:   8]) = [  2.47670E-01 3.8E-05  5.72364E-03 0.00018  3.10238E-04 0.00179  3.42664E-01 5.3E-05 ];
INF_SP2                   (idx, [1:   8]) = [  1.01301E-01 4.9E-05 -1.67467E-03 0.00033  1.87405E-04 0.00281  8.06335E-02 0.00020 ];
INF_SP3                   (idx, [1:   8]) = [  9.61485E-03 0.00052 -2.04732E-03 0.00032  8.05053E-05 0.00470  2.41709E-02 0.00042 ];
INF_SP4                   (idx, [1:   8]) = [ -1.00755E-02 0.00048 -6.91602E-04 0.00089  1.32278E-05 0.02299 -7.45239E-03 0.00133 ];
INF_SP5                   (idx, [1:   8]) = [  6.05744E-05 0.07580  1.57984E-05 0.03836 -1.86605E-05 0.01648  5.84113E-03 0.00174 ];
INF_SP6                   (idx, [1:   8]) = [  5.33839E-03 0.00069 -1.43479E-04 0.00383 -3.03431E-05 0.00747 -1.44964E-02 0.00075 ];
INF_SP7                   (idx, [1:   8]) = [  9.39562E-04 0.00312 -1.79336E-04 0.00295 -3.08744E-05 0.00655  5.43067E-04 0.01534 ];

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

CMM_TRANSPXS              (idx, [1:   4]) = [  2.38739E-01 0.00013  8.79565E-01 0.00040 ];
CMM_TRANSPXS_X            (idx, [1:   4]) = [  2.38882E-01 0.00016  8.82364E-01 0.00061 ];
CMM_TRANSPXS_Y            (idx, [1:   4]) = [  2.38810E-01 0.00019  8.82845E-01 0.00066 ];
CMM_TRANSPXS_Z            (idx, [1:   4]) = [  2.38527E-01 0.00020  8.73571E-01 0.00085 ];
CMM_DIFFCOEF              (idx, [1:   4]) = [  1.39622E+00 0.00013  3.78977E-01 0.00040 ];
CMM_DIFFCOEF_X            (idx, [1:   4]) = [  1.39539E+00 0.00016  3.77776E-01 0.00061 ];
CMM_DIFFCOEF_Y            (idx, [1:   4]) = [  1.39581E+00 0.00019  3.77571E-01 0.00066 ];
CMM_DIFFCOEF_Z            (idx, [1:   4]) = [  1.39747E+00 0.00020  3.81582E-01 0.00085 ];

% Delayed neutron parameters (Meulekamp method):

BETA_EFF                  (idx, [1:  14]) = [  6.83747E-03 0.00174  2.05460E-04 0.01010  1.09838E-03 0.00432  1.08925E-03 0.00438  3.13012E-03 0.00275  9.76508E-04 0.00463  3.37750E-04 0.00784 ];
LAMBDA                    (idx, [1:  14]) = [  7.78372E-01 0.00405  1.24869E-02 1.5E-05  3.17790E-02 6.5E-05  1.10178E-01 0.00011  3.19066E-01 5.7E-05  1.34342E+00 0.00011  8.45035E+00 0.00129 ];

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
DF_SURF_IN_CURR           (idx, [1:  16]) = [  1.72676E+15 0.00013  5.88546E+14 0.00024  1.72676E+15 0.00013  5.88546E+14 0.00024  1.72676E+15 0.00013  5.88546E+14 0.00024  1.72676E+15 0.00013  5.88546E+14 0.00024 ];
DF_SURF_OUT_CURR          (idx, [1:  16]) = [  1.72676E+15 0.00013  5.88546E+14 0.00024  1.72676E+15 0.00013  5.88546E+14 0.00024  1.72676E+15 0.00013  5.88546E+14 0.00024  1.72676E+15 0.00013  5.88546E+14 0.00024 ];
DF_SURF_NET_CURR          (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_MID_IN_CURR            (idx, [1:  16]) = [  1.72196E+14 0.00028  6.00224E+13 0.00053  1.72196E+14 0.00028  6.00224E+13 0.00053  1.72196E+14 0.00028  6.00224E+13 0.00053  1.72196E+14 0.00028  6.00224E+13 0.00053 ];
DF_MID_OUT_CURR           (idx, [1:  16]) = [  1.72196E+14 0.00028  6.00224E+13 0.00053  1.72196E+14 0.00028  6.00224E+13 0.00053  1.72196E+14 0.00028  6.00224E+13 0.00053  1.72196E+14 0.00028  6.00224E+13 0.00053 ];
DF_MID_NET_CURR           (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_CORN_IN_CURR           (idx, [1:  16]) = [  1.72994E+14 0.00032  5.77369E+13 0.00085  1.72994E+14 0.00032  5.77369E+13 0.00085  1.72994E+14 0.00032  5.77369E+13 0.00085  1.72994E+14 0.00032  5.77369E+13 0.00085 ];
DF_CORN_OUT_CURR          (idx, [1:  16]) = [  1.72994E+14 0.00032  5.77369E+13 0.00085  1.72994E+14 0.00032  5.77369E+13 0.00085  1.72994E+14 0.00032  5.77369E+13 0.00085  1.72994E+14 0.00032  5.77369E+13 0.00085 ];
DF_CORN_NET_CURR          (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_HET_VOL_FLUX           (idx, [1:   4]) = [  3.20235E+14 0.00013  1.11993E+14 7.6E-05 ];
DF_HET_SURF_FLUX          (idx, [1:  16]) = [  3.18963E+14 0.00016  1.10824E+14 0.00022  3.18963E+14 0.00016  1.10824E+14 0.00022  3.18963E+14 0.00016  1.10824E+14 0.00022  3.18963E+14 0.00016  1.10824E+14 0.00022 ];
DF_HET_CORN_FLUX          (idx, [1:  16]) = [  3.19203E+14 0.00042  1.08860E+14 0.00096  3.19203E+14 0.00042  1.08860E+14 0.00096  3.19203E+14 0.00042  1.08860E+14 0.00096  3.19203E+14 0.00042  1.08860E+14 0.00096 ];
DF_HOM_VOL_FLUX           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_HOM_SURF_FLUX          (idx, [1:  16]) = [  3.20235E+14 0.00013  1.11993E+14 7.6E-05  3.20235E+14 0.00013  1.11993E+14 7.6E-05  3.20235E+14 0.00013  1.11993E+14 7.6E-05  3.20235E+14 0.00013  1.11993E+14 7.6E-05 ];
DF_HOM_CORN_FLUX          (idx, [1:  16]) = [  3.20235E+14 0.00013  1.11993E+14 7.6E-05  3.20235E+14 0.00013  1.11993E+14 7.6E-05  3.20235E+14 0.00013  1.11993E+14 7.6E-05  3.20235E+14 0.00013  1.11993E+14 7.6E-05 ];
DF_SURF_DF                (idx, [1:  16]) = [  9.96028E-01 0.00014  9.89558E-01 0.00020  9.96028E-01 0.00014  9.89558E-01 0.00020  9.96028E-01 0.00014  9.89558E-01 0.00020  9.96028E-01 0.00014  9.89558E-01 0.00020 ];
DF_CORN_DF                (idx, [1:  16]) = [  9.96778E-01 0.00044  9.72022E-01 0.00095  9.96778E-01 0.00044  9.72022E-01 0.00095  9.96778E-01 0.00044  9.72022E-01 0.00095  9.96778E-01 0.00044  9.72022E-01 0.00095 ];
DF_SGN_SURF_IN_CURR       (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_SURF_OUT_CURR      (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_SURF_NET_CURR      (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_HET_SURF_FLUX      (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_HOM_SURF_FLUX      (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
DF_SGN_SURF_DF            (idx, [1:  16]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

