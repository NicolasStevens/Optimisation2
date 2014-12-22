function [x,y] = NewtonSteps(xold,yold,A,c,k,mu,tau)

delta = tau;
x = xold;
y = yold;
nx = length(x);
ny = length(y);
while delta>= tau
% tol = 0.01;
% NewtonStep = 1;
% while norm(NewtonStep,2)>tol
    [VM,H] = derivative_VM3(x,k);
    F = zeros(nx+ny,1);
%     F(1:nx) = A'*y+(c+mu*VM);
F(1:nx) = -(c./mu +VM);
    JF = [-H, A';
          A zeros(ny)];
    JF = sparse(JF);
%     NewtonStep = -(JF\F);
    NewtonStep = JF\F;  
    NewtonStep(isnan(NewtonStep))=0;
    
    alpha = 1;
    newtonx = NewtonStep(1:nx);
    delta = (newtonx'*-H*newtonx)^(1/2);
    if delta>=1
        alpha = 1/(1+delta);
    end
    xold = x;
    yold = y;
    NewtonStep = alpha*NewtonStep;
    v = [xold;yold] + NewtonStep;
    x = v(1:nx);
    y = v(nx+1:end);
    fprintf('Newton step, norm(step) = %s   delta = %s, obj = %s \n',norm(NewtonStep,2),delta,c'*x);
end

    function bool = isInDomain()
                nn = length(x)/3;
        sxx = zeros(nn,1);sxy=sxx;syy=sxx;

    for i=1:nn
        sxx(i)=x(1+3*(i-1));
        sxy(i)=x(2+3*(i-1));
        syy(i)=x(3+3*(i-1));
    end
        bool = all(((4*k^2*ones(size(sxx))-(sxx-syy).^2-(2*sxy).^2)>0));
    end

end