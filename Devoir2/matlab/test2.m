N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end

x=load('antennalin4050.csv');
x=x(:,2);

tau=0.001;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
[S,P,diP,diS] = computeDiagram(50,40,r);
eps=0.02024713577;
%eps=0.09368302883;
plotD(x,r,S,P,eps,'b'); hold on;

tau=0.01;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
[S,P,diP,diS] = computeDiagram(50,40,r);
eps=0.02024713577;
%eps=0.09368302883;
plotD(x,r,S,P,eps,'g'); 
saveas(gcf, 'D-ModLin-Robust' ,'png');