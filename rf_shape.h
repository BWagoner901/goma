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
 

#ifndef _RF_SHAPE_H
#define _RF_SHAPE_H

#ifdef EXTERN
#undef EXTERN
#endif

#ifdef _RF_SHAPE_C
#define EXTERN
#
#endif

#ifndef _RF_SHAPE_C
#define EXTERN extern
#endif

EXTERN double shape		/* rf_shape.c                                */
PROTO((const double ,		/* s - quadrature point coordinates          */
       const double ,		/* t                                         */
       const double ,		/* u                                         */
       const int ,		/* Ielem_type - element type                 */
       const int ,		/* Iquant - desired quantity (phi, phi_s, ...*/
       const int ));		/* Inode - current element node              */

#endif /* _RF_SHAPE_H */
