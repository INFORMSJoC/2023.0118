function y = Result2JackNestedBUaO(Budget,n0,m0,d,nboot,I1,I2,L0,T,tau,sigma,threshold)

S0 = 100; %%--Initial value for all d underlying stocks
mu = 8/100;
r = 5/100;
N = 52;
h = T/N;%%-- Delta t
U = 120;
z = norminv(0.95,0,1); 
K = [90 100 110];
J1 = 2;
J2 = 3;


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
        % JackTwice represent Jackknife with J=2
        JackTwice1 = BootMatrix(:,1:I1(k)/J1);
        JackTwice2 = BootMatrix(:,I1(k)/J1 + 1:I1(k));
        EstiLoss_JackTwice1 = V0 - mean(JackTwice2,2);
        EstiLoss_JackTwice2 = V0 - mean(JackTwice1,2);
        EstiLoss_JackTwice = [EstiLoss_JackTwice1 EstiLoss_JackTwice2];

        EstiLoss_JackTwice_Prob = EstiLoss_JackTwice > L0;
        EstiLoss_JackTwice_Exce = max(EstiLoss_JackTwice - L0,0);
        EstiLoss_JackTwice_Qaud = EstiLoss_JackTwice.^2;

        Boot_JackTwice_Prob = mean(J1*mean(EstiLoss > L0) - (J1-1)*mean(EstiLoss_JackTwice_Prob,2));
        Boot_JackTwice_Exce = mean(J1*mean(max(EstiLoss - L0,0)) - (J1-1)*mean(EstiLoss_JackTwice_Exce,2));
        Boot_JackTwice_Qaud = mean(J1*mean(EstiLoss.^2) - (J1-1)*mean(EstiLoss_JackTwice_Qaud,2));
        
        % JackThird represent Jackknife with J=3
        JackThird1 = BootMatrix(:,1:2*I1(k)/J2);
        JackThird2 = BootMatrix;
        JackThird2(:,I1(k)/J2 + 1:2*I1(k)/J2) = [];
        JackThird3 = BootMatrix(:,I1(k)/J2 + 1:I1(k));
        EstiLoss_JackThird1 = V0 - mean(JackThird1,2);
        EstiLoss_JackThird2 = V0 - mean(JackThird2,2);
        EstiLoss_JackThird3 = V0 - mean(JackThird3,2);
        EstiLoss_JackThird = [EstiLoss_JackThird1 EstiLoss_JackThird2 EstiLoss_JackThird3];

        EstiLoss_JackThird_Prob = EstiLoss_JackThird > L0;
        EstiLoss_JackThird_Exce = max(EstiLoss_JackThird - L0,0);
        EstiLoss_JackThird_Qaud = EstiLoss_JackThird.^2;

        Boot_JackThird_Prob = mean(J2*mean(EstiLoss > L0) - (J2-1)*mean(EstiLoss_JackThird_Prob,2));
        Boot_JackThird_Exce = mean(J2*mean(max(EstiLoss - L0,0)) - (J2-1)*mean(EstiLoss_JackThird_Exce,2));
        Boot_JackThird_Qaud = mean(J2*mean(EstiLoss.^2) - (J2-1)*mean(EstiLoss_JackThird_Qaud,2));

        BootsEstiProb(i) = mean(4*Boot_JackThird_Prob - 3*Boot_JackTwice_Prob);
        BootsEstiExce(i) = mean(4*Boot_JackThird_Exce - 3*Boot_JackTwice_Exce);
        BootsEstiQaud(i) = mean(4*Boot_JackThird_Qaud - 3*Boot_JackTwice_Qaud);
    end
    EstiProb1(k) = mean(BootsEstiProb);
    EstiExce1(k) = mean(BootsEstiExce);
    EstiQaud1(k) = mean(BootsEstiQaud);
