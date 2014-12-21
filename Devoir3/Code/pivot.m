function [Anew,cnew] = pivot(A,c,N)
%
% Pivot pour exprimer A et c comme Glineur
%

nbNoeud=N*N*4*3;
nbCons = 2*(2*floor(N/4)+2) + N*N*24+2*4*N*(N-1)+N*8;

Anew=zeros(nbCons,3*nBNode);
cnew=zeros(3*nBNode,1);

for i=1:nbNoeud
   Anew(:,3*(i-1)+1) = A(:,i); 
   Anew(:,3*(i-1)+2) = A(:,i+nbNoeud); 
   Anew(:,3*(i-1)+3) = A(:,i+2*nbNoeud);
   cnew(3*(i-1)+1) = c(i);
   cnew(3*(i-1)+2) = c(i+nbNoeud);
   cnew(3*(i-1)+3) = c(i+2*nbNoeud);
end
end

