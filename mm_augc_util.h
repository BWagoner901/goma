/************************************************************************ *
* Goma - Multiphysics finite element software                             *
* Sandia National Laboratories                                            *
*                                                                         *
* Copyright (c) 2014 Sandia Corporation.                                  *
*                                                                         *
* Under the terms of Contract DE-AC04-94AL85000 with Sandia Corporation,  *
* the U.S. Government retains certain rights in this software.            *
*                                                                         *
* This software is distributed under the GNU General Public License.      *
\************************************************************************/
 
#ifndef _MM_AUGC_UTIL_H
#define _MM_AUGC_UTIL_H

#ifdef EXTERN
#undef EXTERN
#endif

#ifdef _MM_AUGC_UTIL_C
#define EXTERN /* do nothing */
#endif

#ifndef _MM_AUGC_UTIL_C
#define EXTERN extern
#endif

/* identifies a data float as an aprepro parameter  */
 
#ifndef APREPRO_AC_BCID 
#define APREPRO_AC_BCID -9	
#endif

#include "loca_const.h"

EXTERN void update_parameterAC
PROTO((int,                     /* NUMBER OF AC'S */
       double*,                 /* SOLUTION VECTOR */
       double*,                 /* SOLUTION VECTOR TIME DERIVATIVE */
       double*, 		/* VECTOR OF EXTRA UNKNOWNS */
       Comm_Ex *,		/* cx  - array of communications structures */
       Exo_DB *,		/* exo - ptr to finite element mesh database */
       Dpi *));			/* dpi - ptr to distributed processing info */

EXTERN int user_aug_cond 
PROTO (( int ,
	 int ,
	 double [],
	 double **,
	 double **,
	 double **,
	 double  *,
	 int ,
	 double **,
	 Comm_Ex *,
	 MF_Args *) );
		
EXTERN int std_aug_cond 
PROTO (( int ,
	 int ,
	 double [],
	 double **,
	 double **,
	 double **,
	 double  *,
	 int ,
	 Comm_Ex *,
	 MF_Args *));

EXTERN void overlap_aug_cond 
PROTO (( int [],
         double [],
         double [],
         double  *,
         double **,
         double **,
         double **,
	 Comm_Ex *,
         MF_Args *));

EXTERN int std_lgr_cond 
PROTO (( int ,
	 int ,
	 double [],
	 double **,
	 double **,
	 double **,
	 double  *,
	 double  *,
	 double  *,
	 int ,
	 Comm_Ex *,
	 MF_Args *));
		
EXTERN int alc_aug_cond 
PROTO (( int ,
	 int ,
	 double [],
	 double **,
	 double **,
	 double **,
	 double  *,
	 double  *,
	 int ,
	 Comm_Ex *,
         struct con_struct *,
	 MF_Args *));

EXTERN void load_extra_unknownsAC
PROTO (( int,                     /* NUMBER OF AC'S */
	 double*,                 /* VECTOR OF EXTRA UNKNOWNS */
	 Comm_Ex *,               /* cx  - array of communications structures */
	 Exo_DB *,                /* exo - ptr to finite element mesh database */
	 Dpi *));                 /* dpi - ptr to distributed processing info */

EXTERN int arc_length_status
PROTO (( struct con_struct *,     /* Continuation data from LOCA */
         double,                  /* Arc length equation residual */
         double,                  /* Arc length parameter update */
         double,                  /* Relative convergence tolerance */
         double ));               /* Absolute convergence tolerance */

EXTERN int periodic_bc_cond
PROTO (( int,			  /* iAC */
	 int,			  /* nAC */
	 double [],		  /* x_AC */
	 double **,		  /* bAC */
	 double **,		  /* cAC */
	 double **,		  /* dAC */
	 double *,		  /* gAC */
	 double *,		  /* resid_vector */
	 double *,		  /* scale */
	 int,			  /* numProcUnknowns */
	 Comm_Ex *,		  /* cx */
	 MF_Args *));		  /* mf_args */

EXTERN int create_overlap_acs
PROTO (( Exo_DB *,                /* Ptr to ExodusII database */
         int ));                  /* Input Overlap AC index */

EXTERN int assign_overlap_acs
PROTO (( double [],
         Exo_DB * ));             /* Ptr to ExodusII database */


#endif /* _MM_AUGC_UTIL_H */
