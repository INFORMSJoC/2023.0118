function y = ResultJackNestedBUaO(Budget,n0,m0,d,nboot,I1,I2,L0,T,tau,sigma,threshold)

S0 = 100; %%--Initial value for all d underlying stocks
mu = 8/100;
r = 5/100;
N = 52;
h = T/N;%%-- Delta t
U = 120;
z = norminv(0.95,0,1); 
K = [90 100 110];
J = 2;

%=======================TRUE VALUE===============================
V0 = d*(BarrierUpOutCallBS(S0,K(1),sigma,T-tau,U,r)+ BarrierUpOutCallBS(S0,K(2),sigma,T-tau,U,r) + BarrierUpOutCallBS(S0,K(3),sigma,T-tau,U,r));

% generate initial samples n0*m0 and bootstrap-----------------------------
temp = NestedEsti(n0,m0,d,T,tau,sigma); % n0-by-(m0+2)
% SamplePath_t = temp(:,1:d);% n0-by-1
% MaxPre = temp(:,(d+1):2*d);% n0-by-1
SampleUp = temp(:,(2*d+1):(m0+2*d)); % n0-by-m0
clear temp

m1 = ones(1,3);
n1 = ones(1,3);
Record = zeros(1,3);
while length(find(m1<=threshold))>=1 || length(find(n1<=threshold))>=1
EstiProb1 = zeros(1,length(I1));
EstiExce1 = zeros(1,length(I1));
EstiQaud1 = zeros(1,length(I1));
for k = 1:length(I1)
    BootsEstiProb = zeros(1,nboot);
    BootsEstiExce = zeros(1,nboot);
    BootsEstiQaud = zeros(1,nboot);
    for i = 1:nboot
        outboot = [1:1:n0]'; %n0-by-1
        inboot = randi(m0,n0,I1(k)); %n0-by-I(k)
        a1 = repmat(outboot,1,size(inboot,2));%n0-by-I(k)
        index = sub2ind(size(SampleUp),a1,inboot);
        EstiLoss = V0 - mean(SampleUp(index),2);
        
        %---------Bootstrap_Jackknife------------
        BootMatrix = SampleUp(index);
        JackPre = BootMatrix(:,1:I1(k)/J);
        JackLat = BootMatrix(:,I1(k)/J + 1:I1(k));
        EstiLoss_JackPre = V0 - mean(JackLat,2);
        EstiLoss_JackLat = V0 - mean(JackPre,2);
        EstiLoss_Jack = [EstiLoss_JackPre EstiLoss_JackLat];

        EstiLoss_Jack_Prob = EstiLoss_Jack > L0;
        EstiLoss_Jack_Exce = max(EstiLoss_Jack - L0,0);
        EstiLoss_Jack_Qaud = EstiLoss_Jack.^2;


        BootsEstiProb(i) = mean(J*mean(EstiLoss > L0) - (J-1)*mean(EstiLoss_Jack_Prob,2));
        BootsEstiExce(i) = mean(J*mean(max(EstiLoss - L0,0)) - (J-1)*mean(EstiLoss_Jack_Exce,2));
        BootsEstiQaud(i) = mean(J*mean(EstiLoss.^2) - (J-1)*mean(EstiLoss_Jack_Qaud,2));
    end
    EstiProb1(k) = mean(BootsEstiProb);
    EstiExce1(k) = mean(BootsEstiExce);
    EstiQaud1(k) = mean(BootsEstiQaud);
end
b1 = [ones(1,length(I1));1./(I1.^2)]'\EstiProb1';
b2 = [ones(1,length(I1));1./(I1.^2)]'\EstiExce1';
b3 = [ones(1,length(I1));1./(I1.^2)]'\EstiQaud1';
C_Bias = [b1(2) b2(2) b3(2)];

clear b1 b2 b3 EstiProb1 EstiExce1 EstiQaud1
clear BootsEstiProb BootsEstiExce BootsEstiQaud EstiLoss
clear BootMatrix JackPre JackLat EstiLoss_JackPre EstiLoss_JackLat EstiLoss_Jack
clear EstiLoss_Jack_Prob EstiLoss_Jack_Exce EstiLoss_Jack_Qaud


