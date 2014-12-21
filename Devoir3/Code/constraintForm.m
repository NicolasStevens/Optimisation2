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
nbCons = 2*(2*floor(N/4)+2) + N*N*24+2*4*N*(N-1)+N*8;

A=zeros(nbCons,nbNode);
b=zeros(nbCons,1);
c=zeros(3*nBNode,1);

%objective
for i=N/4:3*N/4
    indp = (i-1)*12 + 9;
   c(indp+1)=L/2;
   c(indp+3)=L/2;
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
    div = 8*N*N;
    indcontL = (i-1)*8;
    %===cote 23-45
    % Cont11 Node1
    A(div+1,inp1+2)=-1;
    A(div+1,inp1+2+nBNode)=1;
    A(div+1,inp2+2)=1;
    A(div+1,inp2+2+nBNode)=-1;
    % Cont12 Node1
    A(div+2,inp1+2+nBNode)=-1;
    A(div+2,inp1+2+2*nBNode)=1;
    A(div+2,inp2+2+nBNode)=1;
    A(div+2,inp2+2+2*nBNode)=-1;
    % Cont11 Node2
    A(div+3,inp1+3)=-1;
    A(div+3,inp1+3+nBNode)=1;
    A(div+3,inp2+1)=1;
    A(div+3,inp2+1+nBNode)=-1;
    % Cont12 Node2
    A(div+4,inp1+3+nBNode)=-1;
    A(div+4,inp1+3+2*nBNode)=1;
    A(div+4,inp2+1+nBNode)=1;
    A(div+4,inp2+1+2*nBNode)=-1;
    
    %===cote 46-78
    % Cont21 Node1
    A(div+5,inp2+1)=1;
    A(div+5,inp2+1+nBNode)=1;
    A(div+5,inp3+1)=-1;
    A(div+5,inp3+1+nBNode)=-1;
    % Cont22 Node1
    A(div+6,inp2+1+nBNode)=1;
    A(div+6,inp2+1+2*nBNode)=1;
    A(div+6,inp3+1+nBNode)=-1;
    A(div+6,inp3+1+2*nBNode)=-1;
    % Cont21 Node2
    A(div+7,inp2+3)=1;
    A(div+7,inp2+3+nBNode)=1;
    A(div+7,inp3+2)=-1;
    A(div+7,inp3+2+nBNode)=-1;
    % Cont22 Node2
    A(div+8,inp2+3+nBNode)=1;
    A(div+8,inp2+3+2*nBNode)=1;
    A(div+8,inp3+2+nBNode)=-1;
    A(div+8,inp3+2+2*nBNode)=-1;
    
    %===cote 79-1112
    % Cont31 Node1
    A(div+9,inp3+1)=-1;
    A(div+9,inp3+1+nBNode)=1;
    A(div+9,inp4+1)=1;
    A(div+9,inp4+1+nBNode)=-1;
    % Cont32 Node1
    A(div+10,inp3+1+nBNode)=-1;
    A(div+10,inp3+1+2*nBNode)=1;
    A(div+10,inp4+1+nBNode)=1;
    A(div+10,inp4+1+2*nBNode)=-1;
    % Cont31 Node2
    A(div+11,inp3+3)=-1;
    A(div+11,inp3+3+nBNode)=1;
    A(div+11,inp4+3)=1;
    A(div+11,inp4+3+nBNode)=-1;
    % Cont32 Node2
    A(div+12,inp3+3+nBNode)=-1;
    A(div+12,inp3+3+2*nBNode)=1;
    A(div+12,inp4+3+nBNode)=1;
    A(div+12,inp4+3+2*nBNode)=-1;
    
    %===cote 13-1011
    % Cont21 Node1
    A(div+13,inp1+1)=1;
    A(div+13,inp1+1+nBNode)=1;
    A(div+13,inp4+1)=-1;
    A(div+13,inp4+1+nBNode)=-1;
    % Cont22 Node1
    A(div+14,inp1+1+nBNode)=1;
    A(div+14,inp1+1+2*nBNode)=1;
    A(div+14,inp4+1+nBNode)=-1;
    A(div+14,inp4+1+2*nBNode)=-1;
    % Cont21 Node2
    A(div+15,inp1+3)=1;
    A(div+15,inp1+3+nBNode)=1;
    A(div+15,inp4+2)=-1;
    A(div+15,inp4+2+nBNode)=-1;
    % Cont22 Node2
    A(div+16,inp1+3+nBNode)=1;
    A(div+16,inp1+3+2*nBNode)=1;
    A(div+16,inp4+2+nBNode)=-1;
    A(div+16,inp4+2+2*nBNode)=-1;
end

%la on a deja N*N*8 + N*N*16 = N*N*24

%============== continuite frontier des carre ==================
% bord verticale
for i=1:N-1
    for j=1:N
        indl = N*N*24+(N-1)*(i-1)*4 + (j-1)*4;
        indp1 = N*(i-1)+(j-1)*12+6;
        indp2 = N*(i-1)+(j-1)*12+12;
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
        indp1 = N*(i-1)+(j-1)*12+3;
        indp2 = N*i+(j-1)*12+9;
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
    A(indl+1,indp+1) = 1;
    A(indl+2,indp+2) = 1;
    A(indl+3,indp+1+nBNode) = 1;
    A(indl+4,indp+2+nBNode) = 1;
    
    %frontiere droite
    A(indl+5,indp+2) = 1;
    A(indl+6,indp+3) = 1;
    A(indl+7,indp+2+nBNode) = 1;
    A(indl+8,indp+3+nBNode) = 1;
end

%================= conditions frontiere superieur ================
floor(N/4)*2+2;
nbCarre = ceil(0.5*(floor(N/4)+ceil(N/4)));
for i=1:(nbP)
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
end

