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

err = trapz(P,abs(DP-1)) + trapz(S,abs(DS));


end

