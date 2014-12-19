function [x_k] = interior_point(A,b,c,x_0,y_0,s_0,sigma,epsilon,mu_0,tau,k)
%interior_point solves a linear optimization problem using the interior point method with Von-Mises constraints
% Here the problem is 
% max_x c^T x
% s.t. Ax = b
% + Von-Mises

%% Additional parameters
itMax = 50;

% First check if delta(x_0,y_0,s_0)<tau 
% Otherwise apply Newton method until delta(x_k,y_k,s_k)<tau
x_k = x_0;
y_k = y_0;
s_k = s_0;
while(delta(x_k,s_k,mu_0,k)<tau)
[F,JF] = buildJacobian(x_k,y_k,s_k,A,k,1,mu_0);
NewtonStep = -JF\F;
v = [x_k;y_k;s_k]+NewtonStep;
x_k = v(1:nx);
y_k = v(nx+1:nx+ny);
s_k = v(nx+ny+1:2*nx+ny);
fprintf('Initial Newton steps : delta(x_k,s_k,mu_k)=%d < tau =%d \n',delta(x_k,s_k,mu_0,k),tau);
end
mu_k = mu_0;

%% Long step iterations
i=0;
while(i<itMax && mu_k>epsilon)
fprintf('mu_k value : %d \n',mu_k);
[F,JF] = buildJacobian(x_k,y_k,s_k,A,k,sigma,mu_k);
NewtonStep = -JF\F;
% TODO : choix optimal du alphak et tau!!!!!!
alphak = 0.5;
vold=[x_k;y_k;s_k];
v = vold + alphak*NewtonStep;
x_k = v(1:nx);
y_k = v(nx+1:nx+ny);
s_k = v(nx+ny+1:2*nx+ny);
% check if delta<nu
if(delta(x_k,s_k,sigma*mu_k)<tau)
mu_k = sigma*mu_k;
end
i=i+1
if(i==itMax)
printf('Maximum amount of iterations reached');
end
end

end

function delta = delta(x,s,mu,k)
nx = length(x);
nn = nx/3;

sxx = x(1:nn);
syy = x(nn+1:2*nn);
sxy = x(2*nn+1:3*nn);
C1 = 4*k^2*ones(nn,1)-(sxx-syy).^2-(2*sxy).^2;
C2 = sxx-syy;
inv_VM_xx = -C1./(2*C2);
inv_VM_yy = C1./(2*C2);
inv_VM_xy = -C1./(4*sxy);
inv_VM = [inv_VM_xx;inv_VM_xx;inv_VM_xx];
delta = norm(1/mu*s.*inv_VM-ones(size(s)),2);
end



function [F,JF] = buildJacobian(x,y,s,A,k,sigma,mu_k)
nx = length(x);
ny = length(y);
nn = nx/3;

sxx = x(1:nn);
syy = x(nn+1:2*nn);
sxy = x(2*nn+1:3*nn);
C1 = 4*k^2*ones(nn,1)-(sxx-syy).^2-(2*sxy).^2;
C2 = sxx-syy;
inv_VM_xx = -C1./(2*C2);
inv_VM_yy = C1./(2*C2);
inv_VM_xy = -C1./(4*sxy);
inv_VM = diag([inv_VM_xx;inv_VM_xx;inv_VM_xx]);
F = zeros(2*nx+ny,1);
F(nx+ny+1:2*nx+ny) = diag(s)*inv_VM*ones(nx,1)-sigma*mu_k*ones(nx,1);

JF = zeros(2*nx+ny,2*nx+ny);

g1 = diag(1+2*C1./(4*C2));
%g2 = -g1;
g3 = diag((-16*sxy-4*C1)./(16*sxy));
g4 = diag(-2*C2./(4*sxy));
g5 = diag(-8*sxy./(2*C2));

grad_inv_VM = [g1 g1 g5;-g1 -g1 -g5;g4 -g4 g5];

% First line
JF(1:ny,1:nx) = A;
% Second line
JF(ny+1:ny+nx,nx+1:nx+ny) = A';
JF(ny+1:ny+nx,nx+ny+1:2*nx+ny) = eye(nx);
%Third line
size(JF(ny+nx+1:ny+2*nx,nx+ny+1:2*nx+ny))
size(inv_VM)
JF(ny+nx+1:ny+2*nx,1:nx) = diag(s)*grad_inv_VM;
JF(ny+nx+1:ny+2*nx,nx+ny+1:2*nx+ny) = inv_VM;
end




