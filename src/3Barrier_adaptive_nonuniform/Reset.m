%function Reset

y1 = xlsread('StoreNested');
y2 = xlsread('StoreNested',2);
y3 = xlsread('StoreNested',3);
y = [y1 y2 y3];
ProbTrue = 0.100000;
ExceTrue = 0.138984943679976;
QaudTrue = 18.1778829507404;
VaR = 4.66283276961562;
CVaR = 6.05339296544138;
L0 =  VaR;

R = zeros(size(y,1),1);
for i = 1:size(y,1)
    if length(find(y(i,21:25)<=10))==0 && length(find(y(i,16:20)<=10))==0        
        R(i) = i;
    else
        R(i) = 0;
    end
end
R = R(find(R>0));
y = y(R,:);

MSEProbNested = mean((y(:,1)-ProbTrue).^2);
MSEExceNested = mean((y(:,2)-ExceTrue).^2);
MSEQaudNested = mean((y(:,3)-QaudTrue).^2);
MSEVaRNested = mean((y(:,4) - VaR).^2);
MSECVaRNested = mean((y(:,5) - CVaR).^2);

ProbCov = mean((y(:,6)-ProbTrue<10^(-4))&(y(:,7)-ProbTrue>-10^(-4)));
ExceCov = mean((y(:,8)-ExceTrue<10^(-4))&(y(:,9)-ExceTrue>-10^(-4)));
QuadCov = mean((y(:,10)-QaudTrue<10^(-4))&(y(:,11)-QaudTrue>-10^(-4)));
VaRCov = mean((y(:,12)-VaR<10^(-4))&(y(:,13)-VaR>-10^(-4)));
CVaRCov = mean((y(:,14)-CVaR<10^(-4))&(y(:,15)-CVaR>-10^(-4)));

RRMSE = [sqrt(MSEProbNested)/ProbTrue sqrt(MSEExceNested)/ExceTrue...
    sqrt(MSEQaudNested)/QaudTrue sqrt(MSEVaRNested)/VaR sqrt(MSECVaRNested)/CVaR];

nRecord = y(:,16:20);
mRecord = y(:,21:25);
n_Mean = mean(nRecord);
m_Mean = mean(mRecord);

CovProb = [ProbCov ExceCov QuadCov VaRCov CVaRCov];

Result = [RRMSE;CovProb;n_Mean;m_Mean];

