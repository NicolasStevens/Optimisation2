%generate plot Q3
close all
clear all
N=40;
m=101;
thetaS = 40;
thetaP = 50;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
theta = linspace(0,pi/2,m);
di = computedi(theta,r);
x0001=load('../res/antennarobustlintau0001.csv');
x001=load('../res/antennarobustlintau001.csv');

% X non-perturbés
eps1=0.05066248626;
eps2=0.06787996131;
figure();
plotD(x0001,r,di,thetaS,thetaP,eps1,'b');
plotD(x001,r,di,thetaS,thetaP,eps2,'g');
title('Undisturbed x');
%saveas(gcf, 'D-ModRobust1-001' ,'png');
%errN001 = ComputeErrorDia(x,r,50,40,eps1)
%errN01 = ComputeErrorDia(x2,r,50,40,eps2)

%err11=zeros(100,1);
%err12=zeros(100,1);

%err21=zeros(100,1);
%err22=zeros(100,1);

% X perturbés avec tau = 0.001

tau=0.001;
figure()
for i=1:100
	xsi=Genxsi(tau,N);
	disturbedx=x0001.*(1+xsi);
	disturbedx2=x001.*(1+xsi);
	plotD(disturbedx,r,di,thetaS,thetaP,eps1,'b'); 
	plotD(disturbedx2,r,di,thetaS,thetaP,eps2,'g'); 
	%err11(i) = ComputeErrorDia(disturbedx,r,50,40,eps1);
	%err21(i) = ComputeErrorDia(disturbedx2,r,50,40,eps2);
end
title('Disturbed x with tau=0.001');
%saveas(gcf, 'D-ModRobust1-test3Rob001' ,'png');

% X perturbés avec tau = 0.01
tau=0.01;
figure()
for i=1:100
	xsi=Genxsi(tau,N);
	disturbedx=x0001.*(1+xsi);
	disturbedx2=x001.*(1+xsi);
	plotD(disturbedx,r,di,thetaS,thetaP,eps1,'b'); 
	plotD(disturbedx2,r,di,thetaS,thetaP,eps2,'g'); 
	%err12(i) = ComputeErrorDia(x,r,50,40,eps1);
	%err22(i) = ComputeErrorDia(x2,r,50,40,eps2);
end
title('x perturbed with tau=0.01');
%saveas(gcf, 'D-ModRobust1-test3Rob01' ,'png');
%err1001 = sum(err11)/100
%err101 = sum(err12)/100
%err2001 = sum(err21)/100
%err201 = sum(err22)/100

