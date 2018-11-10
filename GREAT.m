(********1*********2*********3*********4*********5*********6*********7*****
 * GREAT.m = General Relativity, Einstein & All That 4 Mathematica
 * Package written by Tristan Hubsch: thubsch@howard.edu
 *                                    Howard University Physics
 *                                    string.howard.edu/~tristan/
 * Based on the package
 * "EinsteinTensor.m"
 * by Pekka Janhunen: pjanhune@finsun.csc.fi
 *    Finnish Meteorological Institute Geophysics Dept.
 **************************************************************************)

BeginPackage["GREAT`"]

(** Declare functions available after loading
 *                    by providing their usage explanation **)

IMetric::usage = "IMetric[g], with g an n.n-matrix (two lower indices),
  returns the inverse metric (two upper indices)."

Christoffel::usage = "Christoffel[g,x], with g a n.n-matrix and x
  n-vector of coordinates, gives the Christoffel symbol of the 2nd
  kind (1st upper, two lower indices)." 

Riemann::usage = "Riemann[g,x], with g a n.n-matrix and x n-vector of
  coordinates, gives the Riemann tensor (1st upper, three lower
  indices)."

Ricci::usage = "Ricci[g,x], with g a n.n-matrix and x n-vector of
  coordinates, gives the Ricci tensor (two lower symmetric indices)."

SCurvature::usage = "SCurvature[g,x], with g a n.n-matrix and x
  n-vector of coordinates, gives the Scalar Curvature."

EinsteinTensor::usage = "EinsteinTensor[g,x] with g a nxn-matrix
  (the metric with lower indices) and x n-vector (the coordinates)
  gives the Einstein tensor (a nxn-matrix) with lower indices."

SqRicci::usage = "SqRicci[g,x], with g a n.n-matrix and x
  n-vector of coordinates, gives the norm-square of the Ricci tensor."

SqRiemann::usage = "SqRiemann[g,x], with g a n.n-matrix and x
  n-vector of coordinates, gives the norm-square of the Riemann tensor."

helpGREAT::usage = "GREAT functions are: IMetric, Christoffel,
  Riemann, Ricci, SCurvature, EinsteinTensor, SqRicci, SqRiemann."

Begin["`Private`"]

IMetric[metric_] := Simplify[Inverse[metric]];

Christoffel[metric_,x_]:=
  Block[{Dim, iMet, PreChristoffel, Christoffel, i, j, k},
         Dim = Length[x];
         iMet = IMetric[metric];
           (* Metric with upper indices *)
         PreChristoffel =
           Table[ D[metric[[k,i]],x[[j]]]
                + D[metric[[j,k]],x[[i]]]
                - D[metric[[i,j]],x[[k]]],
          	   {k,Dim}, {i,Dim}, {j,Dim} ];
          	 (* The \{k,ij\} Christoffel symbols *)
         PreChristoffel = Simplify[PreChristoffel];
            (* The \Gamma^k_{ij} Christoffel symbols *)
         Christoffel = (1/2) iMet . PreChristoffel;
         (* Return the Christoffel symbol: *)
         Simplify[Christoffel] ]

Riemann[metric_,x_]:=
  Block[ {Dim, iMet, ChrisSymbol, Riemann, PreRiemann,
          a, b, c, i, j, k},
          Dim = Length[x];
          iMet = IMetric[metric];
          ChrisSymbol = Christoffel[metric,x];
          PreRiemann = 
             Table[ D[ChrisSymbol[[a,i,c]],x[[b]]]
                  + Sum[ChrisSymbol[[k,i,c]]
                        * ChrisSymbol[[a,k,b]],
                        {k,Dim} ],
                    {a,Dim}, {i,Dim}, {b,Dim}, {c,Dim} ];
           	(* Riemann tensor (1st upper, three lower indices)
           	   is antisymmetrized PreRiemann: *)
          Riemann = Table[ PreRiemann[[a,i,b,c]]
                         - PreRiemann[[a,i,c,b]],
                           {a,Dim}, {i,Dim}, {b,Dim}, {c,Dim} ];
          (* Return the Riemann tensor: *)
          Simplify[Riemann] ]

Ricci[metric_,x_]:=
  Block[ {Dim, Riem, Ricci, a, i, j},
          Dim = Length[x];
          Riem = Riemann[metric,x];
          Ricci = Table[ Sum[Riem[[a,i,a,j]], {a,Dim}],
                         {i,Dim}, {j,Dim} ];
          (* Return the Ricci tensor (two lower indices): *)
          Simplify[Ricci] ]

SCurvature[metric_,x_]:=
  Block[ {Dim,iMet,CurvatureScalar,i,j},
          Dim=Length[x];
          iMet=IMetric[metric];
          CurvatureScalar=Tr[iMet.Ricci[metric,x]];
    (*Return Scalar Curvature:*)Simplify[CurvatureScalar]]

EinsteinTensor[metric_,x_]:=
  Simplify[Ricci[metric,x] - (1/2) SCurvature[metric,x] metric];

SqRicci[metric_,x_]:=
  Block[ {Dim, iMet, Ric, RRicci, i, j, k, l},
          Dim = Length[x];
          iMet = IMetric[metric];
          Ric = iMet.Ricci[metric, x];
          RRicci = Tr[Ric.Ric];
          (*Return norm - square of Ricci tensor :*)Simplify[RRicci]]

SqRiemann[metric_, x_] := Block[{Dim, iMet, Riem,
   RRiem, i, j, k, l, m, n, p, q}, Dim = Length[x];
    iMet = IMetric[metric];
    Riem = Riemann[metric, x].iMet;
    RRiem = Sum[Riem[[i, j, l, k]]*
    Riem[[l, k, i, j]], {i, Dim}, {j, Dim}, {k, Dim}, {l, Dim}];
    (*Return norm - square of Riemann tensor :*)Simplify[RRiem]]

helpGREAT:= Print["GREAT functions are: IMetric, Christoffel,
  Riemann, Ricci, SCurvature, EinsteinTensor, SqRicci, SqRiemann."]

End[]

EndPackage[]

helpGREAT

Print["Enter 'helpGREAT' for this list of functions"]


