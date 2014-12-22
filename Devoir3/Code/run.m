% clear all;
close all;
% warning('off')

%% Parameters
n = 4;                     % nbr triangles
nbrVariables = n^2*4*9;     % nbr variables
mu = 1;
sigma = 0.4;
epsilon = 10^(-5);
tau = 0.2;
k = 1;
load('Barreau4.mat');
%A=A(1:end-1,:)
%spy(A)
[A,b,c] = constraintForm(8);

nx = length(A(1,:));
ny = length(A(:,1));
x_0 = zeros(nx,1);
y_0 = zeros(ny,1);
b= zeros(ny,1);


x = interior_point(A,zeros(length(A(:,1)),1),c,x_0,y_0,sigma,epsilon,mu,tau,k);
obj = c'*x
