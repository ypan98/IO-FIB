set CIUDADES;
set ARCOS within (CIUDADES cross CIUDADES);
set PRODS;

param OFERTA {CIUDADES,PRODS} >= 0;
param DEMANDA {CIUDADES,PRODS} >= 0;

check {p in PRODS}:
sum {i in CIUDADES} OFERTA[i,p]=sum{j in CIUDADES} DEMANDA[j,p];

param coste {ARCOS,PRODS} >= 0;
param CAP_CONJ {ARCOS} >= 0;

minimize Total_Coste;
node Nodo {k in CIUDADES, p in PRODS}:
net_in = DEMANDA[k,p] - OFERTA[k,p];

arc ENLACE {(i,j) in ARCOS, p in PRODS} >= 0,
from Nodo[i,p], to Nodo[j,p], obj Total_Coste coste[i,j,p];

subject to Multi {(i,j) in ARCOS}:
sum {p in PRODS} ENLACE[i,j,p] <= CAP_CONJ[i,j];
