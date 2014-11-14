function [] = plotD2(diP,diS,P,S,ThetaP,ThetaS,x,r,eps,c)
%
%
%

N=length(x);
%[S,P,diP,diS] = computeDiagram(45,45,r);
m=length(S);
l=m;
ThetaP = ThetaP*pi/180;
ThetaS = ThetaS*pi/180;

comp=linspace(ThetaS,ThetaP,15);
dicomp = zeros(40,15);
xx=linspace(0,2*pi,100);
for i=1:40
    for j=1:15
        fcomp = 0.5*cos(2*pi*r(i)*cos(comp(j))*cos(xx));
        dicomp(i,j) = trapz(xx,fcomp);
    end
end

DP=zeros(l,1);
DS=zeros(l,1);
Dint=zeros(15,1);
for i=1:m
    DP(i) = x'*diP(:,i);
    DS(i) = x'*diS(:,i);
    if (i<=15)
       Dint(i)= x'*dicomp(:,i); 
    end
end
eps1=zeros(length(S),1)+eps;
eps2=zeros(length(S),1)-eps;
eps3=ones(length(P),1)+eps;
eps4=ones(length(P),1)-eps;



plot(S,DS,c); hold on;
plot(P,DP,c); 
plot(comp,Dint,c);
plot(S,eps1,'r');
plot(S,eps2,'r');
plot(P,eps3,'r');
plot(P,eps4,'r');
xlabel('Theta');
ylabel('D(Theta)'); hold on;
%saveas(gcf, 'D-ModLin-Robust01' ,'png');
end

