
N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
[S,P,diP,diS] = computeDiagram(50,40,r);
x=load('antennarobust1Tau01LAST.csv');
diP=load('diP.csv');
length(diP);
diP=(reshape(diP,51,40))';
diS=load('diS.csv');
diS=(reshape(diS,51,40))';

eps=0.067;
for i=1:51
    DP(i) = x'*diP(:,i);
    DS(i) = x'*diS(:,i);
end
eps1=zeros(length(S),1)+eps;
eps2=zeros(length(S),1)-eps;
eps3=ones(length(P),1)+eps;
eps4=ones(length(P),1)-eps;



plot(S,DS,'b'); hold on;
plot(P,DP,'b'); 
plot(S,eps1,'r');
plot(S,eps2,'r');
plot(P,eps3,'r');
plot(P,eps4,'r');
xlabel('Theta');
ylabel('D(Theta)');
title(sprintf('Diagramme Total pour epsilon=%f \n', eps)); hold on;

for i=1:100
tau=0.001;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
for i=1:51
    DP(i) = x'*diP(:,i);
    DS(i) = x'*diS(:,i);
end

plot(S,DS,'g'); hold on;
plot(P,DP,'g');  

end


