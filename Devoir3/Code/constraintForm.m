function [A,b,c] = constraintForm(N)
%
% N
%


% n is the number of triangles
% k is the number of nodes on each border. 
% m is the number of nodes
n = N*N*4;
k = N+1;

nBNode = N*N*4*3;


A=zeros(??,nbNode);
b=zeros(??,1);
c=zeros(3*m,1);

%objective

% divergence nulle :
for i=1:N*N
    indl = (i-1)*8; %indice sur les lignes (2 contraintes par triangle et 4 triangles par carre)
    
    %triangle type 1
    indp1 = (i-1)*12;%indice sur les points(12 points par triangles)
    
    A(indl+1,indp1+1)=-1/(2*h);
    A(indl+1,indp1+2)=-1/(2*h);
    A(indl+1,indp1+3)=1/h;
    A(indl+1,indp1+1+nBNode)=1/l;
    A(indl+1,indp1+2+nBNode)=-1/l;
    
    A(indl+2,indp1+1+nBNode)=-1/(2*h);
    A(indl+2,indp1+2+nBNode)=-1/(2*h);
    A(indl+2,indp1+3+nBNode)=1/h;
    A(indl+2,indp1+1+2*nBNode)=1/l;
    A(indl+2,indp1+1+2*nBNode)=1/l;
    
    %triangle type 2
    indp2 = (i-1)*12 + 3;%indice sur les points(12 points par triangles)
    
    A(indl+3,indp2+2)=-1/l;
    A(indl+3,indp2+3)=1/l;
    A(indl+3,indp2+1+nBNode)=1/h;
    A(indl+3,indp2+2+nBNode)=-1/(2*h);
    A(indl+3,indp2+3+nBNode)=-1/(2*h);
    
    A(indl+4,indp2+2+nBNode)=-1/l;
    A(indl+4,indp2+3+nBNode)=1/l;
    A(indl+4,indp2+1+2*nBNode)=1/h;
    A(indl+4,indp2+2+2*nBNode)=-1/(2*h);
    A(indl+4,indp2+3+2*nBNode)=-1/(2*h);
    
    %triangle type 3
    indp3 = (i-1)*12 + 6;%indice sur les points(12 points par triangles)
    
    A(indl+5,indp3+1)=-1/h;
    A(indl+5,indp3+2)=1/(2*h);
    A(indl+5,indp3+3)=1/(2*h);
    A(indl+5,indp3+2+nBNode)=-1/l;
    A(indl+5,indp3+3+nBNode)=1/l;
    
    A(indl+6,indp3+1+nBNode)=-1/h;
    A(indl+6,indp3+2+nBNode)=1/(2*h);
    A(indl+6,indp3+3+nBNode)=1/(2*h);
    A(indl+6,indp3+2+2*nBNode)=-1/l;
    A(indl+6,indp3+3+2*nBNode)=1/l;
    
    %triangle type 4
    indp4 = (i-1)*12 + 3;%indice sur les points(12 points par triangles)
    
    A(indl+7,indp4+1)=-1/l;
    A(indl+7,indp4+3)=1/l;
    A(indl+7,indp4+1+nBNode)=1/(2*h);
    A(indl+7,indp4+2+nBNode)=-1/h;
    A(indl+7,indp4+3+nBNode)=1/(2*h);
    
    A(indl+8,indp4+1+nBNode)=-1/l;
    A(indl+8,indp4+3+nBNode)=1/l;
    A(indl+8,indp4+1+2*nBNode)=1/(2*h);
    A(indl+8,indp4+2+2*nBNode)=-1/h;
    A(indl+8,indp4+3+2*nBNode)=1/(2*h);
    
    %continuite
    div = 8*N*N;
    indcontL = (i-1)*8;
    A(indl+8,indp4+3+2*nBNode)=1/(2*h);
    
    
end







% boundary conditions
A(2*n+1:2*n+k,1:k)         = eye(k);  
A(2*n+k+1:2*n+2*k,m+1:m+k) = eye(k);





end

