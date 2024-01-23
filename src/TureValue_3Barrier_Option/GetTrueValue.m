clear
global   r  K tau T h mu S0 N sigma V0 U

n = 10^9;
n1 = 10^6;
sigma = 20/100; %d-by-1 row
S0 = 100; %%--Initial value for all d underlying stocks
K =[90 100 110];
mu = 8/100;
r = 5/100;
T = 1/12;
N = 52;
h = T/N;%%-- Delta t
tau = 12*h; % future time: one week after
U = 120;

alpha = 0.9;
d = 10;

SampleL = zeros(1,n);

V0 = d*(BarrierUpOutCallBS(S0,K(1),sigma,T-tau,U,r)+ BarrierUpOutCallBS(S0,K(2),sigma,T-tau,U,r) + BarrierUpOutCallBS(S0,K(3),sigma,T-tau,U,r));

Ind = 0;
for k = 1:n/n1
    tic
    SampleL((k-1)*n1+1:k*n1) = SimTrueLoss_UaO(n1,d,V0);
    toc
    Ind = Ind + 1
end

SortedSampleL = sort(SampleL);
clear SampleL

y0 = SortedSampleL(alpha*n);   %%L0

Result = zeros(1,4);

Result(1) = mean(SortedSampleL>=y0);

Result(2) = mean((SortedSampleL-y0*ones(1,n)).*(SortedSampleL>=y0));

Result(3) = mean(SortedSampleL.^2);

Result(4) = y0 + Result(2)/(1-alpha);
y = [y0 Result];

