/************************************************************************ *
* Goma - Multiphysics finite element software                             *
* Sandia National Laboratories                                            *
*                                                                         *
* Copyright (c) 2022 Goma Developers, National Technology & Engineering   *
*               Solutions of Sandia, LLC (NTESS)                          *
*                                                                         *
* Under the terms of Contract DE-NA0003525, the U.S. Government retains   *
* certain rights in this software.                                        *
*                                                                         *
* This software is distributed under the GNU General Public License.      *
* See LICENSE file.                                                       *
\************************************************************************/

/* sam_perea.h - prototype declarations for sam_perea.c
 */

#ifndef GOMA_SAM_PEREA_H
#define GOMA_SAM_PEREA_H

#ifdef EXTERN
#undef EXTERN
#endif

#ifdef GOMA_SAM_PEREA_C
#define EXTERN /* do nothing */
#endif

#ifndef GOMA_SAM_PEREA_C
#define EXTERN extern
#endif

EXTERN void assess_weights /* sam_perea.c */
    (Exo_DB *,             /* to find out num nodes, elems, etc. */
     Bevm ***,             /* mult - basic eqnvar multiplicity */
     int ***,              /* evd - eqnvar dependency */
     int *,                /* ebl - elemblock list */
     int *,                /* np - node pointers into element list */
     int *,                /* el - element list */
     int *,                /* ep - element pointers into node list */
     int *,                /* nl - node list */
     int *,                /* node_kind - list for all nodes */
     Node_Description **,  /* pnd - array ptrs to ea node description */
     int *,                /* num_basic_eqnvars - for ea elemblock */
                           /* ^^^^^  in  ^^^^^^ */
                           /* vvvvv  out vvvvvv */
     int *,                /* eqn_node_names - forea node-node interxtn */
     int *,                /* var_node_names - forea node-node interxtn */
     int *,                /* nnz_contribute - number non zeroes into A */
     int *,                /* nat_contribute - num assembed terms for A */
     int *);               /* ccs_contribute - comm cost sum this int.*/

#endif /* GOMA_SAM_PEREA_H */
