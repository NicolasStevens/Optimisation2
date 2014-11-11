N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
[S,P,diP,diS] = computeDiagram(50,40,r);

x=load('antennarobust1Tau001.csv');

eps1=0.0282545;
figure()
plotD(x,r,S,P,eps1,'b');
saveas(gcf, 'D-ModRobust1-001' ,'png');

figure()
tau=0.001;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
[S,P,diP,diS] = computeDiagram(50,40,r);
plotD(x,r,S,P,eps1,'b'); hold on;

tau=0.01;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
plotD(x,r,S,P,eps1,'g'); 
saveas(gcf, 'D-ModRobust1-testRob001' ,'png');