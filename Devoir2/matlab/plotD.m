function [] = plotD(x,r,S1,P1,eps,c)
%
%
%

N=length(x);
[S,P,diP,diS] = computeDiagram(45,45,r);
m=length(S);

for i=1:m
    DP(i) = x'*diP(:,i);
    DS(i) = x'*diS(:,i);
end
eps1=zeros(length(S1),1)+eps;
eps2=zeros(length(S1),1)-eps;
eps3=ones(length(P1),1)+eps;
eps4=ones(length(P1),1)-eps;



plot(S,DS,c); hold on;
plot(P,DP,c); 
plot(S1,eps1,'r');
plot(S1,eps2,'r');
plot(P1,eps3,'r');
plot(P1,eps4,'r');
xlabel('Theta');
ylabel('D(Theta)');
title(sprintf('Diagramme Total pour epsilon=%f \n', eps)); hold on;
%saveas(gcf, 'D-ModLin-Robust01' ,'png');
end

