load('Barreau4.mat');
nx = length(A(1,:));
ny = length(A(:,1));
b= zeros(ny,1);
sigma = 0.8;
epsilon = 0.001;
mu_0 = 100;
tau = 0.5;
x_0 = zeros(nx,1);
y_0 = zeros(ny,1);
s_0 = c;
% TODO : find realistic k value
k = 1;
[x_k] = interior_point(A,b,c,x_0,y_0,s_0,sigma,epsilon,mu_0,tau,k);
