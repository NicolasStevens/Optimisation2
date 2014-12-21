function [x_k] = interior_point(A,b,c,x_0,y_0,sigma,epsilon,mu_0,tau,k)
%interior_point solves a linear optimization problem using the interior point method with Von-Mises constraints
% Here the problem is 
% max_x c^T x
% s.t. Ax = b
% + Von-Mises

%% Additional parameters
itMax = 50;
x_k = x_0;
% y_k = y_0;
nx = length(x_k);
ny = length(y_0);
nn = nx/3;
% alpha = 0.5;
mu_k = mu_0;

%% Long step iterations
i=0;    
% TODO : compute mu_f
while(i<itMax && mu_k>epsilon)
mu_k = sigma*mu_k;
fprintf('*Interior point method iteration %d \nBarrier multiplier value(mu_k) : %d \n',i,mu_k);
x_k = NewtonSteps(x_k,zeros(ny,1),A,c,k,mu_k,tau);
i=i+1;
if(i==itMax)
fprintf('Maximum amount of iterations reached\n');
end
end
end






