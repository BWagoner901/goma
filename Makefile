#/************************************************************************ *
#* Goma - Multiphysics finite element software                             *
#* Sandia National Laboratories                                            *
#*                                                                         *
#* Copyright (c) 2014 Sandia Corporation.                                  *
#*                                                                         *
#* Under the terms of Contract DE-AC04-94AL85000 with Sandia Corporation,  *
#* the U.S. Government retains certain rights in this software.            *
#*                                                                         *
#* This software is distributed under the GNU General Public License.      *
#\************************************************************************/
 
# Makefile for goma
#
     MAKEFILE_NAME = Makefile
#
# $Id: Makefile,v 5.5 2010-07-22 16:34:28 sarober Exp $
#
#
# Instructions:	Read the comments below and modify accordingly for your
#		platform.
#
# Note:		Don't forget to do a "make depend" on most machines.
#
#
###############################################################################
#
#        MACHINE AND ARCHETECTURE SETTINGS
#       -----------------------------------
#
# Select the ARCH and MACH option appropriate for your platform.
# 
# This makefile is set for 880 LAN machines with Red Hat Enterprise 5 Linux:
              MACH = linux
              ARCH = rhel6_ompi
#
# If underscore_machine is needed for library differentiation:
#             _MACH = _$(MACH)
# Default: leave blank
             _MACH = 
#
###############################################################################
#
#        PURIFY
#       --------
#
# Examples:
#              PURE = purify
#              PURE = purify -cache-dir="/tmp"
#              PURE = quantify -cache-dir="/tmp"
#         PURE_PATH = /usr/local/rational/releases/purify.i386_linux2.2003a.06.00
#         PURE_PATH = /usr/local/bin
#
# Default: no purify
              PURE =
#
###############################################################################
#
#        COMPILER AND LIB SETTINGS
#       ---------------------------
#
# GOMA_LIBS is your base location for all goma-related software
         GOMA_LIBS = /home/goma/production/$(ARCH)
#
# MPI_TOP is the base location of the mpi compilers and libs
           MPI_TOP = /usr/bin/openmpi-1.6.3
#
# GCC_TOP is the corresponding location of the gcc compilers and libs that are
# used by the MPI compilers
           GCC_TOP = /usr
#
# For MPI, the libraries need to be explicitly set in the path:
           GCC_LIB = $(GCC_TOP)
         GCC_LIB64 = $(GCC_TOP)
  LD_LIBRARY_PATH := $(GCC_LIB64):$(GCC_LIB):${LD_LIBRARY_PATH}
#
# MPI Compilers
                CC = $(MPI_TOP)/bin/mpicc
               CPP = $(MPI_TOP)/bin/mpiCC
                FC = $(MPI_TOP)/bin/mpif77
# Serial Compilers
#                CC = $(GCC_TOP)/bin/gcc
#               CPP = $(GCC_TOP)/bin/g++
#                FC = $(GCC_TOP)/bin/gfortran
#
###############################################################################
#
#        FUNCTION AND APPLICATION SETTINGS
#       -----------------------------------
#
# For install top location:
               TOP = 
#
                LD = $(PURE) $(CPP)
#
             SHELL = /bin/sh
              MAKE = make
           INSTALL = cp
         INSTFLAGS = 
                RM = rm -f
               LEX = flex
              YACC = bison
#
           APREPRO = aprepro
          EXO1EXO2 = ex1ex2v2
             FASTQ = fastq
             GJOIN = gjoin
             GEN3D = gen3d
            GREPOS = grepos
             GROPE = grope
#
                AR = ar
           ARFLAGS = srv
            RANLIB = touch
#
###############################################################################
#
#        LOCAL DEFINES SECTION
#       -----------------------
#
#  USE_CHEMKIN: If you want to use chemkin, you need to define this
#               compiler definition during the compile.
#  SENKIN_OUTPUT: If you want to use senkin postprocessor, define
#                 this along with the USE_CHEMKIN compiler directive.
#  PARALLEL:    If you want to run parallel applications, define
#               This. This works even for serial applications, if
#               you add the prefix "mpirun -np 1" to your command
#               line. Therefore, I have made this the default.
#  MATRIX_DUMP: Define this if you want to enable the dumping of
#               matrices to disk.
#  TRILINOS:    Define this if you want to link to the new Trilinos
#               linear solver package, including its version of Aztec.
#
#  'platform:'  Several 'ifdef's on platform type still exist.
#               The following platforms must contain a -D'platform'
#               DEFINE on the compile line:
#                      Linux       -Dlinux
#                      (if 64bit compiler)     -DCOMPILER_64BIT
#
           DEFINES = -Dlinux \
                     -DCOMPILER_64BIT \
                     -DENABLE_AMESOS \
                     -DTRILINOS \
                     -DNO_CHEBYSHEV_PLEASE \
                     -DMDE=12 \
                     -DMAX_PROB_VAR=9 \
                     -DMAX_EXTERNAL_FIELD=4 \
                     -DMAX_CONC=2 \
                     -DCOUPLED_FILL \
                     -DPARALLEL \
                     -DEIGEN_SERIAL
