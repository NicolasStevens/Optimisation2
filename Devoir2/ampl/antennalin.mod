#Approximation du probleme de synthese robuste d'antennes
#par un probleme d'optimisation
# Modele lineaire de base
param N;
param samplesS;
param samplesP;
param ThetaP;
param ThetaS;
set rings = 1..N; # L'ensemble des anneaux
set S = 0..samplesS; # L'ensemble des points dans S
set P = 0..samplesP; # L'ensemble des points dans P

param pi = 4 * atan(1);
param mIntegral := 200;
set Integral := 1..mIntegral;

# Valeurs echantillonnee des di dans S
param diS{i in rings,j in S} = sum{k in Integral} (0.5*(2*pi/mIntegral)*cos(2*pi*(i/10)*cos(j*ThetaS/samplesS)*cos(2*pi*k/mIntegral))); 
# Valeurs echantillonnee des di dans P
param diP{i in rings,j in P} = sum{k in Integral} (0.5*(2*pi/mIntegral)*cos(2*pi*(i/10)*cos(ThetaP + j*(pi/2 - ThetaP)/samplesP)*cos(2*pi*k/mIntegral)));; 

#somme de Rieman
#for{i in rings, j in P} {
#	param diP[i,j] := sum{k in Integral} (0.5*(2*pi/mIntegral)*cos(2*pi*(i/10)*cos(thetaP + j*(pi/2 - ThetaP)/samplesP)*cos(2*pi*k/mIntegral)));
#}
#for{i in rings, j in S} {
#	param diS[i,j] := sum{k in Integral} (0.5*(2*pi/mIntegral)*cos(2*pi*(i/10)*cos(j*ThetaS/samplesS)*cos(2*pi*k/mIntegral)));
#}

var x{rings};
var epsilon, >=0;

minimize erreurdiagramme : epsilon;


subject to S1{s in S}: sum{i in rings}(x[i]*diS[i,s]) <= epsilon;
subject to S2{s in S}: sum{i in rings}(-x[i]*diS[i,s]) <= epsilon;
subject to P1{p in P}: 1-sum{i in rings}(x[i]*diP[i,p]) <= epsilon;
subject to P2{p in P}: -1+sum{i in rings}(x[i]*diP[i,p]) <= epsilon;

