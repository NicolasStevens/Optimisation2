function [Anew,cnew] = pivot2(A,c,N)
%
%
%



nbNoeud=N*N*4*3;
for i=1:N
    for j=1:N
    Anew(:,(i-1)*N+j:+36)=A(:,(j-1)*N+i:+36);
    end
end

end