#
# Other defines:
#                     -DCHECKFINITE
#                     -DMAX_CONC=1 \
#                     -DUSE_CGM \
#                     -DEIGEN_SERIAL \
#                     -DEIGEN_PARALLEL \
#                     -DNO_CHEBYSHEV_PLEASE \
#
#                     -DNEW_PARSER \
#                     -DSUN_SUNOS_57 \
#
#                     -D_RWSTD_COMPILE_INSTANTIATE \
#                     -DCOUPLED_FILL \
#                     -DXCODE \
#                     -DLIBRARY_MODE \
#                     -DUSE_CHEMKIN -DSENKIN_OUTPUT -DDEBUG_HKM \
#
###############################################################################
#
#        MPI SECTION
#       -------------
#
#          Should work without any knowledge of MPI...
#
# NO MPI
#           MPI_INC = 
#           MPI_LIB = 
#
# path to include/mpi.h
           MPI_INC = -I$(MPI_TOP)/include
#
# path to mpi libraries
           MPI_LIB = -L$(MPI_TOP)/lib  -lmpi  -lmpi_f77
#
###############################################################################
#
#        SEAMS LIBRARIES
#       -----------------
#
#    The engsci lan uses the SEAMS distribution defined by the link to
#    /usr/local/eng_sci/current
#
# For engsci LAN:
#         SEAMS_DIR = /projects/seacas/linux_rhel6/current
         SEAMS_DIR = $(GOMA_LIBS)/SEACAS-2012-09-10
#
# Users External to Sandia (e.g., CRMPC ):
#         SEAMS_DIR = $(GOMA_LIBS)/SEAMS
#
#        ==================================================
# ==>CHACO
#
# Default: no Chaco
         CHACO_LIB = 
#         CHACO_LIB = -lchaco
#
#        ==================================================
# ==>EXODUSII
#
      EXODUSII_LIB = -lexoIIv2c
#
#        ==================================================
# ==>NETCDF
#
        NETCDF_LIB = -L$(SEAMS_DIR)/lib  -lnetcdf  -lhdf5_hl  -lhdf5
#
#        ==================================================
#
         SEAMS_INC = -I$(SEAMS_DIR)/inc
         SEAMS_LIB = -L$(SEAMS_DIR)/lib  $(EXODUSII_LIB)  $(NETCDF_LIB) \
                      $(CHACO_LIB)
#
###############################################################################
#
#        TRILINOS LIBRARIES
#       --------------------
#
# Current path
      TRILINOS_TOP = $(GOMA_LIBS)/trilinos-10.10.2-Built
#
# Multiple ARCH options are available - choose yours.
#     TRILINOS_ARCH = LINUX_MPI
#     TRILINOS_ARCH = LINUX_SERIAL
#
#        ==================================================
# ==>KOMPLEX
# LOCA Hopf tracking in Aztec2.1+ requires the Komplex library
# and "KOMPLEX" must be defined above.
#       KOMPLEX_LIB = -lkomplex
#
# Default: Do not include KOMPLEX
       KOMPLEX_LIB =
#
#        ==================================================
# ==>AZTEC
# Aztecoo is required.
         AZTEC_LIB =  -laztecoo -lifpack 
#
#        ==================================================
# ==>AMESOS 
#
#        AMESOS_LIB = 
        AMESOS_LIB = -lamesos -lepetraext -lepetra -lteuchos 
#
#        ==================================================
#
#     TRILINOS_INC  = -I$(TRILINOS_TOP)/include  -I /home/hkmoffa/arch/linux64_gcc444/boost_1_44_0/include
     TRILINOS_INC  = -I$(TRILINOS_TOP)/include
     TRILINOS_LIB  = -L$(TRILINOS_TOP)/lib  $(AZTEC_LIB) \
                      $(KOMPLEX_LIB)  $(AMESOS_LIB)
#
###############################################################################
#
#        ARPACK SECTION
#       ----------------
#
#    To use ARPACK, either EIGEN_SERIAL or EIGEN_PARALLEL must be defined above.
#    Default is not to link in ARPACK.
#
        ARPACK_TOP = $(GOMA_LIBS)/ARPACK
