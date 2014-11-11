N=40;
r=ones(N,1);
for i=1:N
   r(i)=i/10; 
end

x=load('antennalin4050.csv');
x=x(:,2);

nbXsi=5;
err=zeros(nbXsi,1);
err2=zeros(nbXsi,1);
for i=1:nbXsi
tau=0.001;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
[S,P,diP,diS] = computeDiagram(50,40,r);
eps=0.02024713577;
%eps=0.09368302883;
plotD(x,r,S,P,eps,'g'); hold on;
err(i) = ComputeErrorDia(x,r,50,40,eps);
end
%saveas(gcf, 'D-ModLin-2RobustTau001' ,'png');


figure()
for i=1:nbXsi 
tau=0.01;
xsi=Genxsi(tau,N);
x=x.*(1+xsi);
[S,P,diP,diS] = computeDiagram(50,40,r);
eps=0.02024713577;
%eps=0.09368302883;
plotD(x,r,S,P,eps,'b'); 
err2(i) = ComputeErrorDia(x,r,50,40,eps);
end
%saveas(gcf, 'D-ModLin-2RobustTau01' ,'png');
sum(err)/nbXsi
sum(err2)/nbXsi