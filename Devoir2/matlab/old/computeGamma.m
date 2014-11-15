clear all
N = 40;
Cn = pi^(N/2)/gamma(N/2+1);
finalProbability = 0.9;
tau = 0.01;
nFaces = N*(N-1)*2^(N-3)

funhandle = @(x) (2*tau)^N*finalProbability- Cn*x^N*(1-1/2*nFaces*betainc((x^2-tau^2)/(x^2),(N+1)/2,1/2));
funhandle(tau)
funhandle(sqrt(3*tau^2))
res = fzero(funhandle,[tau sqrt(N*tau^2)])

max = sqrt(N*tau^2)
%gamma = sqrt((tau^2)/(1-res))
