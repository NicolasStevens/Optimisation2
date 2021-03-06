%generate plot Q1

N=40;
m = 200;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
%[S,P,diP,diS] = computeDiagram(50,40,r);
theta = linspace(0,pi/2,m);
di = computedi(theta,r);

x=load('../res/antennalin4050.csv');
x2=load('../res/antennalin4248.csv');
eps1=0.02353672414;
eps2=0.07138589138;
plotD(x,r,di,40,50,eps1,'b');
plotD(x2,r,di,42,48,eps2,'g');
%saveas(gcf, 'D-ModLin' ,'png');
