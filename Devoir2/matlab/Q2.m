close all
N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
thetaS = 40;
thetaP = 50;
x=load('../res/antennalin4050.csv');
eps1=0.02353672414;
eps2=0.07138589138;
% Nombre d'instances du vecteur aléatoires xi
nbXsi=5;
%% Affichage du diagramme avec des erreurs de tau = 0.001
err=zeros(nbXsi,1);
tau=0.001;
for i=1:nbXsi
	xsi=Genxsi(tau,N);
	x=x.*(1+xsi);
	plotD(x,r,thetaS,thetaP,eps1,'g'); hold on;
	%err(i) = ComputeErrorDia(x,r,50,40,eps);
end
%saveas(gcf, 'D-ModLin-2RobustTau001' ,'png');

%% Affichage du diagramme avec des erreurs de tau = 0.01
figure();
err2=zeros(nbXsi,1);
tau=0.01;
for i=1:nbXsi 
	xsi=Genxsi(tau,N);
	x=x.*(1+xsi);
	[S,P,diP,diS] = computeDiagram(50,40,r);
	%eps=0.09368302883;
	plotD(x,r,S,P,eps2,'b'); 
	%err2(i) = ComputeErrorDia(x,r,50,40,eps);
end
%saveas(gcf, 'D-ModLin-2RobustTau01' ,'png');
%sum(err)/nbXsi
%sum(err2)/nbXsi
