param N; # nombre ciutats
param c{1..N,1..N}; # distancies/temps/costs entre ciutats

var y{1..N,1..N} binary;
var t{1..N} >=1, <=N;

minimize fobj: sum{i in 1..N,j in 1..N} c[i,j]*y[i,j];

subject to van_a {i in 1..N}: sum{j in 1..N} y[i,j]= 1;
subject to venen_de {j in 1..N}: sum{i in 1..N} y[i,j]= 1;
subject to connectivitat {i in 1..N, j in 2..N : i != j}:
         t[j] >= t[i]+1-(N+1)*(1-y[i,j]);
subject to t1: t[1]= 1;
subject to no_yii {i in 1..N}: y[i,i]= 0;
