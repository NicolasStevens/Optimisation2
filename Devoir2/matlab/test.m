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
x=x(:,2);
plotD(x,r);