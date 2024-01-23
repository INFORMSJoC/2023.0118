function y = BarrierUpOutCallBS(S0,K,sigma,T,U,r)

%%--U>S0



temp = size(S0);
n = temp(2);
clear temp

lambda = (r+sigma^2/2)/(sigma^2);

x1 = log(S0/U)/(sigma*sqrt(T)) + lambda*sigma*sqrt(T)*ones(1,n);
y1 = log(U./S0)/(sigma*sqrt(T)) + lambda*sigma*sqrt(T)*ones(1,n);

yu = log(U^2./(S0*K))/(sigma*sqrt(T)) + lambda*sigma*sqrt(T)*ones(1,n);

Value = VanillaCallBS(S0,K,T,sigma,r) - S0.*normcdf(x1,0,1) + K*exp(-r*T)*normcdf(x1 - sigma*sqrt(T)*ones(1,n),0,1);
Value = Value + S0.*power(U./S0,2*lambda).*(normcdf(-yu,0,1) - normcdf(-y1,0,1)) - K*exp(-r*T)*power(U./S0,2*lambda-2).*(normcdf(-yu + sigma*sqrt(T)*ones(1,n),0,1) - normcdf(-y1 + sigma*sqrt(T)*ones(1,n),0,1));

y = Value;
