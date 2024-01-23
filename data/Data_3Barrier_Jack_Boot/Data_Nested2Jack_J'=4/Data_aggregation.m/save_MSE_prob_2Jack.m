y1 = load("Nested2Jack_Budget=10000_m0=n0=32_d=1.txt");
y2 = load("Nested2Jack_Budget=100000_m0=n0=100_d=1.txt");
y3 = load("Nested2Jack_Budget=1000000_m0=n0=100_d=1.txt");

ProbTrue = 0.100000;
MSE_Prob = zeros(4,3);

MSE_Prob(1,1) = mean(y1(:,1) - ProbTrue);
MSE_Prob(2,1) = var(y1(:,1),1);
MSE_Prob(3,1) = mean((y1(:,1) - ProbTrue).^2);
MSE_Prob(4,1) = sqrt(MSE_Prob(3,1))/ProbTrue;

MSE_Prob(1,2) = mean(y2(:,1) - ProbTrue);
MSE_Prob(2,2) = var(y2(:,1),1);
MSE_Prob(3,2) = mean((y2(:,1) - ProbTrue).^2);
MSE_Prob(4,2) = sqrt(MSE_Prob(3,2))/ProbTrue;

MSE_Prob(1,3) = mean(y3(:,1) - ProbTrue);
MSE_Prob(2,3) = var(y3(:,1),1);
MSE_Prob(3,3) = mean((y3(:,1) - ProbTrue).^2);
MSE_Prob(4,3) = sqrt(MSE_Prob(3,3))/ProbTrue;

writematrix(MSE_Prob,"BIAS_VAR_MSE_RRMSE_Prob_2Jack_d=1.csv")