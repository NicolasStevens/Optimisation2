function [xsi] = Genxsi(tau,N)
%
% function that generate random xsi in the interval -tau,tau
%

xsi=(tau/1.5)*randn(N,1);
for i=1:N
   if abs(xsi(i))>tau
      xsi(i)=sign(xsi(i))*tau; 
   end
end
end

