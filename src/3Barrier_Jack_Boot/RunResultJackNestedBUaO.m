rep = 1000;
Budget = 10000;
threshold = 1;

n0 = 32;
m0 = 32;
I1 = 20:4:m0;
I2 = 20:4:n0;
nboot = 1000;


sigma = 20/100; 
S0 = 100; %%--Initial value for all d underlying stocks
K = [90 100 110];
mu = 8/100;
r = 5/100;
T = 1/12;
N = 52;
h = T/N; %%-- Delta t
tau = 12*h; % future time: one week after
U = 120;
d = 1;


%=======================TRUE VALUE===============================
V0 = d*(BarrierUpOutCallBS(S0,K(1),sigma,T-tau,U,r)+ BarrierUpOutCallBS(S0,K(2),sigma,T-tau,U,r) + BarrierUpOutCallBS(S0,K(3),sigma,T-tau,U,r));

% % True value when d = 1
ProbTrue = 0.100000;
ExceTrue = 0.138984943679976;
QaudTrue = 18.1778829507404;
VaR = 4.66283276961562;
CVaR = 6.05339296544138;

% % True value when d = 10
% ProbTrue = 0.100000;
% ExceTrue = 1.00028141727278;
% QaudTrue = 686.837555855872;
% VaR = 26.7720166840765;
% CVaR = 36.7748308568043;

L0 =  VaR;

%=====================================================================

y = zeros(rep,18);
fid = fopen('NestedJack_Budget=10000_m0=n0=32_d=1.txt','a');
for i=1:rep
    i
    tic
    y(i,:) = ResultJackNestedBUaO(Budget,n0,m0,d,nboot,I1,I2,L0,T,tau,sigma,threshold);
    for j = 1:18
        if j == 18
            fprintf(fid,'%14.10f\n',y(i,j));
        else
            fprintf(fid,'%14.10f\t',y(i,j));
        end
    end
    toc
end

fclose(fid);


MSEProbNested = mean((y(:,1)-ProbTrue).^2);
MSEExceNested = mean((y(:,2)-ExceTrue).^2);
MSEQaudNested = mean((y(:,3)-QaudTrue).^2);

