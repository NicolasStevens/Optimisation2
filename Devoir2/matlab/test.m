N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end
[S,P,diP,diS] = computeDiagram(50,40,r);

%csvwrite('dataS.csv',S);
%csvwrite('dataP.csv',P);
%csvwrite('datadiS.csv',diS);
%csvwrite('datadiP.csv',diP);

x=load('antennalin4050.csv');
[err] = ComputeErrorDia(x,r,50,40,eps)
x2=load('antennalin4050-Rapproche.csv');
[err] = ComputeErrorDia(x2,r,47,43,eps)
eps1=0.0235439;
eps2=0.119491;
plotD(x,r,S,P,eps1,'b');
plotD(x2,r,S,P,eps2,'g');
%saveas(gcf, 'D-ModLin' ,'png');