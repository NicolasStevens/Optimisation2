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

x=load('antennalin4050.csv');
x=x(:,2);
[err] = ComputeErrorDia(x,r,50,40,eps)
x2=load('antennalin4050-Rapproche.csv');
x2=x2(:,2);
[err] = ComputeErrorDia(x2,r,47,43,eps)
eps1=0.02024713577;
eps2=0.09368302883;
plotD(x,r,S,P,eps1,'b');
plotD(x2,r,S,P,eps2,'g');
%saveas(gcf, 'D-ModLin' ,'png');