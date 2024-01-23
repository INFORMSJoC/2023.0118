y1 = load("Nested2Jack_Budget=10000_m0=n0=32_d=1.txt");
y2 = load("Nested2Jack_Budget=100000_m0=n0=100_d=1.txt");
y3 = load("Nested2Jack_Budget=1000000_m0=n0=100_d=1.txt");

ExceTrue = 0.138984943679976;
MSE_Exce = zeros(4,3);

MSE_Exce(1,1) = mean(y1(:,2) - ExceTrue);
MSE_Exce(2,1) = var(y1(:,2),1);
MSE_Exce(3,1) = mean((y1(:,2) - ExceTrue).^2);
MSE_Exce(4,1) = sqrt(MSE_Exce(3,1))/ExceTrue;

MSE_Exce(1,2) = mean(y2(:,2) - ExceTrue);
MSE_Exce(2,2) = var(y2(:,2),1);
MSE_Exce(3,2) = mean((y2(:,2) - ExceTrue).^2);
MSE_Exce(4,2) = sqrt(MSE_Exce(3,2))/ExceTrue;

MSE_Exce(1,3) = mean(y3(:,2) - ExceTrue);
MSE_Exce(2,3) = var(y3(:,2),1);
MSE_Exce(3,3) = mean((y3(:,2) - ExceTrue).^2);
MSE_Exce(4,3) = sqrt(MSE_Exce(3,3))/ExceTrue;

writematrix(MSE_Exce,"BIAS_VAR_MSE_RRMSE_Exce_2Jack_d=1.csv")