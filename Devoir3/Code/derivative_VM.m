function [GF,H] = derivative_VM(x,k)
nx = length(x);
nn = nx/3;
% % Version QN
% sxx = x(1:nn);
% syy = x(nn+1:2*nn);
% sxy = x(2*nn+1:3*nn);
%Version Glineur
sxx = zeros(nn,1);sxy=sxx;syy=sxx;
for i=1:nn
    sxx(i)=x(1+3*(i-1));
    syy(i)=x(2+3*(i-1));
    sxy(i)=x(3+3*(i-1));
end
C1 = 4*k^2*ones(nn,1)-(sxx-syy).^2-(2*sxy).^2;
C2 = sxx-syy;
VM_xx = 2*C2./C1;
VM_yy = -VM_xx;
VM_xy = -8*sxy./C1;
GF = [VM_xx;VM_yy;VM_xy];
% %% Version non-Glineur : chaque noeud a un a la fois ses sxx syy sxy?
% GF = zeros(length(x),1);
% for i=1:nn
% GF(1+3*(i-1)) = VM_xx(i);
% GF(2+3*(i-1))=VM_yy(i);
% GF(3+3*(i-1)) = VM_xy(i);
% end
% % Fin version non-Glineur

h1 = diag((2*C1+4*C2.^2)./C1.^2);
h2 = diag(-16*sxy.*C2./C1.^2);
h3 = diag((-8*C1-64*sxy.^2)./C1.^2);
H = [h1 -h1 h2;
           -h1 h1 -h2;
           h2 -h2 h3];
% %non-Glineur
% H = zeros(nx,nx);
% for i=1:nn
% H(1+3*(i-1):3*i,1+3*(i-1):3*i) = [h1(i,i) -h1(i,i) h2(i,i);
%                                 -h1(i,i) h1(i,i) -h2(i,i);
%                                 h2(i,i) -h2(i,i) h3(i,i)];
end