function y = ResultNestedBUaO(Budget,n0,m0,d,nboot,I1,I2,L0,T,tau,sigma,threshold)

S0 = 100; %%--Initial value for all d underlying stocks
mu = 8/100;
r = 5/100;
N = 52;
h = T/N;%%-- Delta t
U = 120;
z = norminv(0.95,0,1); 
K = [90 100 110];

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
EstiQuad1 = zeros(1,length(I1));
for k = 1:length(I1)
    BootsEstiProb = zeros(1,nboot);
    BootsEstiExce = zeros(1,nboot);
    BootsEstiQuad = zeros(1,nboot);
    for i = 1:nboot
        outboot = [1:1:n0]'; %n0-by-1
        inboot = randi(m0,n0,I1(k)); %n0-by-I(k)
        a1 = repmat(outboot,1,size(inboot,2));%n0-by-I(k)
        index = sub2ind(size(SampleUp),a1,inboot);
        EstiLoss = V0 - mean(SampleUp(index),2);
        
        %---------Bootstrap------------
        BootsEstiProb(i) = mean(EstiLoss > L0);
        BootsEstiExce(i) = mean(max(EstiLoss - L0,0));
        BootsEstiQuad(i) = mean(EstiLoss.^2);
    end
    EstiProb1(k) = mean(BootsEstiProb);
    EstiExce1(k) = mean(BootsEstiExce);
    EstiQuad1(k) = mean(BootsEstiQuad);
end
b1 = [ones(1,length(I1));1./I1]'\EstiProb1';
b2 = [ones(1,length(I1));1./I1]'\EstiExce1';
b3 = [ones(1,length(I1));1./I1]'\EstiQuad1';
C_Bias = [b1(2) b2(2) b3(2)];

clear b1 b2 b3 EstiProb1 EstiExce1 EstiQuad1
clear BootsEstiProb BootsEstiExce BootsEstiQuad EstiLoss
clear BootMatrix JackPre JackLat EstiLoss_JackPre EstiLoss_JackLat EstiLoss_Jack
clear EstiLoss_Jack_Prob EstiLoss_Jack_Exce EstiLoss_Jack_Quad


% The constant of variance does not change
EstiProb2 = zeros(1,length(I2));
EstiExce2 = zeros(1,length(I2));
EstiQuad2 = zeros(1,length(I2));
for k = 1:length(I2)
    BootsEstiProb = zeros(1,nboot);
    BootsEstiExce = zeros(1,nboot);
    BootsEstiQuad = zeros(1,nboot);
    for i = 1:nboot
        outboot = randi(n0,I2(k),1);
        inboot = repmat([1:1:m0],I2(k),1);
        a1 = repmat(outboot,1,size(inboot,2));
        index = sub2ind(size(SampleUp),a1,inboot);
        EstiLoss = V0 - mean(SampleUp(index),2);

        BootsEstiProb(i) = mean(EstiLoss > L0);
        BootsEstiExce(i) = mean(max(EstiLoss - L0,0));
        BootsEstiQuad(i) = mean(EstiLoss.^2);
    end
    EstiProb2(k) = var(BootsEstiProb);
    EstiExce2(k) = var(BootsEstiExce);
    EstiQuad2(k) = var(BootsEstiQuad);
end
C_Var = [(1./I2)'\EstiProb2' (1./I2)'\EstiExce2' (1./I2)'\EstiQuad2'];

clear EstiProb2 EstiExce2 EstiQuad2
clear BootsEstiProb BootsEstiExce BootsEstiQuad EstiLoss

c = C_Var./(2*C_Bias.^2);
if sum(c == 0) > 0
    temp = NestedEsti(n0,m0,d,T,tau,sigma); % n0-by-(m0+2)
    SampleUp = temp(:,(2*d+1):(m0+2*d)); % n0-by-m0
    clear temp
    continue;
end

m1 = round((Budget./c).^(1/3));
n1 = round(Budget./m1);
if length(find(m1<=threshold))>=1 || length(find(n1<=threshold))>=1
    Record = Record + (m1<=threshold) + (n1<=threshold);
end
end

n = n1;
m = m1;

%--------- Prob of large loss-------------------
temp = NestedEsti(n(1),m(1),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(1)+2*d));
clear temp
EstiLoss = V0*ones(n(1),1) - mean(SampleUp,2);

NestedProb = mean(EstiLoss > L0);
clear SampleUp EstiLoss

%--------- Expected excess loss-------------------
temp = NestedEsti(n(2),m(2),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(2)+2*d));
clear temp
EstiLoss = V0*ones(n(2),1) - mean(SampleUp,2);

NestedExce = mean(max(EstiLoss - L0,0));
clear SampleUp EstiLoss

%--------- Quadratic loss -------------------
temp = NestedEsti(n(3),m(3),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(3)+2*d));
clear temp
EstiLoss = V0*ones(n(3),1) - mean(SampleUp,2);

NestedQuad = mean(EstiLoss.^2);
clear SampleUp EstiLoss

y = [NestedProb NestedExce NestedQuad n m Record C_Var C_Bias]; %1*18