#
#    Default: no arpack
        ARPACK_LIB =
#
#    EIGEN_SERIAL: arpack only
        ARPACK_LIB = -L$(ARPACK_TOP)/lib -larpack$(_MACH)
#
#    EIGEN_PARALLEL: parpack and arpack
#        ARPACK_LIB = -L$(ARPACK_TOP)/lib -lparpack_MPI$(_MACH) -larpack$(_MACH)
#
###############################################################################
#
#        BLAS and LAPACK LIBRARIES
#       ---------------------------
#
        LAPACK_LIB = -L$(GOMA_LIBS)/lapack-3.2.1 -llapack$(_MACH)
          BLAS_LIB = -L$(GOMA_LIBS)/BLAS -lblas$(_MACH)
#
###############################################################################
#
#        BRK/FIX LIBRARY
#       -----------------
#
# LIBRARY for brkfix for linking these objects directly to Goma.
#
           BRK_LIB = 
#           BRK_LIB = -L$(GOMA_LIBS)/brkfix/lib -lbrk
#
###############################################################################
#
#        CHEMKIN SECTION
#       -----------------
#
ARCH_NAME=$(MACH)
#
CHEMKIN_DEV_PATH   = /home/goma/chemkin_dev
#
CHEMKIN_ARCH_PATH  = $(CHEMKIN_DEV_PATH)/arch/$(ARCH_NAME)
#
CHEMKINIII_LIB_PATH = $(CHEMKIN_ARCH_PATH)/lib
#
CHEMKINIII_LIBS     =  -L$(CHEMKINIII_LIB_PATH) -lsklib -llklib \
                         -ltranlib -lcklib
CHEMKINIII_LIBS_DEP = $(CHEMKINIII_LIB_PATH)/libsklib.a \
                      $(CHEMKINIII_LIB_PATH)/liblklib.a \
                      $(CHEMKINIII_LIB_PATH)/libtranlib.a \
                      $(CHEMKINIII_LIB_PATH)/libcklib.a
#
CPC_LIB_PATH       = $(CHEMKINIII_LIB_PATH)
CPC_INC_PATH       = $(CHEMKIN_ARCH_PATH)/include
CPC_LIBS           = -L$(CPC_LIB_PATH) -lcpc -lckwrapper
CPC_LIBS_DEP       = $(CPC_LIB_PATH)/libcpc.a \
                     $(CPC_LIB_PATH)/libckwrapper.a
#
#  Default is to not link chemkin into Goma.
#  This is done by zeroing out these defines below.
#  If you want to include the chemkin libraries, take out '#chm'
#  in the lines below and add USE_CHEMKIN to the list of
#  preprocessor defines.
#
CHEMKIN_INC        = #chm -I$(CPC_INC_PATH)
CHEMKIN_DEPS       = #chm $(CPC_LIBS_DEP) $(CHEMKINIII_LIBS_DEP)
CHEMKIN_LIBS       = #chm $(CPC_LIBS) $(CHEMKINIII_LIBS)
#
###############################################################################
#
#        FRONTAL SOLVER LIBRARY
#       ------------------------
#
# The default is to include the frontal solver in compile.  However,
# it no longer functions properly under 64-bit builds and should not 
# be utilized as a solver.
#
         FRONT_LIB = -L$(GOMA_LIBS)/front/lib  -lmpfront$(_MACH) \
                     -lparlib$(_MACH)
#
###############################################################################
#
#        SPARSE LIBRARY
#       ----------------
#
        SPARSE_LIB = -L$(GOMA_LIBS)/sparse/lib  -lsparse$(_MACH)
#
###############################################################################
#
#        UMFPACK SOLVER LIBRARY
#       ------------------------
#
       UMFPACK_TOP = $(GOMA_LIBS)/UMFPACK-5.4
#
       UMFPACK_INC = -I$(UMFPACK_TOP)/Include
       UMFPACK_LIB = -L$(UMFPACK_TOP)/Lib  -lumfpack$(_MACH)  -lamd$(_MACH)
#
###############################################################################
#
#        OTHER SOLVER LIBRARIES
#       ------------------------
#
          Y12M_LIB = -L$(GOMA_LIBS)/y12m  -ly12m$(_MACH)
      PARMETIS_LIB = -L$(GOMA_LIBS)/ParMetis-3.1.1  -lparmetis$(_MACH) \
                     -lmetis$(_MACH)
       SUPERLU_LIB = -L$(GOMA_LIBS)/SuperLU_DIST_2.3/lib  -lsuperludist$(_MACH) 
       HARWELL_LIB =
