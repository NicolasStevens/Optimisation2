function [gamma] = computeGammaCLT(probability,tau,N)
% [gamma] = computeGammaCLT(probability,tau,N)
% This function computes the value of gamma such that the sum
% of the squares of N variables uniformly distributed on [-tau,tau]
% has a probability 'probability' of being inferior to gamma^2
	if (nargin==0)
		N = 40;
		probability = 0.99;
		tau = 0.01;
	end
	mu = tau^2/3;
	sigma = tau^4*(1/5-1/9);
	gamma = sqrt(norminv(probability,N*mu,sqrt(N)*sigma));
end
