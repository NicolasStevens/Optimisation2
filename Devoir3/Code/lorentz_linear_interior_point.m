function [x] = lorentz_linear_interior_point(c1,c2,A1,A2,b,tau,epsilon,sigma,nu)
%lorentz_linear_interior_point solves a conic optimization problem using the interior point method. The only cones allowed are the Lorentz cones.
% The problem is :
%			min_x1,x2 c1'*x1+c2'*x2
% s.t. A1x1+A2x2 = b
% s.t. x1 >= 0
% s.t. x2 \in Lorentz_n2

%% Check input !!

%% Initial newton so that delta(nx)<nu

%% Additional parameters
itMax = 50;
%Initial conditions !!!!
% x1_0,x2_0,y_0,s1_0,s2_0, t_0,mu_0
while(k<itMax && muk)
JF = buildJacobian(x1,x2,t,A1,A2);
F = buildFunction();
NewtonStep = JF\F;
% alphak !!!!!!
alphak = 1;
x = xold + alphak*NewtonStep;
% check if delta<nu
muk = sigma*muk;
end

end

function J = buildJacobian(x1,x2,s1,s2,t,A1,A2)
n1 = length(A1(:,1));
n2 = length(A1(1,:));
n3 = length(A2(1,:));
J = zeros(n1+2*n2+3*n3);
% First line
J(1:n1,1:n2) = A1;
J(1:n1,n2+1:n2+n3) = A2;
%Second line
J(n1+1:n1+n2,n2+n3+1:n1+n2+n3) = A1';
J(n1+1:n1+n2,n1+n2+n3+1:n1+2*n2+n3) = eye(n2,n1)';
%Third line
J(n1+n2+1:n1+n2+n3,n2+n3+1:n1+n2+n3) = A2';
J(n1+n2+1:n1+n2+n3,n1+2*n2+n3+1:n1+2*n2+2*n3) = eye(n3,n1)';
%Fourth line
J(n1+n2+n3+1:n1+2*n2+n3,1:n2) = diag(s1);
J(n1+n2+n3+1:n1+2*n2+n3,n1+n2+n3+1:n1+2*n2+n3) = diag(x1);
%Fifth line
J(n1+2*n2+n3+1:n1+2*n2+2*n3,n1+2*n2+n3+1:n1+2*n2+2*n3) = diag(t);
J(n1+2*n2+n3+1:n1+2*n2+2*n3,n1+2*n2+2*n3+1:n1+2*n2+3*n3) = diag(s2);
%Sixth line
J(n1+2*n2+2*n3,n1+2*n2+3*n3, n2+1:n2+n3) = 2*diag(t)+2*ones(n3,1)*x2';
J(n1+2*n2+2*n3+1:n1+2*n2+3*n3,n1+2*n2+2*n3+1:n1+2*n2+3*n3) = 2*diag(x2);
end

function F = buildFunction(muk,x1,s1,s2,t,tau)
F = zeros(n1+2*n2+3*n3,1);
%Line 1-2-3 = 0
%Line 4
F(n1+n2+n3+1:n1+2*n2+n3) = (-x1'*s1+muk)*ones(n1+n2+n3+1:n1+2*n2+n3,1);
%Line 5
F(n1+2*n2+n3+1:n1+2*n2+2*n3) = (-t'*s2+muk)*ones(n1+2*n2+n3+1:n1+2*n2+2*n3,1);
%Line 6
F(n1+2*n2+2*n3,n1+2*n2+3*n3,n1+2*n2+2*n3,n1+2*n2+3*n3) = (-2*x2'*t+tau^2-x2'*x2)*ones(n1+2*n2+2*n3,n1+2*n2+3*n3,1);
end