#
###############################################################################
#
#        FORTRAN LIBRARIES
#       -------------------
#
       FORTRAN_LIB = -lc  -lgcc  -lstdc++  -lgfortran
#
###############################################################################
#
#        SYSTEM LIBRARIES
#       ------------------
#
           SYS_LIB = -lm  -lz
#
###############################################################################
#
#        GOMA AND SPARSE INCLUDES
#       --------------------------
#
# GOMA and SPARSE take include files from current working directory...
#
          GOMA_INC =
#
        SPARSE_INC =
#
##############################################################################
#
#        INCLUDES MACRO
#       ----------------
#
              _INC = -I.
#
          INCLUDES = $(_INC) $(GOMA_INC) $(SPARSE_INC) $(TRILINOS_INC) \
                     $(MPI_INC) $(SEAMS_INC) $(CHEMKIN_INC) $(UMFPACK_INC)
#
###############################################################################
#
#        COMPILER FLAG SECTION
#       -----------------------
#
# Set flags appropriate for platform and purpose. 
#
           CCFLAGS = -O3 -Wall
#           CCFLAGS = -g
#           CCFLAGS = -g -Wall -Wmissing-prototypes
#           CCFLAGS = -g -Wall -DDEBUG_IGNORE_ELEMENT_BLOCK_CAPABILITY
#
#------------------------------------------------------------------------------
#
            FFLAGS = $(CCFLAGS) $(DEFINES) $(INCLUDES)
#            FFLAGS = -64 -O2 $(DEFINES) $(INCLUDES)
#
            CFLAGS = $(CCFLAGS) $(DEFINES) $(INCLUDES)
          CPPFLAGS = $(CCFLAGS) $(DEFINES) $(INCLUDES) -Wno-deprecated
#
# If you're using the old non-C++ linker, then this is probably OK:
          LD_FLAGS = $(CCFLAGS)
#          LD_FLAGS = $(FFLAGS)
#
# Otherwise      LD = CC (or some other C++ compiler), and special flags
#          LD_FLAGS = $(CPPFLAGS)
#
###############################################################################
#
#        LIBRARY MACRO
#       ---------------
#
              LIBS = $(FRONT_LIB) \
                     $(SPARSE_LIB) \
                     $(TRILINOS_LIB) \
                     $(Y12M_LIB) \
                     $(SUPERLU_LIB) \
                     $(PARMETIS_LIB) \
                     $(LAPACK_LIB) \
                     $(ARPACK_LIB) \
                     $(HARWELL_LIB) \
                     $(UMFPACK_LIB) \
                     $(BLAS_LIB) \
                     $(BRK_LIB) \
                     $(SEAMS_LIB) 
#
          END_LIBS = $(MPI_LIB) \
                     $(FORTRAN_LIB) \
                     $(SYS_LIB)
#
# The following is a library dependence macro
#
           LIB_DEP = $(FRONT_DEP)
#
###############################################################################
#
#        TARGET: INSTALL MACROS
#       ------------------------
#
# The binaries and libraries will be different for each platform, but the
# include files will be the same.
#
            LIBDIR = $(TOP)/lib
            BINDIR = $(TOP)/bin
            INCDIR = $(TOP)/include
#
             G_LIB = libgoma.a
             U_LIB = libgomau.a
            TARGET = goma
#
###############################################################################
###############################################################################
#
#______ Users should not normally need to modify below this line ______________
#
###############################################################################
###############################################################################

# _____ Element routines "el_" prefix _________________________________________

EL_SRC=	el_elm_info.c el_quality.c exo_conn.c

EL_OBJ=	el_elm_info.o el_quality.o exo_conn.o

EL_INC=	el_elm.h\
        el_elm_info.h\
        el_geom.h\
        el_quality.h\
        exo_conn.h\
        exo_struct.h


# _____ Main routines _________________________________________________________

MAIN_SRC= main.c

MAIN_OBJ= main.o

MAIN_INC= std.h\
          goma.h


# _____ Geometry Model routines "gm_" prefix __________________________________

GM_SRC= gm_cgm_c_interface.C \
        gm_cgm_util.c

GM_OBJ= gm_cgm_c_interface.o \
        gm_cgm_util.o

GM_INC= gm_cgm_c_interface.h \
        gm_cgm_util.h \
        gm_cgm_typedefs.h


# _____ Advanced capabilities routines "ac_" prefix ___________________________

AC_SRC= ac_conti.c\
        ac_hunt.c\
        ac_update_parameter.c\
        ac_display_parameter.c\
        ac_loca_interface.c\
        ac_stability.c\
        ac_stability_util.c\
        ac_particles.c

