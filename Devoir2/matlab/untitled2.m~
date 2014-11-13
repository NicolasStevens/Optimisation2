
N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
[S,P,diP,diS] = computeDiagram(50,40,r);

x=load('antennarobust1TESTTEST.csv');

N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
eps1=0.0241
figure()
plotD(x,r,S,P,eps1,'b');