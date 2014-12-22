function [x_k] = interior_point(A,b,c,x_0,y_0,sigma,epsilon,mu_0,tau,k,nu,boost,linesearch)
%interior_point solves a linear optimization problem using the interior point method with Von-Mises constraints
% Here the problem is 
% max_x c^T x
% s.t. Ax = b
% + Von-Mises

% Additional parameter
itMax = 50;
mu_fin = epsilon/(sqrt(nu)+tau*epsilon);
% Starting point
x_k = x_0;
y_k = y_0;
mu_k = mu_0;

% Long step iterations
i=0;    

while(i<itMax && mu_k>mu_fin)
mu_k = sigma*mu_k;
fprintf('*Interior point method iteration %d \nBarrier multiplier value(mu_k) : %d \n****Obj : %d\n',i,mu_k,c'*x_k);
[x_k,y_k,steps] = NewtonSteps(x_k,y_k,A,c,k,mu_k,tau,linesearch);

if boost && steps> 1
        if steps < 6
            sigma = max(sigma-0.2,0.1);
        elseif steps > 10
            sigma = min(sigma+0.2,0.9);
        end
end

i=i+1;
if(i==itMax)
fprintf('Maximum amount of iterations reached\n');
end
end
end



