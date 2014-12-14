function [A,b,c] = constraintForm(Node,Triangle,n,m,k)
%
% m is the number of nodes
% n is the number of triangles
% k is the number of nodes on each border. 
% Node contains the (x,y) coordinate of the nodes. The nodes are sorted
% such as the 4*k-4 first are the border ones, clockwise, begining at the
% top.
% Triangle is an array containing the triangles 
%
%

% 3m (and not 3*3*n!!, as we impose continuity) variable such that 
% x=[sxx sxy syy]';

A=zeros(??,3*m);

% divergence nulle :
for i=1:n
    % eq 1
   nodem=Triangle(i,1);
   noden=Triangle(i,2);
   nodep=Triangle(i,3);
   A(i,noden)=1/(Node(noden,1)-Node(nodem,1));
   A(i,nodem)=-1/(Node(noden,1)-Node(nodem,1));
   A(i,nodep)=1/(Node(nodep,1)-Node(nodem,1));
   A(i,nodem)=-1/(Node(nodep,1)-Node(nodem,1));
   A(i,m+noden)=1/(Node(noden,2)-Node(nodem,2));
   A(i,m+nodem)=-1/(Node(noden,2)-Node(nodem,2));
   A(i,m+nodep)=1/(Node(nodep,2)-Node(nodem,2));
   A(i,m+nodem)=-1/(Node(nodep,2)-Node(nodem,2));
   
   % eq 2
   A(n+i,m+noden)=1/(Node(noden,1)-Node(nodem,1));
   A(n+i,m+nodem)=-1/(Node(noden,1)-Node(nodem,1));
   A(n+i,m+nodep)=1/(Node(nodep,1)-Node(nodem,1));
   A(n+i,m+nodem)=-1/(Node(nodep,1)-Node(nodem,1));
   A(n+i,2*m+noden)=1/(Node(noden,2)-Node(nodem,2));
   A(n+i,2*m+nodem)=-1/(Node(noden,2)-Node(nodem,2));
   A(n+i,2*m+nodep)=1/(Node(nodep,2)-Node(nodem,2));
   A(n+i,2*m+nodem)=-1/(Node(nodep,2)-Node(nodem,2));
end

% boundary conditions






end

