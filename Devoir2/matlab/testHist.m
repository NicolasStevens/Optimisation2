
x=load('antennalin4050.csv');
x=x(:,2);
figure();
hist(x,40);

x=load('antennarobust1Tau01.csv');
figure();
hist(x,40);

x=load('antennarobust1Tau001.csv');
figure();
hist(x,40);