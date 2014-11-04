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
param mIntegral=50;

for{i in rings, j in P, k in mIntegral} {
	diP[i,j] = diP[i,j] + 0.5*cos(2*pi*(i/10)*cos(P[j]*(thetaP + j*(pi/2 - ThetaP)/sampleP))*cos(2*pi*k/mIntegral));
}
for{i in rings, j in S, k in mIntegral} {
	diS[i,j] = diS[i,j] + 0.5*cos(2*pi*(i/10)*cos(S[j]*(0 + j*ThetaS/sampleP))*cos(2*pi*k/mIntegral));
}

var x{rings};
var epsilon, >=0;

minimize erreurdiagramme : epsilon;


subject to S1{s in S}: sum{i in rings} x[i]*0.5*diS[i,s] <= epsilon;
subject to S2{s in S}: sum{i in rings} -x[i]*0.5*diS[i,s] <= epsilon;
subject to P1{p in P}: 1-sum{i in rings} (x[i]*0.5*diP[i,p]) <= epsilon;
subject to P2{p in P}: -1+sum{i in rings} (x[i]*0.5*diP[i,p]) <= epsilon;

