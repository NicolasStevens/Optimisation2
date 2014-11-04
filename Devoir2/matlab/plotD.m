function [] = plotD(x,r)
%
%
%

N=length(x);
[S,P,diP,diS] = computeDiagram(45,45,r);
m=length(S);

for i=1:m
    DP(i) = x'*diP(:,i);
    DS(i) = x'*diS(:,i);
end

figure()
plot(S,DS); hold on;
plot(P,DP);
saveas(gcf, 'D-test' ,'png');
end

