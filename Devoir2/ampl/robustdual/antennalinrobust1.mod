#Approximation du probleme de synthese robuste d'antennes
#par un probleme d'optimisation
# Modele lineaire robuste conservateur

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
set Integral := 1..mIntegral;

# Valeurs echantillonnee des di dans S
param diS{i in rings,j in S} = sum{k in Integral} (0.5*(2*pi/mIntegral)*cos(2*pi*(i/10)*cos(j*ThetaS/samplesS)*cos(2*pi*k/mIntegral))); 
# Valeurs echantillonnee des di dans P
param diP{i in rings,j in P} = sum{k in Integral} (0.5*(2*pi/mIntegral)*cos(2*pi*(i/10)*cos(ThetaP + j*(pi/2 - ThetaP)/samplesP)*cos(2*pi*k/mIntegral)));; 

param tau;


var x{rings};
var y1plus{rings,S},>=0; # Variables duales
var y1minus{rings,S},>=0;
var y2plus{rings,S},>=0;
var y2minus{rings,S},>=0;
var y3plus{rings,P},>=0;
var y3minus{rings,P},>=0;
var y4plus{rings,P},>=0;
var y4minus{rings,P},>=0;
var epsilon, >=0;

minimize erreurdiagramme : epsilon;

subject to dualConstraint1{i in rings, s in S} : y1plus[i,s] - y1minus[i,s] = diS[i,s]*x[i];
subject to dualConstraint2{i in rings, s in S} : y2plus[i,s] - y2minus[i,s] = diS[i,s]*x[i];
subject to dualConstraint3{i in rings, p in P} : y3plus[i,p] - y3minus[i,p] = diP[i,p]*x[i];
subject to dualConstraint4{i in rings, p in P} : y4plus[i,p] - y4minus[i,p] = diP[i,p]*x[i];

subject to S1{s in S}: sum{i in rings} (tau*(y1plus[i,s]+y1minus[i,s])+ diS[i,s]*x[i]) <= epsilon;
subject to S2{s in S}: sum{i in rings} (tau*(y2plus[i,s]+y2minus[i,s])- diS[i,s]*x[i]) <= epsilon;
subject to S3{p in P}: -1+sum{i in rings} (tau*(y3plus[i,p]+y3minus[i,p])+ diP[i,p]*x[i]) <= epsilon;
subject to S4{p in P}: 1+sum{i in rings} (tau*(y4plus[i,p]+y4minus[i,p])- diP[i,p]*x[i]) <= epsilon;
