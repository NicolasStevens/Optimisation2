x=load('antennarobust1Tau001LAST.csv');
N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
[S,P,diP,diS] = computeDiagram(50,40,r);
eps=0.0422784;
figure()
plotD(x,r,S,P,eps,'b');
errN = ComputeErrorDia(x,r,50,40,eps)

figure()
for i=1:100
tau=0.001;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
plotD(x,r,S,P,eps,'b'); hold on; 
%err(i) = ComputeErrorDia(x,r,50,40,eps);
end
%saveas(gcf, 'D-ModRobust1-test3Rob' ,'png');


figure()
for i=1:100
tau=0.01;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
plotD(x,r,S,P,eps,'b'); 
%err2(i) = ComputeErrorDia(x,r,50,40,eps);
end
%saveas(gcf, 'D-ModRobust1-test3Rob' ,'png');
%sum(err)/100
%sum(err2)/100