AC_OBJ= ac_conti.o\
        ac_hunt.o\
        ac_update_parameter.o\
        ac_display_parameter.o\
        ac_loca_interface.o\
        ac_stability.o\
        ac_stability_util.o\
        ac_particles.o

AC_INC= ac_conti.h\
        ac_hunt.h\
        ac_update_parameter.h\
        ac_stability.h\
        ac_stability_util.h\
        ac_particles.h


# _____ Library of continuation algorithms "loca_" prefix _____________________

LOCA_SRC= loca_lib.c\
          loca_bord.c\
          loca_util.c\
          loca_eigenvalue.c \
          loca_eigen_c2f.F \
          loca_eigen_cayley.F

LOCA_OBJ= loca_lib.o\
          loca_bord.o\
          loca_util.o\
          loca_eigenvalue.o \
          loca_eigen_c2f.o \
          loca_eigen_cayley.o

LOCA_INC= loca_const.h\
          loca_util_const.h


# _____	Reacting flow routines "rf_" prefix ___________________________________

RF_SRC= rf_allo.c\
        rd_dpi.c\
        rf_element_storage.c\
        rd_exo.c\
        rd_mesh.c\
	rd_pixel_image.c \
	rd_pixel_image2.c \
        rf_node.c\
        rf_node_vars.c\
        rf_pre_proc.c\
        rf_setup_problem.c\
        rf_shape.c\
        rf_solve.c\
        rf_util.c\
        rf_vars.c\
        wr_dpi.c\
        wr_side_data.c\
        wr_soln.c\
        wr_exo.c

RF_OBJ= rf_allo.o\
        rd_dpi.o\
        rf_element_storage.o\
        rd_exo.o\
        rd_mesh.o\
	rd_pixel_image.o\
	rd_pixel_image2.o\
        rf_node.o\
        rf_node_vars.o\
        rf_pre_proc.o\
        rf_setup_problem.o\
        rf_shape.o\
        rf_solve.o\
        rf_util.o\
        rf_vars.o\
        wr_dpi.o\
        wr_side_data.o\
        wr_soln.o\
        wr_exo.o

RF_INC= rf_allo.h\
        rf_bc.h\
        rf_bc_const.h\
        rf_element_storage_const.h\
        rf_element_storage_struct.h\
        rf_fem.h\
        rf_fem_const.h\
        rf_fill_const.h\
        rf_io.h\
        rf_io_const.h\
        rf_io_defn.h\
        rf_io_structs.h\
        rf_masks.h\
        rf_masks_const.h\
        rf_masks_globs.h\
        rf_mp.h\
        rf_node.h\
        rf_node_const.h\
        rf_pre_proc.h\
        rf_shape.h\
        rf_solve.h\
        rf_solver.h\
        rf_solver_const.h\
        rf_util.h\
        rf_vars_const.h \
        rf_vars_defn.h\
        rd_dpi.h\
        rd_exo.h\
        rd_mesh.h\
	rd_pixel_image.h\
        wr_dpi.h\
        wr_exo.h\
        wr_side_data.h\
        wr_soln.h


# _____ Solver routines "sl_" prefix __________________________________________

SL_SRC= sl_lu.c\
        sl_lustat.c\
        sl_lu_fill.c\
        sl_ma28.c\
        sl_matrix_dump.c\
        sl_matrix_util.c\
        sl_squash.c\
        sl_util.c\
        sl_aux.c\
        sl_auxutil.c\
        sl_umf.c\
        sl_front_setup.c\
        sl_eggrollwrap.c\
        sl_eggrollutil.c\
        sl_eggroll01.c\
        sl_eggroll02.c\
        sl_eggroll03.c\
        sl_eggroll04.c\
        sl_eggroll05.c\
        sl_amesos_interface.C\
        sl_leastsquares.C

SL_OBJ= sl_lu.o\
        sl_lustat.o\
        sl_lu_fill.o\
        sl_ma28.o\
        sl_matrix_dump.o\
        sl_matrix_util.o\
        sl_squash.o\
        sl_util.o\
        sl_aux.o\
        sl_auxutil.o\
        sl_umf.o\
        sl_front_setup.o\
        sl_eggrollwrap.o\
        sl_eggrollutil.o\
        sl_eggroll01.o\
        sl_eggroll02.o\
        sl_eggroll03.o\
        sl_eggroll04.o\
        sl_eggroll05.o\
        sl_amesos_interface.o\
        sl_leastsquares.o

SL_INC= spConfig.h\
        spDefs.h\
        spmatrix.h\
        sl_aux.h\
        sl_auxutil.h\
        sl_eggroll.h\
        sl_eggroll_def.h\
        sl_lu.h\
        sl_matrix_util.h\
        sl_umf.h\
        sl_util.h\
        sl_util_structs.h \
        sl_rcm.h


