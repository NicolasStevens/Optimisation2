%generate plot Q2
close all
N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
thetaS = 40;
thetaP = 50;
x=load('../res/antennalin4050.csv');
theta = linspace(0,pi/2,m);
di = computedi(theta,r);
eps1=0.02353672414;
eps2=0.07138589138;
% Nombre d'instances du vecteur aleatoires xi
nbXsi=5;
% Affichage du diagramme avec des erreurs de tau = 0.001
err=zeros(nbXsi,1);
tau=0.001;
for i=1:nbXsi
    x=load('../res/antennalin4050.csv');
	xsi=Genxsi(tau,N);
	x=x.*(1+xsi);
	plotD(x,r,di,thetaS,thetaP,eps1,'g'); hold on;
	err(i) = ComputeErrorDia(x,r,50,40,eps);
end
saveas(gcf, 'D-ModLin-2RobustTau001' ,'png');

% Affichage du diagramme avec des erreurs de tau = 0.01
figure();
err2=zeros(nbXsi,1);
tau=0.01;
for i=1:nbXsi 
    x=load('../res/antennalin4050.csv');
	xsi=Genxsi(tau,N);
	x=x.*(1+xsi);
	%eps=0.09368302883;
	plotD(x,r,di,thetaS,thetaP,eps2,'b'); 
	err2(i) = ComputeErrorDia(x,r,50,40,eps);
end
saveas(gcf, 'D-ModLin-2RobustTau01' ,'png');
sum(err)/nbXsi
sum(err2)/nbXsi
