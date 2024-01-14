function y = BarrierUpOutCallBSRev(S0,K,sigma,T,U,r)


%%--H<K
%r = 5/100;

temp = size(S0);
n = temp(2);
clear temp

%lambda = (r+sigma^2/2)/(sigma^2);
alpha = 1/2*(1-r/(sigma^2/2));


y = VanillaCallBS(S0,K,T,sigma) - VanillaCallBS(S0,U,T,sigma) - (U-K)*DigitalCallBS(S0,U,T,sigma) - power(S0/U,2*alpha).*(VanillaCallBS(U^2./S0,K,T,sigma) - VanillaCallBS(U^2./S0,U,T,sigma) - (U-K)*DigitalCallBS(U^2./S0,U,T,sigma));