# _____	Machine dependent routines "md_" prefix _______________________________

MD_SRC=	md_timer.c \
        md_ieee.c

MD_OBJ=	md_timer.o \
        md_ieee.o

MD_INC= md_timer.h


# _____ Distributed processing routines "dp_" prefix __________________________

DP_SRC= dp_comm.c\
        dp_map_comm_vec.c\
        dp_utils.c\
        dp_vif.c

DP_OBJ= dp_comm.o\
        dp_map_comm_vec.o\
        dp_utils.o\
        dp_vif.o

DP_INC= dp_comm.h\
        dp_map_comm_vec.h\
        dp_types.h\
        dp_utils.h\
        dp_vif.h\
        dpi.h


# _____	Boundary condition routines "bc_" prefix ______________________________

BC_SRC= bc_colloc.c\
        bc_curve.c\
        bc_dirich.c\
        bc_integ.c\
        bc_rotate.c\
        bc_special.c\
        bc_contact.c \
        bc_surfacedomain.c

BC_OBJ= bc_colloc.o\
        bc_curve.o\
        bc_dirich.o\
        bc_integ.o\
        bc_rotate.o\
        bc_special.o\
        bc_contact.o \
        bc_surfacedomain.o

BC_INC= bc_colloc.h\
        bc_curve.h\
        bc_dirich.h\
        bc_integ.h\
        bc_rotate.h\
        bc_special.h\
        bc_contact.h \
        bc_surfacedomain.h


# _____ Moving mesh routines "mm_" prefix _____________________________________

MM_SRC= mm_as_alloc.c\
        mm_augc_util.c\
        mm_bc.c\
        mm_bc_conflict.c\
        mm_chemkin.c\
        mm_dil_viscosity.c\
        mm_eh.c\
        mm_fill.c\
        mm_fill_aux.c\
        mm_fill_fill.c\
	mm_fill_ls.c \
        mm_fill_interface.c\
        mm_fill_jac.c\
        mm_fill_porous.c\
	mm_porous_EOS.c\
        mm_fill_potential.c\
        mm_fill_pthings.c\
        mm_fill_ptrs.c\
        mm_fill_rs.c\
        mm_fill_shell.c\
        mm_fill_solid.c\
        mm_fill_species.c\
        mm_fill_stress.c\
        mm_fill_common.c\
        mm_fill_terms.c\
        mm_fill_util.c\
        mm_flux.c\
        mm_input.c\
        mm_input_bc.c\
        mm_input_mp.c\
        mm_input_particles.c\
        mm_input_util.c\
        mm_interface.c\
        mm_matrl.c\
        mm_more_utils.c\
        mm_ns_bc.c\
        mm_shell_bc.c\
        mm_numjac.c\
        mm_placid.c\
        mm_post_proc.c\
        mm_post_proc_util.c\
        mm_prob_def.c\
        mm_propertyJac.c\
        mm_qp_storage.c\
        mm_qtensor_model.c\
        mm_shell_util.c\
        mm_sol_nonlinear.c\
        mm_species.c\
        mm_std_models.c \
        mm_std_models_shell.c\
        mm_unknown_map.c\
        mm_viscosity.c


MM_OBJ= mm_as_alloc.o\
        mm_augc_util.o\
        mm_bc.o\
        mm_bc_conflict.o\
        mm_chemkin.o\
        mm_dil_viscosity.o\
        mm_eh.o\
        mm_fill.o\
        mm_fill_aux.o\
        mm_fill_fill.o\
	mm_fill_ls.o\
        mm_fill_interface.o\
        mm_fill_jac.o\
        mm_fill_porous.o\
	mm_porous_EOS.o\
        mm_fill_potential.o\
        mm_fill_pthings.o\
        mm_fill_ptrs.o\
        mm_fill_common.o\
        mm_fill_terms.o\
        mm_fill_shell.o\
        mm_fill_solid.o\
        mm_fill_species.o\
        mm_fill_stress.o\
        mm_fill_rs.o\
        mm_fill_util.o\
        mm_flux.o\
        mm_input.o\
        mm_input_bc.o\
        mm_input_mp.o\
        mm_input_particles.o\
        mm_input_util.o\
        mm_interface.o\
        mm_matrl.o\
        mm_more_utils.o\
        mm_numjac.o\
	mm_ns_bc.o\
        mm_shell_bc.o\
        mm_placid.o\
        mm_post_proc.o\
        mm_post_proc_util.o\
        mm_prob_def.o\
        mm_propertyJac.o\
        mm_qp_storage.o\
        mm_qtensor_model.o\
        mm_shell_util.o\
        mm_sol_nonlinear.o\
        mm_species.o\
        mm_std_models.o\
	mm_std_models_shell.o\
        mm_unknown_map.o\
        mm_viscosity.o