end
b1 = [ones(1,length(I1));1./(I1.^3)]'\EstiProb1';
b2 = [ones(1,length(I1));1./(I1.^3)]'\EstiExce1';
b3 = [ones(1,length(I1));1./(I1.^3)]'\EstiQaud1';
C_Bias = [b1(2) b2(2) b3(2)];

clear b1 b2 b3 EstiProb1 EstiExce1 EstiQaud1
clear BootsEstiProb BootsEstiExce BootsEstiQaud EstiLoss
clear BootMatrix JackTwice1 JackTwice2 EstiLoss_JackTwice1 EstiLoss_JackTwice2 EstiLoss_JackTwice
clear EstiLoss_JackTwice_Prob EstiLoss_JackTwice_Exce EstiLoss_JackTwice_Qaud


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

c = C_Var./(6*C_Bias.^2);
if sum(c == 0) > 0
    temp = NestedEsti(n0,m0,d,T,tau,sigma); % n0-by-(m0+2)
    SampleUp = temp(:,(2*d+1):(m0+2*d)); % n0-by-m0
    clear temp
    continue;
end

m1 = round((Budget./c).^(1/7));
n1 = round(Budget./m1);
if length(find(m1<=threshold))>=1 || length(find(n1<=threshold))>=1
    Record = Record + (m1<=threshold) + (n1<=threshold);
end
end

n = n1;
m = m1;
m = (fix(m./6)+1)*6;

%--------- Prob of large loss-------------------
temp = NestedEsti(n(1),m(1),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(1)+2*d));
clear temp
EstiLoss = V0*ones(n(1),1) - mean(SampleUp,2);

JackTwice1 = SampleUp(:,1:m(1)/J1);
JackTwice2 = SampleUp(:,m(1)/J1 + 1:m(1));
EstiLoss_JackTwice1 = V0 - mean(JackTwice2,2);
EstiLoss_JackTwice2 = V0 - mean(JackTwice1,2);
EstiLoss_JackTwice = [EstiLoss_JackTwice1 EstiLoss_JackTwice2];
EstiLoss_JackTwice_Prob = EstiLoss_JackTwice > L0;
Boot_JackTwice_Prob = mean(J1*mean(EstiLoss > L0) - (J1-1)*mean(EstiLoss_JackTwice_Prob,2));

JackThird1 = SampleUp(:,1:2*m(1)/J2);
JackThird2 = SampleUp;
JackThird2(:,m(1)/J2 + 1:2*m(1)/J2) = [];
JackThird3 = SampleUp(:,m(1)/J2 + 1:m(1));

EstiLoss_JackThird1 = V0 - mean(JackThird1,2);
EstiLoss_JackThird2 = V0 - mean(JackThird2,2);
EstiLoss_JackThird3 = V0 - mean(JackThird3,2);
EstiLoss_JackThird = [EstiLoss_JackThird1 EstiLoss_JackThird2 EstiLoss_JackThird3];
EstiLoss_JackThird_Prob = EstiLoss_JackThird > L0;
Boot_JackThird_Prob = mean(J2*mean(EstiLoss > L0) - (J2-1)*mean(EstiLoss_JackThird_Prob,2));


NestedProb = mean(4*Boot_JackThird_Prob - 3*Boot_JackTwice_Prob);
clear SampleUp EstiLoss
clear JackTwice1 JackTwice2 EstiLoss_JackTwice1 EstiLoss_JackTwice2 EstiLoss_Jack
clear EstiLoss_Jack_Prob

%--------- Expected excess loss-------------------
temp = NestedEsti(n(2),m(2),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(2)+2*d));
clear temp
EstiLoss = V0*ones(n(2),1) - mean(SampleUp,2);

