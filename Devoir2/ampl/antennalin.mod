#Approximation du probleme de synthese robuste d'antennes
#par un probleme d'optimisation
# Modele lineaire de base


param N;
param samplesS;
param samplesP;
set rings = 1..N; # L'ensemble des anneaux
set S = 1..samplesS; # L'ensemble des points dans S
set P = 1..samplesP; # L'ensemble des points dans P
param diS{rings,S}; # Valeurs echantillonnee des di dans S
param diP{rings,P}; # Valeurs echantillonnee des di dans P

var x{rings};
var epsilon, >=0;

minimize erreurdiagramme : epsilon;


subject to S1{s in S}: sum{i in rings} x[i]*diS[i,s] <= epsilon;
subject to S2{s in S}: sum{i in rings} -x[i]*diS[i,s] <= epsilon;
subject to P1{p in P}: sum{i in rings} (1-x[i]*diP[i,p]) <= epsilon;
subject to P2{p in P}: sum{i in rings} (x[i]*diP[i,p]-1) <= epsilon;

