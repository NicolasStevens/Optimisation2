function [A,b,c] = constraintForm(N)
%
% N
%


% n is the number of triangles
% k is the number of nodes on each border. 
% m is the number of nodes

L=2;
l=L/N;
h=l/2;

nBNode = N*N*4*3;
nbCons = 2*(2*floor(N/4)+2) + N*N*24+2*4*N*(N-1)+N*8;

A=zeros(nbCons,3*nBNode);
b=zeros(nbCons,1);
c=zeros(3*nBNode,1);

%objective
for i=N/4+1:3*N/4
    indp = (i-1)*12 + 9;
   c(indp+1+2*nBNode)=l/2;
   c(indp+3+2*nBNode)=l/2;
end



for i=1:N*N
    indl = (i-1)*8; %indice sur les lignes (2 contraintes par triangle et 4 triangles par carre)
    %============== divergence nulle =================
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
    
    %================ continuite ===================
    div = 8*N*N+(i-1)*16;
    indcontL = (i-1)*8;
    %===cote 23-45
    % Cont11 Node1
    A(div+1,indp1+2)=-1;
    A(div+1,indp1+2+nBNode)=1;
    A(div+1,indp2+2)=1;
    A(div+1,indp2+2+nBNode)=-1;
    % Cont12 Node1
    A(div+2,indp1+2+nBNode)=-1;
    A(div+2,indp1+2+2*nBNode)=1;
    A(div+2,indp2+2+nBNode)=1;
    A(div+2,indp2+2+2*nBNode)=-1;
    % Cont11 Node2
    A(div+3,indp1+3)=-1;
    A(div+3,indp1+3+nBNode)=1;
    A(div+3,indp2+1)=1;
    A(div+3,indp2+1+nBNode)=-1;
    % Cont12 Node2
    A(div+4,indp1+3+nBNode)=-1;
    A(div+4,indp1+3+2*nBNode)=1;
    A(div+4,indp2+1+nBNode)=1;
    A(div+4,indp2+1+2*nBNode)=-1;
    
    %===cote 46-78
    % Cont21 Node1
    A(div+5,indp2+1)=1;
    A(div+5,indp2+1+nBNode)=1;
    A(div+5,indp3+1)=-1;
    A(div+5,indp3+1+nBNode)=-1;
    % Cont22 Node1
    A(div+6,indp2+1+nBNode)=1;
    A(div+6,indp2+1+2*nBNode)=1;
    A(div+6,indp3+1+nBNode)=-1;
    A(div+6,indp3+1+2*nBNode)=-1;
    % Cont21 Node2
    A(div+7,indp2+3)=1;
    A(div+7,indp2+3+nBNode)=1;
    A(div+7,indp3+2)=-1;
    A(div+7,indp3+2+nBNode)=-1;
    % Cont22 Node2
    A(div+8,indp2+3+nBNode)=1;
    A(div+8,indp2+3+2*nBNode)=1;
    A(div+8,indp3+2+nBNode)=-1;
    A(div+8,indp3+2+2*nBNode)=-1;
    
    %===cote 79-1112
    % Cont31 Node1
    A(div+9,indp3+1)=-1;
    A(div+9,indp3+1+nBNode)=1;
    A(div+9,indp4+1)=1;
    A(div+9,indp4+1+nBNode)=-1;
    % Cont32 Node1
    A(div+10,indp3+1+nBNode)=-1;
    A(div+10,indp3+1+2*nBNode)=1;
    A(div+10,indp4+1+nBNode)=1;
    A(div+10,indp4+1+2*nBNode)=-1;
    % Cont31 Node2
    A(div+11,indp3+3)=-1;
    A(div+11,indp3+3+nBNode)=1;
    A(div+11,indp4+3)=1;
    A(div+11,indp4+3+nBNode)=-1;
    % Cont32 Node2
    A(div+12,indp3+3+nBNode)=-1;
    A(div+12,indp3+3+2*nBNode)=1;
    A(div+12,indp4+3+nBNode)=1;
    A(div+12,indp4+3+2*nBNode)=-1;
    
    %===cote 13-1011
    % Cont21 Node1
    A(div+13,indp1+1)=1;
    A(div+13,indp1+1+nBNode)=1;
    A(div+13,indp4+1)=-1;
    A(div+13,indp4+1+nBNode)=-1;
    % Cont22 Node1
    A(div+14,indp1+1+nBNode)=1;
    A(div+14,indp1+1+2*nBNode)=1;
    A(div+14,indp4+1+nBNode)=-1;
    A(div+14,indp4+1+2*nBNode)=-1;
    % Cont21 Node2
    A(div+15,indp1+3)=1;
    A(div+15,indp1+3+nBNode)=1;
    A(div+15,indp4+2)=-1;
    A(div+15,indp4+2+nBNode)=-1;
    % Cont22 Node2
    A(div+16,indp1+3+nBNode)=1;
    A(div+16,indp1+3+2*nBNode)=1;
    A(div+16,indp4+2+nBNode)=-1;
    A(div+16,indp4+2+2*nBNode)=-1;
