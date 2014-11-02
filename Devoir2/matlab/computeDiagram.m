function [S,P,diP,diS] = computeDiagram(thetaP,thetaS,r)
%
% 
%

%conversion en radian : 
thetaP = thetaP*pi/180;
thetaS = thetaS*pi/180;

N = length(r);
m=50;
l=50;

diS = zeros(N,m);
diP = zeros(N,m);
S = linspace(0,thetaS,m);
P = linspace(thetaP,pi/2,m);
xx=linspace(0,2*pi,l);

for i=1:N
    for j=1:m
        fS = cos(2*pi*r(i)*cos(S(j))*cos(xx));
        fP = cos(2*pi*r(i)*cos(P(j))*cos(xx));
        diP(i,j) = trapz(xx,fP);
        diS(i,j) = trapz(xx,fS);
    end
end
figure()
plot(P,diP(1,:));
figure()
plot(S,diS(1,:));


end

