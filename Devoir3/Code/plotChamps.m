function [] = plotChamps(x,N)
%
% Fonction qui plot les champs des contraintes contenues dans x.
%
L=1;
nBNode = N*N*4*3;
nBTriangle = N*N*4;
Tri=zeros(nBTriangle,3);
X=zeros(nBNode,1);
Y=zeros(nBNode,1);
Z1=zeros(nBNode,1);
Z2=zeros(nBNode,1);
Z3=zeros(nBNode,1);

for i=1:N
    for j=1:N
        indp=(i-1)*N*12 + (j-1)*12;
        indTr=(i-1)*N*4 + (j-1)*4;
        xref=(j-1)*L/N;
        yref=L-(i-1)*L/N;
        
        Tri(indTr+1,1)=indp+1;
        Tri(indTr+1,2)=indp+2;
        Tri(indTr+1,3)=indp+3;
        
        Tri(indTr+2,1)=indp+4;
        Tri(indTr+2,2)=indp+5;
        Tri(indTr+2,3)=indp+6;
        
        Tri(indTr+3,1)=indp+7;
        Tri(indTr+3,2)=indp+8;
        Tri(indTr+3,3)=indp+9;
        
        Tri(indTr+4,1)=indp+10;
        Tri(indTr+4,2)=indp+11;
        Tri(indTr+4,3)=indp+12;
        
        for k=1:12
            Z1(indp+k)=x(indp*3+(k-1)*3+1);
            Z2(indp+k)=x(indp*3+(k-1)*3+2);
            Z3(indp+k)=x(indp*3+(k-1)*3+3);
        end
        
        
        X(indp+1)=xref;
        Y(indp+1)=yref;
        X(indp+2)=xref;
        Y(indp+2)=yref-L/N;
        X(indp+3)=xref+L/(2*N);
        Y(indp+3)=yref-L/(2*N);
        
        X(indp+4)=xref+L/(2*N);
        Y(indp+4)=yref-L/(2*N);
        X(indp+5)=xref;
        Y(indp+5)=yref-L/N;
        X(indp+6)=xref+L/N;
        Y(indp+6)=yref-L/N;
        
        X(indp+7)=xref+L/(2*N);
        Y(indp+7)=yref-L/(2*N);
        X(indp+8)=xref+L/N;
        Y(indp+8)=yref-L/N;
        X(indp+9)=xref+L/N;
        Y(indp+9)=yref;
        
        X(indp+10)=xref;
        Y(indp+10)=yref;
        X(indp+11)=xref+L/(2*N);
        Y(indp+11)=yref-L/(2*N);
        X(indp+12)=xref+L/N;
        Y(indp+12)=yref;
    end
end

figure()
trisurf(Tri,X,Y,Z1);
title('champs sigmaXX');
%saveas(gcf,'sigmaxxk4.eps','epsc')

figure()
trisurf(Tri,X,Y,Z2);
title('champs sigmaXY');
%saveas(gcf,'sigmaxyk4.eps','epsc')

figure()
trisurf(Tri,X,Y,Z3);
title('champs sigmaYY');
%saveas(gcf,'sigmayyk4.eps','epsc')

figure()
trisurf(Tri,X,Y,(Z1-Z3).^2 + (2*Z2).^2);
title('Tresca');
%saveas(gcf,'Tresca.eps','epsc')

% X=[0 0 1];
% Y=[0 1 0];
% Tri=[1 2 3];
% Z=[0 3 3];
% trisurf(Tri,X,Y,Z)
% pcolor(C)

end

