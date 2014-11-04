xsi1 = zeros(40,100);
xsi2 = zeros(40,100);

xsi1perm = zeros(40,100);
xsi2perm = zeros(40,100);

tau1=0.001;
tau2=0.01;

t1=linspace(-tau1,tau1,100);
t2=linspace(-tau2,tau2,100);

for i=1:40
    xsi1(i,:)=t1;
    xsi2(i,:)=t2;
    
    p1=t1;
    p2=t2;
    indicepermute1 = randperm(numel(p1));
    indicepermute2 = randperm(numel(p2));
    p1=p1(indicepermute1);
    p2=p2(indicepermute2);
    xsi1perm(i,:)=p1;
    xsi2perm(i,:)=p2;
end

%csvwrite('xsi_tau001.csv',xsi1);
%csvwrite('xsi_tau01.csv',xsi2);
%csvwrite('xsi_tau001-randPerm.csv',xsi1perm);
%csvwrite('xsi_tau01-randPerm.csv',xsi2perm);
