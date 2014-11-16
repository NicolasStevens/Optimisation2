function [] = plotD(x,r,di,thetaS,thetaP,eps,c)
%
%function which plot the Diagram D using x, and di
%

N=length(x);
m = length(di(1,:));

thetaS = thetaS*pi/180;
thetaP = thetaP*pi/180;
theta = linspace(0,pi/2,m);

for i=1:m
    D(i) = x'*di(:,i);
end
eps1=zeros(m,1)+eps;
eps2=zeros(m,1)-eps;
eps3=ones(m,1)+eps;
eps4=ones(m,1)-eps;

plot(theta,D,c); hold on;
S1 = linspace(0,thetaS,m);
P1 = linspace(thetaP,pi/2,m);
plot(S1,eps1,'r');hold on;
plot(S1,eps2,'r');hold on;
plot(P1,eps3,'r');hold on;
plot(P1,eps4,'r');hold on;
xlabel('Theta');
ylabel('D(Theta)');
title(sprintf('Diagramme Total pour epsilon=%f \n', eps)); hold on;
%saveas(gcf, 'D-ModLin-Robust01' ,'png');
end