MM_INC=	mm_as.h\
        mm_as_alloc.h\
        mm_as_const.h\
        mm_as_structs.h\
        mm_augc_util.h\
        mm_bc.h\
        mm_cards.h\
        mm_chemkin.h\
        mm_dil_viscosity.h\
        mm_eh.h\
        mm_elem_block.h\
        mm_elem_block_structs.h\
        mm_fill.h\
        mm_fill_aux.h\
        mm_fill_fill.h\
        mm_fill_jac.h\
        mm_fill_porous.h\
        mm_fill_potential.h\
        mm_fill_pthings.h\
        mm_fill_ptrs.h\
        mm_fill_rs.h\
        mm_fill_shell.h\
        mm_fill_solid.h\
        mm_fill_species.h\
        mm_fill_stress.h\
        mm_fill_common.h\
        mm_fill_terms.h\
        mm_fill_util.h\
        mm_flux.h\
        mm_input.h\
        mm_interface.h\
        mm_more_utils.h\
        mm_mp.h\
        mm_mp_const.h\
        mm_mp_structs.h\
        mm_names.h\
        mm_ns_bc.h\
        mm_shell_bc.h\
        mm_numjac.h\
        mm_parser.h\
        mm_post_def.h\
        mm_post_proc.h\
        mm_prob_def.h\
        mm_qp_storage.h\
        mm_qtensor_model.h\
        mm_shell_util.h\
        mm_sol_nonlinear.h\
        mm_species.h\
        mm_std_models.h\
	mm_std_models_shell.h\
        mm_unknown_map.h\
        mm_viscosity.h


# _____ User routines "user_" prefix __________________________________________

U_SRC=	user_ac.c\
        user_bc.c\
        user_continuation.c\
        user_mp.c \
        user_mp_gen.c \
        user_out_hkm.c\
        user_post.c\
        user_pre.c\
        user_print.c \
        user_senkin.F

U_OBJ=	user_ac.o\
        user_bc.o\
        user_continuation.o\
        user_mp.o\
        user_mp_gen.o\
        user_out_hkm.o\
        user_post.o\
        user_pre.o\
        user_print.o \
        user_senkin.o

U_INC=  user_ac.h\
        user_bc.h\
        user_continuation.h\
        user_mp.h\
        user_mp_gen.h\
        user_out_hkm.h\
        user_post.h\
        user_pre.h\
        usr_print.h


# _____ Lex/Yacc parser routines ______________________________________________

LY_SRC=	mm_parser.tab.c\
        t.tab.c\
        lex.t.c\
        lex.yy.c

LY_OBJ=	mm_parser.tab.o\
        t.tab.o\
        lex.t.o\
        lex.yy.o

# To build a version that uses the lex/yacc parser, comment out the following 
# two lines and activate the -DNEW_PARSER line in the defines section:
LY_SRC=	
LY_OBJ=


# _____ Full macros ___________________________________________________________

G_SRC=  $(BC_SRC) $(EL_SRC) $(RF_SRC) $(MAIN_SRC) $(SL_SRC) $(MD_SRC) $(MM_SRC)\
        $(DP_SRC) $(AC_SRC) $(LOCA_SRC) $(GM_SRC) $(LY_SRC)

G_OBJ=  $(BC_OBJ) $(EL_OBJ) $(RF_OBJ) $(MAIN_OBJ) $(SL_OBJ) $(MD_OBJ) $(MM_OBJ)\
        $(DP_OBJ) $(AC_OBJ) $(LOCA_OBJ) $(GM_OBJ) $(LY_OBJ)

SRCS=	$(G_SRC) $(U_SRC)

OBJS=	$(G_OBJ) $(U_OBJ)

INCS=   $(EL_INC) $(MAIN_INC) $(RF_INC) $(SL_INC) $(MD_INC) $(DP_INC) $(BC_INC)\
        $(MM_INC) $(U_INC) $(AC_INC) $(LOCA_INC) $(GM_INC)


###############################################################################
#
#______ Targets _______________________________________________________________
#
###############################################################################

all: goma

# Make all objects depend on all includes. This is reasonable for this project
# with its interdepencies.  Also Make the object files depend on this Makefile.
# We use static defines. So, any change in the Makefile where the defines are 
# located should cause a global recompile.
$(OBJS) : $(INCS) $(MAKEFILE_NAME)

