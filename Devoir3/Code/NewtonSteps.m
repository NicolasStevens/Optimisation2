function x = NewtonSteps(xold,yold,A,c,k,mu,tau)

delta = tau;
x = xold;
y = yold;
nx = length(x);
ny = length(y);
while delta>= tau
    [F,JF] = buildJacobian(x,A,c,k,mu);
    [~,H] = derivative_VM(x,k);
    NewtonStep = F\JF;
    % alphak = alpha;
    alpha = 1;
    newtonx = NewtonStep(1:nx);
    delta = (newtonx*H*newtonx')^(1/2);
    if delta>=1
        alpha = 1/(1+delta);
    end
    xold = x;
    yold = y;
    NewtonStep = alpha*NewtonStep;
    v = [xold;yold] + NewtonStep';
    x = v(1:nx);
    y = v(nx+1:end);
    fprintf('Newton step, delta = %s\n',delta);
end
end