JackTwice1 = SampleUp(:,1:m(2)/J1);
JackTwice2 = SampleUp(:,m(2)/J1 + 1:m(2));
EstiLoss_JackTwice1 = V0 - mean(JackTwice2,2);
EstiLoss_JackTwice2 = V0 - mean(JackTwice1,2);
EstiLoss_JackTwice = [EstiLoss_JackTwice1 EstiLoss_JackTwice2];
EstiLoss_JackTwice_Exce = max(EstiLoss_JackTwice - L0,0);
Boot_JackTwice_Exce = mean(J1*mean(max(EstiLoss - L0,0)) - (J1-1)*mean(EstiLoss_JackTwice_Exce,2));

JackThird1 = SampleUp(:,1:2*m(2)/J2);
JackThird2 = SampleUp;
JackThird2(:,m(2)/J2 + 1:2*m(2)/J2) = [];
JackThird3 = SampleUp(:,m(2)/J2 + 1:m(2));

EstiLoss_JackThird1 = V0 - mean(JackThird1,2);
EstiLoss_JackThird2 = V0 - mean(JackThird2,2);
EstiLoss_JackThird3 = V0 - mean(JackThird3,2);
EstiLoss_JackThird = [EstiLoss_JackThird1 EstiLoss_JackThird2 EstiLoss_JackThird3];
EstiLoss_JackThird_Exce = max(EstiLoss_JackThird - L0,0);
Boot_JackThird_Exce = mean(J2*mean(max(EstiLoss - L0,0)) - (J2-1)*mean(EstiLoss_JackThird_Exce,2));


NestedExce = mean(4*Boot_JackThird_Exce - 3*Boot_JackTwice_Exce);
clear SampleUp EstiLoss
clear JackTwice1 JackTwice2 EstiLoss_JackTwice1 EstiLoss_JackTwice2 EstiLoss_Jack
clear EstiLoss_Jack_Exce

%--------- Qaudratic loss -------------------
temp = NestedEsti(n(3),m(3),d,T,tau,sigma); % n0-by-(m0+2d)
SampleUp = temp(:,(2*d+1):(m(3)+2*d));
clear temp
EstiLoss = V0*ones(n(3),1) - mean(SampleUp,2);

JackTwice1 = SampleUp(:,1:m(3)/J1);
JackTwice2 = SampleUp(:,m(3)/J1 + 1:m(3));
EstiLoss_JackTwice1 = V0 - mean(JackTwice2,2);
EstiLoss_JackTwice2 = V0 - mean(JackTwice1,2);
EstiLoss_JackTwice = [EstiLoss_JackTwice1 EstiLoss_JackTwice2];
EstiLoss_JackTwice_Qaud = EstiLoss_JackTwice.^2;
Boot_JackTwice_Qaud = mean(J1*mean(EstiLoss.^2) - (J1-1)*mean(EstiLoss_JackTwice_Qaud,2));

JackThird1 = SampleUp(:,1:2*m(3)/J2);
JackThird2 = SampleUp;
JackThird2(:,m(3)/J2 + 1:2*m(3)/J2) = [];
JackThird3 = SampleUp(:,m(3)/J2 + 1:m(3));

EstiLoss_JackThird1 = V0 - mean(JackThird1,2);
EstiLoss_JackThird2 = V0 - mean(JackThird2,2);
EstiLoss_JackThird3 = V0 - mean(JackThird3,2);
EstiLoss_JackThird = [EstiLoss_JackThird1 EstiLoss_JackThird2 EstiLoss_JackThird3];
EstiLoss_JackThird_Qaud = EstiLoss_JackThird.^2;
Boot_JackThird_Qaud = mean(J2*mean(EstiLoss.^2) - (J2-1)*mean(EstiLoss_JackThird_Qaud,2));

NestedQaud = mean(4*Boot_JackThird_Qaud - 3*Boot_JackTwice_Qaud);
clear SampleUp EstiLoss
clear JackTwice1 JackTwice2 EstiLoss_JackTwice1 EstiLoss_JackTwice2 EstiLoss_Jack
clear EstiLoss_Jack_Qaud

y = [NestedProb NestedExce NestedQaud n m Record C_Var C_Bias]; %1*18

