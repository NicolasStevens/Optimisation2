function di = computedi(theta,r)
N = length(r);
m = length(theta);
nint = 200;
xx = linspace(0,2*pi,nint);
di = zeros(N,m);
for i=1:N
    for j=1:m
        fS = 0.5*cos(2*pi*r(i)*cos(theta(j))*cos(xx));
        di(i,j) = trapz(xx,fS);
    end
end
end
