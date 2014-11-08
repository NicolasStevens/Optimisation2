N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
[S,P,diP,diS] = computeDiagram(50,40,r);
diP;
diS;
diS(6,50);
%csvwrite('dataS.csv',S);
%csvwrite('dataP.csv',P);
%csvwrite('datadiS.csv',diS);
%csvwrite('datadiP.csv',diP);

x=load('antennalin4050-Rapproche.csv');
x=x(:,2)

%eps=0.02024713577;
eps=0.09368302883;
plotD(x,r,S,P,eps);