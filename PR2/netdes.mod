set N;
set O within N;
set A within N cross N; #fixed links
set Ahat within N cross N; #additonal links
set AA:=A union Ahat; #all the links

param xc {N};
param yc {N};
param t {i in N,l in O};
param c {(i,j) in AA, l in O} :=expression;
param f {(i,j) in Ahat} := expression;
param yb {(i,j) in Ahat};
param rho>0;
param restric {(i,j) in Ahat, l in O,k in 1..nCUT};
param ybk {(i,j) in Ahat,k in 1..nCUT};

node I {i in N, l in O}: net_out=t[i,l]; # si positivo ==> inyección, 
                                         # si negativo extracción
arc xl {(i,j) in AA, l in O}>=0: from I [i,l], to I [j,l];

# COMPLETE