end

%la on a deja N*N*8 + N*N*16 = N*N*24

%============== continuite frontier des carre ==================
% bord verticale
for i=1:N-1
    for j=1:N
        indl = N*N*24 + (N-1)*(i-1)*4 + (j-1)*4;
        indp1 = N*(i-1)*12+(j-1)*12 + 6;
        indp2 = N*(i-1)*12+(j-1)*12 + 12;
        %cont1
        A(indl+1,indp1+2) =1;
        A(indl+1,indp2+2) =-1;
        %cont2
        A(indl+2,indp1+2+nBNode) =1;
        A(indl+2,indp2+2+nBNode) =-1;
        %cont3
        A(indl+3,indp1+3) =1;
        A(indl+3,indp2+1) =-1;
        %cont4
        A(indl+4,indp1+3+nBNode) =1;
        A(indl+4,indp2+1+nBNode) =-1;
    end
end

% bord horizontal
for i=1:N
    for j=1:N-1
        indl = N*N*24+4*N*(N-1)+(N-1)*(i-1)*4 + (j-1)*4;
        indp1 = N*(i-1)*12 +(j-1)*12+3;
        indp2 = N*i*12 +(j-1)*12+9;
        %cont1
        A(indl+1,indp1+2+nBNode) =1;
        A(indl+1,indp2+1+nBNode) =-1;
        %cont2
        A(indl+2,indp1+2+2*nBNode) =1;
        A(indl+2,indp2+1+2*nBNode) =-1;
        %cont3
        A(indl+3,indp1+3+nBNode) =1;
        A(indl+3,indp2+3+nBNode) =-1;
        %cont4
        A(indl+4,indp1+3+2*nBNode) =1;
        A(indl+4,indp2+3+2*nBNode) =-1;
    end
end


%================= conditions frontiere laterale ================
for i=1:N
    indl=N*N*24+2*4*N*(N-1)+(i-1)*8;
    indp1 = (i-1)*N*12;
    indp2 = i*N*12-3;
    
    %frontiere gauche
    A(indl+1,indp1+1) = 1;
    A(indl+2,indp1+2) = 1;
    A(indl+3,indp1+1+nBNode) = 1;
    A(indl+4,indp1+2+nBNode) = 1;
    
    %frontiere droite
    A(indl+5,indp2+2) = 1;
    A(indl+6,indp2+3) = 1;
    A(indl+7,indp2+2+nBNode) = 1;
    A(indl+8,indp2+3+nBNode) = 1;
end

%================= conditions frontiere superieur ================
floor(N/4)*2+2;
nbCarre = ceil(0.5*(floor(N/4)+ceil(N/4)));
for i=1:(nbCarre)
    indl = N*N*24+2*4*N*(N-1)+N*8 + (i-1)*8;
    indp1 = (i-1)*12 + 9; %carre du bout
    indp2 = (N-1)*12 - (i-1)*12 + 9; %premier carre
    
    A(indl+1,indp1+1+nBNode)=1;
    A(indl+2,indp1+1+2*nBNode)=1;
    A(indl+3,indp2+3+nBNode)=1;
    A(indl+4,indp2+3+2*nBNode)=1;
    
    if (i < nbCarre || floor(N/4)==N/4)
        A(indl+5,indp1+3+nBNode)=1;
        A(indl+6,indp1+3+2*nBNode)=1;
        A(indl+7,indp2+1+nBNode)=1;
        A(indl+8,indp2+1+2*nBNode)=1;
    end
end



%pivot

Anew=zeros(nbCons,3*nBNode);
cnew=zeros(3*nBNode,1);

for i=1:nBNode
   Anew(:,3*(i-1)+1) = A(:,i); 
   Anew(:,3*(i-1)+2) = A(:,i+nBNode); 
   Anew(:,3*(i-1)+3) = A(:,i+2*nBNode);
   cnew(3*(i-1)+1) = c(i);
   cnew(3*(i-1)+2) = c(i+nBNode);
   cnew(3*(i-1)+3) = c(i+2*nBNode);
end
A=sparse(Anew);
c=cnew;

spy(Anew);

end

