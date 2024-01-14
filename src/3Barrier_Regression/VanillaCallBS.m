function y = VanillaCallBS(S0,K,T,sigma,r)

temp = size(S0);
n = temp(2);
clear temp


d1 = (log(S0/K)+(r+sigma^2/2)*T*ones(1,n))/(sigma*sqrt(T));
d2 = d1 - sigma*sqrt(T)*ones(1,n);

y = S0.*normcdf(d1,0,1) - K*exp(-r*T)*normcdf(d2,0,1);