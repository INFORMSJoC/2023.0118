y1 = load("RegResult_Budget=10000_m=1_d=10_basis4.txt");
y2 = load("RegResult_Budget=20000_m=1_d=10_basis4.txt");
y3 = load("RegResult_Budget=40000_m=1_d=10_basis4.txt");
y4 = load("RegResult_Budget=60000_m=1_d=10_basis4.txt");
y5 = load("RegResult_Budget=80000_m=1_d=10_basis4.txt");
y6 = load("RegResult_Budget=100000_m=1_d=10_basis4.txt");
y7 = load("RegResult_Budget=200000_m=1_d=10_basis4.txt");
y8 = load("RegResult_Budget=400000_m=1_d=10_basis4.txt");
y9 = load("RegResult_Budget=600000_m=1_d=10_basis4.txt");
y10 = load("RegResult_Budget=800000_m=1_d=10_basis4.txt");
y11 = load("RegResult_Budget=1000000_m=1_d=10_basis4.txt");
y12 = load("RegResult_Budget=2000000_m=1_d=10_basis4.txt");
y13 = load("RegResult_Budget=4000000_m=1_d=10_basis4.txt");
y14 = load("RegResult_Budget=6000000_m=1_d=10_basis4.txt");
y15 = load("RegResult_Budget=8000000_m=1_d=10_basis4.txt");
y16 = load("RegResult_Budget=10000000_m=1_d=10_basis4.txt");

QaudTrue = 686.837555855872;
MSE_Qaud = zeros(4,16);

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

MSE_Qaud(1,4) = mean(y4(:,3) - QaudTrue);
MSE_Qaud(2,4) = var(y4(:,3),1);
MSE_Qaud(3,4) = mean((y4(:,3) - QaudTrue).^2);
MSE_Qaud(4,4) = sqrt(MSE_Qaud(3,4))/QaudTrue;

MSE_Qaud(1,5) = mean(y5(:,3) - QaudTrue);
MSE_Qaud(2,5) = var(y5(:,3),1);
MSE_Qaud(3,5) = mean((y5(:,3) - QaudTrue).^2);
MSE_Qaud(4,5) = sqrt(MSE_Qaud(3,5))/QaudTrue;

MSE_Qaud(1,6) = mean(y6(:,3) - QaudTrue);
MSE_Qaud(2,6) = var(y6(:,3),1);
MSE_Qaud(3,6) = mean((y6(:,3) - QaudTrue).^2);
MSE_Qaud(4,6) = sqrt(MSE_Qaud(3,6))/QaudTrue;

MSE_Qaud(1,7) = mean(y7(:,3) - QaudTrue);
MSE_Qaud(2,7) = var(y7(:,3),1);
MSE_Qaud(3,7) = mean((y7(:,3) - QaudTrue).^2);
MSE_Qaud(4,7) = sqrt(MSE_Qaud(3,7))/QaudTrue;

MSE_Qaud(1,8) = mean(y8(:,3) - QaudTrue);
MSE_Qaud(2,8) = var(y8(:,3),1);
MSE_Qaud(3,8) = mean((y8(:,3) - QaudTrue).^2);
MSE_Qaud(4,8) = sqrt(MSE_Qaud(3,8))/QaudTrue;

MSE_Qaud(1,9) = mean(y9(:,3) - QaudTrue);
MSE_Qaud(2,9) = var(y9(:,3),1);
MSE_Qaud(3,9) = mean((y9(:,3) - QaudTrue).^2);
MSE_Qaud(4,9) = sqrt(MSE_Qaud(3,9))/QaudTrue;

MSE_Qaud(1,10) = mean(y10(:,3) - QaudTrue);
MSE_Qaud(2,10) = var(y10(:,3),1);
MSE_Qaud(3,10) = mean((y10(:,3) - QaudTrue).^2);
MSE_Qaud(4,10) = sqrt(MSE_Qaud(3,10))/QaudTrue;

MSE_Qaud(1,11) = mean(y11(:,3) - QaudTrue);
MSE_Qaud(2,11) = var(y11(:,3),1);
MSE_Qaud(3,11) = mean((y11(:,3) - QaudTrue).^2);
MSE_Qaud(4,11) = sqrt(MSE_Qaud(3,11))/QaudTrue;

MSE_Qaud(1,12) = mean(y12(:,3) - QaudTrue);
MSE_Qaud(2,12) = var(y12(:,3),1);
MSE_Qaud(3,12) = mean((y12(:,3) - QaudTrue).^2);
MSE_Qaud(4,12) = sqrt(MSE_Qaud(3,12))/QaudTrue;

MSE_Qaud(1,13) = mean(y13(:,3) - QaudTrue);
MSE_Qaud(2,13) = var(y13(:,3),1);
MSE_Qaud(3,13) = mean((y13(:,3) - QaudTrue).^2);
MSE_Qaud(4,13) = sqrt(MSE_Qaud(3,13))/QaudTrue;

MSE_Qaud(1,14) = mean(y14(:,3) - QaudTrue);
MSE_Qaud(2,14) = var(y14(:,3),1);
MSE_Qaud(3,14) = mean((y14(:,3) - QaudTrue).^2);
MSE_Qaud(4,14) = sqrt(MSE_Qaud(3,14))/QaudTrue;

MSE_Qaud(1,15) = mean(y15(:,3) - QaudTrue);
MSE_Qaud(2,15) = var(y15(:,3),1);
MSE_Qaud(3,15) = mean((y15(:,3) - QaudTrue).^2);
MSE_Qaud(4,15) = sqrt(MSE_Qaud(3,15))/QaudTrue;

MSE_Qaud(1,16) = mean(y16(:,3) - QaudTrue);
MSE_Qaud(2,16) = var(y16(:,3),1);
MSE_Qaud(3,16) = mean((y16(:,3) - QaudTrue).^2);
MSE_Qaud(4,16) = sqrt(MSE_Qaud(3,16))/QaudTrue;
writematrix(MSE_Qaud,"BIAS_VAR_MSE_RRMSE_Qaud_Reg.csv")