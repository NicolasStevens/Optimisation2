function [err] = ComputeErrorDia(x,r,thetaP,thetaS,eps)
%
%
%

[S,P,diP,diS] = computeDiagram(thetaP,thetaS,r);
m=length(S);
for i=1:m
    DP(i) = x'*diP(:,i);
    DS(i) = x'*diS(:,i);
end
%figure()
%plot(P(2:end),abs(DP(2:end)-1)); hold on;
%plot(S,abs(DS));
err = trapz(P(2:end),abs(DP(2:end)-1)) + trapz(S,abs(DS));


end

