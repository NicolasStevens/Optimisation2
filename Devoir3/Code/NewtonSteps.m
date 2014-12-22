function [x,y] = NewtonSteps(xold,yold,A,c,k,mu,tau)
delta = tau;
x = xold;
y = yold;
nx = length(x);
ny = length(y);
while delta>= tau
    [VM,H] = derivative_VM3(x,k);
    F = zeros(nx+ny,1);
    F(1:nx) = -(c./mu -VM + A'*y);
    JF = [-H, A';
          A zeros(ny)];
    JF = sparse(JF);
    NewtonStep = JF\F;  
    alpha = 1;
    newtonx = NewtonStep(1:nx);
    delta = (newtonx'*H*newtonx)^(1/2);
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

end