set CIUDADES;
set ARCOS within (CIUDADES cross CIUDADES);
param oferta {CIUDADES} >= 0; # inyecciones
param demanda {CIUDADES} >= 0; # extracciones
check: sum {i in CIUDADES}
oferta[i] = sum {j in CIUDADES} demanda[j];
param coste {ARCOS} >= 0; # costes de transp.
minimize Total_Coste;
node Nodo {k in CIUDADES}: net_in=demanda[k]-oferta[k];
arc enlace {(i,j) in ARCOS} >= 0,
from Nodo[i], to Nodo[j], obj Total_Coste coste[i,j];