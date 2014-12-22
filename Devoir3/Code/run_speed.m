clear all;
close all;

%% Parameters
mu = 1;
epsilon = 10^(-3);
sigma = 0.4;
tau = 0.2;
k = 1;



nArray = 4:12;
time_basic = zeros(size(nArray));
time_boost = zeros(size(nArray));
time_linesearch = zeros(size(nArray));
time_both = zeros(size(nArray));
obj = time_basic;

for i=1:length(nArray)
    n = nArray(i);
    nbrVariables = n^2*4*9;     % nbr variables
    [A,b,c] = constraintForm(n);
    nu = nbrVariables;
    nx = length(A(1,:));
    ny = length(A(:,1));
    x_0 = zeros(nx,1);
    y_0 = zeros(ny,1);
    
    boost = 0;
    linesearch = 0;
    tic;
        x = interior_point(A,b,c,x_0,y_0,sigma,epsilon,mu,tau,k,nu,boost,linesearch);
    time_basic(i) = toc;
    obj(i) = c'*x;
    
    boost = 1;
    linesearch = 0;
    tic;
       interior_point(A,b,c,x_0,y_0,sigma,epsilon,mu,tau,k,nu,boost,linesearch);
    time_boost(i) = toc;
    
    boost = 0;
    linesearch = 1;
    tic;
        interior_point(A,b,c,x_0,y_0,sigma,epsilon,mu,tau,k,nu,boost,linesearch);
    time_linesearch(i) = toc;
    
    boost = 1;
    linesearch = 1;
    tic;
        interior_point(A,b,c,x_0,y_0,sigma,epsilon,mu,tau,k,nu,boost,linesearch);
    time_both(i) = toc;
    
end
figure();
plot(nArray,time_basic);hold on;
plot(nArray,time_boost);hold on;
plot(nArray,time_linesearch);hold on;
plot(nArray,time_both);hold on;
xlabel('n');
ylabel('elapsed time(s)');
title('Performance tests');
legend('basic','boost','linesearch','both');
