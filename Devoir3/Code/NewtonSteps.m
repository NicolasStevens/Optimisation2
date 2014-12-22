function [x,y] = NewtonSteps(xold,yold,A,c,k,mu,tau)
delta = tau;
x = xold;
y = yold;
nx = length(x);
ny = length(y);
fprintf('Newton steps  ::  norm(step)  |    delta   |  alpha    |   objective  \n');
while delta>= tau
    [VM,H] = derivative_VM3(x,k);
    F = zeros(nx+ny,1);
    F(1:nx) = -(c./mu -VM + A'*y);
    JF = [-H, A';
          A zeros(ny)];
    JF = sparse(JF);
    NewtonStep = JF\F;  
    newtonx = NewtonStep(1:nx);
    delta = (newtonx'*H*newtonx)^(1/2);
    alpha = 1;
    if delta>=1
        alpha = 1/(1+delta);
    end
%     alphamax = 1;
%     alphamin = 1/(1+delta);
%     xamin = xold + alphamin*newtonx;
%     xamax = xold + alphamax*newtonx;
%     j=0;
%     if not(isInDomain(xamax))
%         while j<10 && alpha<1
%             alpha = (alphamax+alphamin)/2;
%             xalpha = xold + alpha*newtonx;
%             if isInDomain(xalpha) && c'*xalpha>c'*xamin
%                 alphamin = alpha;
%                 xamin = xalpha;
%             else
%                 alphamax = alpha;
%             end
%             j = j+1;
%         end
%         alpha = alphamin;
%     else
%         alpha = alphamax;
%     end
    xold = x;
    yold = y;
    NewtonStep = alpha*NewtonStep;
    v = [xold;yold] + NewtonStep;
    x = v(1:nx);
    y = v(nx+1:end);
%     fprintf('NEWTON : %7s%14.3f|%12.3f|%13.3f|%13.3f\n',0,norm(NewtonStep,2),delta,alpha,c'*x);

end
function bool = isInDomain(x)
        nx = length(x);
        nn = nx/3;
        
        sxx = zeros(nn,1);sxy=sxx;syy=sxx;
        for i=1:nn
            sxx(i)=x(1+3*(i-1));
            sxy(i)=x(2+3*(i-1));
            syy(i)=x(3+3*(i-1));
        end
        bool = all((4*k^2-(sxx-syy).^2-(2*sxy).^2>0));
    end
end