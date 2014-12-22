% clear all;
close all;
% warning('off')

% Parameters
n = 16;                     % nbr carre
nbrVariables = n^2*4*9;   % nbr variables
mu = 1;
epsilon = 10^(-4);
nu = nbrVariables/3;
sigma = 0.1;
tau = 0.25;
k = 2;

boost = 0;
linesearch = 0;

nu*log(1/epsilon)

[A,b,c] = constraintForm(n);
%load('Barreau4.mat');
%b = zeros(length(A(:,1)),1);


nx = length(A(1,:));
ny = length(A(:,1));
x_0 = zeros(nx,1);
y_0 = zeros(ny,1);

warning('off','all');
tic;
x = interior_point(A,b,c,x_0,y_0,sigma,epsilon,mu,tau,k,nu,boost,linesearch);
totaltime = toc;
fprintf('Total elapsed time : %f s',totaltime);
obj = c'*x
%plotChamps(x,n)