#  GOMA target with no CHEMKIN linking
#
goma:	$(G_LIB) $(U_LIB) $(LIB_DEP)
	$(RM) $@;\
	$(LD) $(LD_FLAGS) -o $@ $(G_LIB) $(U_LIB) $(LIBS) $(END_LIBS)
#
# GOMA target with CHEMKIN linked in
#
goma_c:	$(G_LIB) $(U_LIB) $(LIB_DEP) $(CHEMKIN_DEPS)
	$(RM) $@;\
	$(LD) $(LD_FLAGS) -o $@ $(G_LIB) $(U_LIB) $(LIBS) $(CHEMKIN_LIBS) \
               $(END_LIBS)

# To build a version with the lex/yacc parser, uncomment the lines below:
mm_parser.tab.c: mm_parser.y mm_table.l mm_table.y mm_table.l lex.yy.c t.tab.c lex.t.c mm_cards.h mm_parser.h
	bison -dvtl  mm_parser.y
t.tab.c: mm_table.y mm_table.l mm_parser.h
	bison -dvtl -pt -bt mm_table.y 
lex.yy.c: mm_parser.l mm_parser.h
	flex -l mm_parser.l
lex.t.c: mm_table.l mm_parser.h
	flex -ls -t mm_table.l | sed -f yy_to_t_lsed > lex.t.c
# This is the end of the block that needs to be uncommneted to build the lex/yacc parser.


gomad:	$(G_OBJ) $(U_OBJ) $(LIB_DEP)
	$(RM) $@;\
	$(LD) $(LD_FLAGS) -o $@ $(G_OBJ) $(U_OBJ) $(LIBS) $(END_LIBS)

debug:
	$(MAKE) CCFLAGS="-g" gomad


$(G_LIB): $(G_OBJ)
	$(AR) $(ARFLAGS) $@ $?;\
	$(RANLIB) $@ 

$(U_LIB): $(U_OBJ)
	$(AR) $(ARFLAGS) $@ $?;\
	$(RANLIB) $@ 


install: $(TARGET) $(G_LIB) $(U_LIB)
	@if [ ! -d $(BINDIR) ]; then\
		echo "Making $(BINDIR)";\
		mkdir -p $(BINDIR);\
	fi;\
	echo "Installing $(TARGET) in $(BINDIR)...";\
	$(INSTALL) $(INSTFLAGS) $(TARGET) $(BINDIR);\
	if [ ! -d $(LIBDIR) ]; then\
		echo "Making $(LIBDIR)";\
		mkdir -p $(LIBDIR);\
	fi;\
	echo "Installing $(G_LIB) $(U_LIB) in $(LIBDIR)...";\
	$(INSTALL) $(INSTFLAGS) $(G_LIB) $(LIBDIR);\
	$(INSTALL) $(INSTFLAGS) $(U_LIB) $(LIBDIR);\
	if [ ! -d $(INCDIR) ]; then\
		echo "Making $(INCDIR)";\
		mkdir -p $(INCDIR);\
	fi;\
	echo "Installing includes in $(INCDIR)...";\
	for i in $(INCS); do \
		echo "Installing $$i";\
		$(INSTALL) $(INSTFLAGS) $$i $(INCDIR);\
	done


clean:
	-rm -f *.o *~ *.BAK libgoma.a libgomau.a

realclean:
	-rm -f *.o *~ *.BAK goma libgoma.a libgomau.a

tags:
	find . -name "*.[ch]" -exec etags -a '{}' \;

depend:
	makedepend -- $(INCLUDES) $(CFLAGS) -- $(SRCS)

.c.o:
	$(CC) -c $(CFLAGS) $<

.F.o:
	$(FC) -c $(FFLAGS) $<

.C.o:
	$(CPP) -c $(CPPFLAGS) $< 

.fas.exoII:
	$(RM) $@
	$(FASTQ) -aprepro -mesh=$*.gen $*.fas
	$(EXO1EXO2) $*.gen $*.exoII
	$(RM) $*.gen

LINT = lint -Aa -Dlint -D__lint
FLINT = lintfor -Dlint $(COMPFLAGS) $(F77FLAGS) $(LDEFINES)

.c.ln:
	$(LINT) $(CFLAGS) $(CPPFLAGS) -c $<

%.ln:%.F
	$(FLINT) $(CPPFLAGS) -c $<

LN_GOMA = $(CP_LN) $(CK_LN) $(MD_LN) $(BC_LN)

goma_lint: $(LN_GOMA)
	$(LINT) $(LN_GOMA) -lm

.SUFFIXES: .exoII .gen .fas .ln


# DO NOT DELETE THIS LINE -- make depend depends on it.
