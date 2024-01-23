y1 = load("Nested2Jack_Budget=10000_m0=n0=32_d=1.txt");
y2 = load("Nested2Jack_Budget=100000_m0=n0=100_d=1.txt");
y3 = load("Nested2Jack_Budget=1000000_m0=n0=100_d=1.txt");

QaudTrue = 18.1778829507404;
MSE_Qaud = zeros(4,3);

MSE_Qaud(1,1) = mean(y1(:,3) - QaudTrue);
MSE_Qaud(2,1) = var(y1(:,3),1);
MSE_Qaud(3,1) = mean((y1(:,3) - QaudTrue).^2);
MSE_Qaud(4,1) = sqrt(MSE_Qaud(3,1))/QaudTrue;

MSE_Qaud(1,2) = mean(y2(:,3) - QaudTrue);
MSE_Qaud(2,2) = var(y2(:,3),1);
MSE_Qaud(3,2) = mean((y2(:,3) - QaudTrue).^2);
MSE_Qaud(4,2) = sqrt(MSE_Qaud(3,2))/QaudTrue;

MSE_Qaud(1,3) = mean(y3(:,3) - QaudTrue);
MSE_Qaud(2,3) = var(y3(:,3),1);
MSE_Qaud(3,3) = mean((y3(:,3) - QaudTrue).^2);
MSE_Qaud(4,3) = sqrt(MSE_Qaud(3,3))/QaudTrue;

writematrix(MSE_Qaud,"BIAS_VAR_MSE_RRMSE_Qaud_2Jack_d=1.csv")