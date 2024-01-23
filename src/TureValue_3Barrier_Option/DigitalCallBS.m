function y = DigitalCallBS(S0,K,T,sigma)

temp = size(S0);
n = temp(2);
clear temp

r = 5/100;

d2 = (log(S0/K)+(r-sigma^2/2)*T*ones(1,n))/(sigma*sqrt(T));

y = exp(-r*T)*normcdf(d2,0,1);