% The constant of variance does not change
EstiProb2 = zeros(1,length(I2));
EstiExce2 = zeros(1,length(I2));
EstiQaud2 = zeros(1,length(I2));
for k = 1:length(I2)
    BootsEstiProb = zeros(1,nboot);
    BootsEstiExce = zeros(1,nboot);
    BootsEstiQaud = zeros(1,nboot);
    for i = 1:nboot
        outboot = randi(n0,I2(k),1);
        inboot = repmat([1:1:m0],I2(k),1);
        a1 = repmat(outboot,1,size(inboot,2));
        index = sub2ind(size(SampleUp),a1,inboot);
        EstiLoss = V0 - mean(SampleUp(index),2);

        BootsEstiProb(i) = mean(EstiLoss > L0);
        BootsEstiExce(i) = mean(max(EstiLoss - L0,0));
        BootsEstiQaud(i) = mean(EstiLoss.^2);
    end
    EstiProb2(k) = var(BootsEstiProb);
    EstiExce2(k) = var(BootsEstiExce);
    EstiQaud2(k) = var(BootsEstiQaud);
end
C_Var = [(1./I2)'\EstiProb2' (1./I2)'\EstiExce2' (1./I2)'\EstiQaud2'];

clear EstiProb2 EstiExce2 EstiQaud2
clear BootsEstiProb BootsEstiExce BootsEstiQaud EstiLoss

c = C_Var./(4*C_Bias.^2);
if sum(c == 0) > 0
    temp = NestedEsti(n0,m0,d,T,tau,sigma); % n0-by-(m0+2)
    SampleUp = temp(:,(2*d+1):(m0+2*d)); % n0-by-m0
    clear temp
    continue;
end

m1 = round((Budget./c).^(1/5));
n1 = round(Budget./m1);
if length(find(m1<=threshold))>=1 || length(find(n1<=threshold))>=1
    Record = Record + (m1<=threshold) + (n1<=threshold);
end
end

n = n1;
m = m1;
m = (fix(m./J)+1)*J;

%--------- Prob of large loss-------------------
temp = NestedEsti(n(1),m(1),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(1)+2*d));
clear temp
EstiLoss = V0*ones(n(1),1) - mean(SampleUp,2);

JackPre = SampleUp(:,1:m(1)/J);
JackLat = SampleUp(:,m(1)/J + 1:m(1));
EstiLoss_JackPre = V0 - mean(JackLat,2);
EstiLoss_JackLat = V0 - mean(JackPre,2);
EstiLoss_Jack = [EstiLoss_JackPre EstiLoss_JackLat];
EstiLoss_Jack_Prob = EstiLoss_Jack > L0;

NestedProb = mean(J*mean(EstiLoss > L0) - (J-1)*mean(EstiLoss_Jack_Prob,2));
clear SampleUp EstiLoss
clear JackPre JackLat EstiLoss_JackPre EstiLoss_JackLat EstiLoss_Jack
clear EstiLoss_Jack_Prob

%--------- Expected excess loss-------------------
temp = NestedEsti(n(2),m(2),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(2)+2*d));
clear temp
EstiLoss = V0*ones(n(2),1) - mean(SampleUp,2);

JackPre = SampleUp(:,1:m(2)/J);
JackLat = SampleUp(:,m(2)/J + 1:m(2));
EstiLoss_JackPre = V0 - mean(JackLat,2);
EstiLoss_JackLat = V0 - mean(JackPre,2);
EstiLoss_Jack = [EstiLoss_JackPre EstiLoss_JackLat];
EstiLoss_Jack_Exce = max(EstiLoss_Jack - L0,0);

NestedExce = mean(J*mean(max(EstiLoss - L0,0)) - (J-1)*mean(EstiLoss_Jack_Exce,2));
clear SampleUp EstiLoss
clear JackPre JackLat EstiLoss_JackPre EstiLoss_JackLat EstiLoss_Jack
clear EstiLoss_Jack_Exce

%--------- Qaudratic loss -------------------
temp = NestedEsti(n(3),m(3),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(3)+2*d));
clear temp
EstiLoss = V0*ones(n(3),1) - mean(SampleUp,2);

JackPre = SampleUp(:,1:m(3)/J);
JackLat = SampleUp(:,m(3)/J + 1:m(3));
EstiLoss_JackPre = V0 - mean(JackLat,2);
EstiLoss_JackLat = V0 - mean(JackPre,2);
EstiLoss_Jack = [EstiLoss_JackPre EstiLoss_JackLat];
EstiLoss_Jack_Qaud = EstiLoss_Jack.^2;

NestedQaud = mean(J*mean(EstiLoss.^2) - (J-1)*mean(EstiLoss_Jack_Qaud,2));
clear SampleUp EstiLoss
clear JackPre JackLat EstiLoss_JackPre EstiLoss_JackLat EstiLoss_Jack
clear EstiLoss_Jack_Qaud

y = [NestedProb NestedExce NestedQaud n m Record C_Var C_Bias]; %1*18

