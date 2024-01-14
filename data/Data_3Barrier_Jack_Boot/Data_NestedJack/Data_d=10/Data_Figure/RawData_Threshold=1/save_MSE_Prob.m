y1 = load("NestedJack_Budget=10000_m0=n0=32_d=10.txt");
y2 = load("NestedJack_Budget=20000_m0=n0=32_d=10.txt");
y3 = load("NestedJack_Budget=40000_m0=n0=32_d=10.txt");
y4 = load("NestedJack_Budget=60000_m0=n0=100_d=10.txt");
y5 = load("NestedJack_Budget=80000_m0=n0=100_d=10.txt");
y6 = load("NestedJack_Budget=100000_m0=n0=100_d=10.txt");
y7 = load("NestedJack_Budget=200000_m0=n0=100_d=10.txt");
y8 = load("NestedJack_Budget=400000_m0=n0=100_d=10.txt");
y9 = load("NestedJack_Budget=600000_m0=n0=100_d=10.txt");
y10 = load("NestedJack_Budget=800000_m0=n0=100_d=10.txt");
y11 = load("NestedJack_Budget=1000000_m0=n0=100_d=10.txt");
y12 = load("NestedJack_Budget=2000000_m0=n0=100_d=10.txt");
y13 = load("NestedJack_Budget=4000000_m0=n0=100_d=10.txt");
y14 = load("NestedJack_Budget=6000000_m0=n0=100_d=10.txt");
y15 = load("NestedJack_Budget=8000000_m0=n0=100_d=10.txt");
y16 = load("NestedJack_Budget=10000000_m0=n0=100_d=10.txt");

ProbTrue = 0.1000000000;
MSE_Prob = zeros(4,16);

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

MSE_Prob(1,4) = mean(y4(:,1) - ProbTrue);
MSE_Prob(2,4) = var(y4(:,1),1);
MSE_Prob(3,4) = mean((y4(:,1) - ProbTrue).^2);
MSE_Prob(4,4) = sqrt(MSE_Prob(3,4))/ProbTrue;

MSE_Prob(1,5) = mean(y5(:,1) - ProbTrue);
MSE_Prob(2,5) = var(y5(:,1),1);
MSE_Prob(3,5) = mean((y5(:,1) - ProbTrue).^2);
MSE_Prob(4,5) = sqrt(MSE_Prob(3,5))/ProbTrue;

MSE_Prob(1,6) = mean(y6(:,1) - ProbTrue);
MSE_Prob(2,6) = var(y6(:,1),1);
MSE_Prob(3,6) = mean((y6(:,1) - ProbTrue).^2);
MSE_Prob(4,6) = sqrt(MSE_Prob(3,6))/ProbTrue;

MSE_Prob(1,7) = mean(y7(:,1) - ProbTrue);
MSE_Prob(2,7) = var(y7(:,1),1);
MSE_Prob(3,7) = mean((y7(:,1) - ProbTrue).^2);
MSE_Prob(4,7) = sqrt(MSE_Prob(3,7))/ProbTrue;

MSE_Prob(1,8) = mean(y8(:,1) - ProbTrue);
MSE_Prob(2,8) = var(y8(:,1),1);
MSE_Prob(3,8) = mean((y8(:,1) - ProbTrue).^2);
MSE_Prob(4,8) = sqrt(MSE_Prob(3,8))/ProbTrue;

MSE_Prob(1,9) = mean(y9(:,1) - ProbTrue);
MSE_Prob(2,9) = var(y9(:,1),1);
MSE_Prob(3,9) = mean((y9(:,1) - ProbTrue).^2);
MSE_Prob(4,9) = sqrt(MSE_Prob(3,9))/ProbTrue;

MSE_Prob(1,10) = mean(y10(:,1) - ProbTrue);
MSE_Prob(2,10) = var(y10(:,1),1);
MSE_Prob(3,10) = mean((y10(:,1) - ProbTrue).^2);
MSE_Prob(4,10) = sqrt(MSE_Prob(3,10))/ProbTrue;

MSE_Prob(1,11) = mean(y11(:,1) - ProbTrue);
MSE_Prob(2,11) = var(y11(:,1),1);
MSE_Prob(3,11) = mean((y11(:,1) - ProbTrue).^2);
MSE_Prob(4,11) = sqrt(MSE_Prob(3,11))/ProbTrue;

MSE_Prob(1,12) = mean(y12(:,1) - ProbTrue);
MSE_Prob(2,12) = var(y12(:,1),1);
MSE_Prob(3,12) = mean((y12(:,1) - ProbTrue).^2);
MSE_Prob(4,12) = sqrt(MSE_Prob(3,12))/ProbTrue;

MSE_Prob(1,13) = mean(y13(:,1) - ProbTrue);
MSE_Prob(2,13) = var(y13(:,1),1);
MSE_Prob(3,13) = mean((y13(:,1) - ProbTrue).^2);
MSE_Prob(4,13) = sqrt(MSE_Prob(3,13))/ProbTrue;

MSE_Prob(1,14) = mean(y14(:,1) - ProbTrue);
MSE_Prob(2,14) = var(y14(:,1),1);
MSE_Prob(3,14) = mean((y14(:,1) - ProbTrue).^2);
MSE_Prob(4,14) = sqrt(MSE_Prob(3,14))/ProbTrue;

MSE_Prob(1,15) = mean(y15(:,1) - ProbTrue);
MSE_Prob(2,15) = var(y15(:,1),1);
MSE_Prob(3,15) = mean((y15(:,1) - ProbTrue).^2);
MSE_Prob(4,15) = sqrt(MSE_Prob(3,15))/ProbTrue;

MSE_Prob(1,16) = mean(y16(:,1) - ProbTrue);
MSE_Prob(2,16) = var(y16(:,1),1);
MSE_Prob(3,16) = mean((y16(:,1) - ProbTrue).^2);
MSE_Prob(4,16) = sqrt(MSE_Prob(3,16))/ProbTrue;


writematrix(MSE_Prob,"BIAS_VAR_MSE_RRMSE_Prob_NestedJack.csv")