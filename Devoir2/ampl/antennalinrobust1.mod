#Approximation du probleme de synthese robuste d'antennes
#par un probleme d'optimisation
# Modele lineaire robuste conservateur

param N;
param samplesS;
param samplesP;
set rings = 1..N; # L'ensemble des anneaux
set S = 1..samplesS; # L'ensemble des points dans S
set P = 1..samplesP; # L'ensemble des points dans P
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
param h;


var x{rings};
var vs{rings,S},>=0;
var vp{rings,P},>=0;
var epsilon, >=0;

minimize erreurdiagramme : epsilon;

subject to S1{s in S}: sum{i in rings} (x[i]*diS[i,s]+vs[i,s]) <= epsilon;
subject to S2{s in S}: sum{i in rings} (-x[i]*diS[i,s]+vs[i,s]) <= epsilon;
subject to P1{p in P}: 1-sum{i in rings} (x[i]*(diP[i,p]))+ sum{i in rings} (vp[i,p]) <= epsilon;
subject to P2{p in P}: -1+sum{i in rings} (x[i]*(diP[i,p]))+ sum{i in rings} (vp[i,p]) <= epsilon;

subject to contvsplus{s in S, i in rings} : tau*x[i]*diS[i,s]*h/2<=vs[i,s];
subject to contvsminus{s in S, i in rings} : -tau*x[i]*diS[i,s]*h/2<=vs[i,s];
subject to cont1pplus{p in P, i in rings} : tau*x[i]*diP[i,p]*h/2<=vp[i,p];
subject to contpminus{p in P, i in rings} : tau*x[i]*diP[i,p]*h/2<=vp[i,p];