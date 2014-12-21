function [F,JF] = buildJacobian(x,A,c,k,mu)
nx = length(x);
ny = length(A(:,1));
nn = nx/3;

[VM,H] = derivative_VM(x,k);
F = zeros(nx+ny,1); 
F(ny+1:nx+ny) = (-c)./(mu)-VM;
JF = [A, zeros(ny);
      H A'];
end

