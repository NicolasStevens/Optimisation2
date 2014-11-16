function [S,P,diP,diS] = computeDiagram(thetaP,thetaS,r)
%
% 
%

%conversion en radian : 
thetaP = thetaP*pi/180;
thetaS = thetaS*pi/180;

N = length(r);
m=101;
l=101;

diS = zeros(N,m);
diP = zeros(N,m);
S = linspace(0,thetaS,m);
P = linspace(thetaP,pi/2,m);
xx=linspace(0,2*pi,l);

for i=1:N
    for j=1:m
        fS = 0.5*sin(2*pi*r(i)*cos(S(j))*cos(xx)).*(2*pi*r(i)*cos(xx)*sin(S(j)));
        fP = 0.5*sin(2*pi*r(i)*cos(P(j))*cos(xx)).*(2*pi*r(i)*cos(xx)*sin(P(j)));
        %fS = 0.5*cos(2*pi*r(i)*cos(S(j))*cos(xx));
        %fP = 0.5*cos(2*pi*r(i)*cos(P(j))*cos(xx));
        diP(i,j) = trapz(xx,fP);
        diS(i,j) = trapz(xx,fS);
        %diP(i,j) = (2*pi/l)*sum(0.5*cos(2*pi*r(i)*cos(S(j))*cos(xx)));
        %diS(i,j) = (2*pi/l)*sum(0.5*cos(2*pi*r(i)*cos(P(j))*cos(xx)));
    end
end

figure()
for i=N:N
plot(P,diP(i,:)); hold on;
plot(S,diS(i,:));
end
max(mean(diP))
max(mean(diS))
end

