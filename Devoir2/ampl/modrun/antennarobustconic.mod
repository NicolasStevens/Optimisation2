#Approximation du probleme de synthese robuste d'antennes
#par un probleme d'optimisation
# Modele conique robuste

param N;
param samplesS;
param samplesP;
set rings = 1..N; # L'ensemble des anneaux
set S = 0..samplesS; # L'ensemble des points dans S
set P = 0..samplesP; # L'ensemble des points dans P
param ThetaP;
param ThetaS;

param pi = 4 * atan(1);
param mIntegral := 200;
set Integral := 0..(mIntegral-1);

# Valeurs echantillonnee des di dans S
param diS{i in rings,j in S} = sum{k in Integral} (0.5*(2*pi/mIntegral)*cos(2*pi*(i/10)*cos(j*ThetaS/samplesS)*cos(2*pi*k/mIntegral))); 
# Valeurs echantillonnee des di dans P
param diP{i in rings,j in P} = sum{k in Integral} (0.5*(2*pi/mIntegral)*cos(2*pi*(i/10)*cos(ThetaP + j*(pi/2 - ThetaP)/samplesP)*cos(2*pi*k/mIntegral)));; 

param tau;
param gamma = 3*tau;

var x{rings};
var y1{S}>=0; # Variables duales
var y2{S}>=0;
var y3{P}>=0;
var y4{P}>=0;
var epsilon>=0;

minimize erreurdiagramme : epsilon;

subject to dualConstraint1{s in S} : sum{i in rings} diS[i,s]*x[i]*diS[i,s]*x[i] <= y1[s]*y1[s];
subject to dualConstraint2{s in S} : sum{i in rings} diS[i,s]*x[i]*diS[i,s]*x[i] <= y2[s]*y2[s];
subject to dualConstraint3{p in P} : sum{i in rings} diP[i,p]*x[i]*diP[i,p]*x[i] <= y3[p]*y3[p];
subject to dualConstraint4{p in P} : sum{i in rings} diP[i,p]*x[i]*diP[i,p]*x[i] <= y4[p]*y4[p];

subject to S1{s in S}: gamma^2 * y1[s] <= epsilon - sum{i in rings} (diS[i,s]*x[i]);
subject to S2{s in S}: gamma^2 * y2[s] <= epsilon + sum{i in rings} (diS[i,s]*x[i]);
subject to S3{p in P}: gamma^2 * y3[p] <= epsilon + 1 - sum{i in rings} (diP[i,p]*x[i]);
subject to S4{p in P}: gamma^2 * y4[p] <= epsilon - 1 + sum{i in rings} (diP[i,p]*x[i]);


