N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
[S,P,diP,diS] = computeDiagram(50,40,r);

x=load('antennarobust1Tau01.csv');

x2=load('antennarobust1Tau001.csv');

eps1=0.028;
eps2=0.033
figure()
plotD(x,r,S,P,eps1,'b');
errN = ComputeErrorDia(x,r,50,40,eps)
%saveas(gcf, 'D-ModRobust1-001' ,'png');
%err=zeros(100,1);
%err2=zeros(100,1);

figure()
for i=1:100
tau=0.001;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
x2=x2.*(1+xsi);
plotD(x,r,S,P,eps2,'b'); hold on;
plotD(x2,r,S,P,eps1,'g'); 
%err(i) = ComputeErrorDia(x,r,50,40,eps);
end
saveas(gcf, 'D-ModRobust1-test3Rob' ,'png');


figure()
for i=1:100
tau=0.01;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
x2=x2.*(1+xsi);
plotD(x,r,S,P,eps2,'b'); 
plotD(x2,r,S,P,eps1,'g'); 
%err2(i) = ComputeErrorDia(x,r,50,40,eps);
end
saveas(gcf, 'D-ModRobust1-test3Rob' ,'png');
%sum(err)/100
%sum(err2)/100