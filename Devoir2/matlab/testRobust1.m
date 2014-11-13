N=40;
m=101;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
%[S,P,diP,diS] = computeDiagram(50,40,r);
x=load('antennarobust1Tau001NEW.csv');
x2=load('antennarobust1Tau01NEW.csv');
diP=load('diP.csv');
diP=(reshape(diP,m,40))';
diS=load('diS.csv');
diS=(reshape(diS,m,40))';
S=load('S.csv');
P=load('P.csv');
N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
eps1=0.05069362304;
eps2=0.06800212653;
figure()
plotD(x,r,S,P,eps1,'b'); hold on;
plotD(x2,r,S,P,eps2,'g');
title('x non-perturbed');
%saveas(gcf, 'D-ModRobust1-001' ,'png');
errN001 = ComputeErrorDia(x,r,50,40,eps1)
errN01 = ComputeErrorDia(x2,r,50,40,eps2)

err11=zeros(100,1);
err12=zeros(100,1);

err21=zeros(100,1);
err22=zeros(100,1);

figure()
for i=1:10
tau=0.001;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
x2=x2.*(1+xsi);
%plotD(x,r,S,P,eps1,'b'); 
%plotD(x2,r,S,P,eps2,'g'); 
plotD2(diP,diS,P,S,50,40,x,r,eps1,'b'); hold on;
plotD2(diP,diS,P,S,50,40,x2,r,eps2,'g'); hold on;
err11(i) = ComputeErrorDia(x,r,50,40,eps1);
err21(i) = ComputeErrorDia(x2,r,50,40,eps2);
end
title('x perturbed with tau=0.001');
%saveas(gcf, 'D-ModRobust1-test3Rob001' ,'png');


figure()
for i=1:10
tau=0.01;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
x2=x2.*(1+xsi);
plotD2(diP,diS,P,S,50,40,x,r,eps1,'b'); hold on;
plotD2(diP,diS,P,S,50,40,x2,r,eps2,'g'); hold on;
%plotD(x,r,S,P,eps1,'b'); 
%plotD(x2,r,S,P,eps2,'g'); 
err12(i) = ComputeErrorDia(x,r,50,40,eps1);
err22(i) = ComputeErrorDia(x2,r,50,40,eps2);
end
title('x perturbed with tau=0.01');
%saveas(gcf, 'D-ModRobust1-test3Rob01' ,'png');
err1001 = sum(err11)/100
err101 = sum(err12)/100
err2001 = sum(err21)/100
err201 = sum(err22)/100

