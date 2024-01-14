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

ExceTrue = 1.00028141727278;
MSE_Exce = zeros(4,16);

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

MSE_Exce(1,4) = mean(y4(:,2) - ExceTrue);
MSE_Exce(2,4) = var(y4(:,2),1);
MSE_Exce(3,4) = mean((y4(:,2) - ExceTrue).^2);
MSE_Exce(4,4) = sqrt(MSE_Exce(3,4))/ExceTrue;

MSE_Exce(1,5) = mean(y5(:,2) - ExceTrue);
MSE_Exce(2,5) = var(y5(:,2),1);
MSE_Exce(3,5) = mean((y5(:,2) - ExceTrue).^2);
MSE_Exce(4,5) = sqrt(MSE_Exce(3,5))/ExceTrue;

MSE_Exce(1,6) = mean(y6(:,2) - ExceTrue);
MSE_Exce(2,6) = var(y6(:,2),1);
MSE_Exce(3,6) = mean((y6(:,2) - ExceTrue).^2);
MSE_Exce(4,6) = sqrt(MSE_Exce(3,6))/ExceTrue;

MSE_Exce(1,7) = mean(y7(:,2) - ExceTrue);
MSE_Exce(2,7) = var(y7(:,2),1);
MSE_Exce(3,7) = mean((y7(:,2) - ExceTrue).^2);
MSE_Exce(4,7) = sqrt(MSE_Exce(3,7))/ExceTrue;

MSE_Exce(1,8) = mean(y8(:,2) - ExceTrue);
MSE_Exce(2,8) = var(y8(:,2),1);
MSE_Exce(3,8) = mean((y8(:,2) - ExceTrue).^2);
MSE_Exce(4,8) = sqrt(MSE_Exce(3,8))/ExceTrue;

MSE_Exce(1,9) = mean(y9(:,2) - ExceTrue);
MSE_Exce(2,9) = var(y9(:,2),1);
MSE_Exce(3,9) = mean((y9(:,2) - ExceTrue).^2);
MSE_Exce(4,9) = sqrt(MSE_Exce(3,9))/ExceTrue;

MSE_Exce(1,10) = mean(y10(:,2) - ExceTrue);
MSE_Exce(2,10) = var(y10(:,2),1);
MSE_Exce(3,10) = mean((y10(:,2) - ExceTrue).^2);
MSE_Exce(4,10) = sqrt(MSE_Exce(3,10))/ExceTrue;

MSE_Exce(1,11) = mean(y11(:,2) - ExceTrue);
MSE_Exce(2,11) = var(y11(:,2),1);
MSE_Exce(3,11) = mean((y11(:,2) - ExceTrue).^2);
MSE_Exce(4,11) = sqrt(MSE_Exce(3,11))/ExceTrue;

MSE_Exce(1,12) = mean(y12(:,2) - ExceTrue);
MSE_Exce(2,12) = var(y12(:,2),1);
MSE_Exce(3,12) = mean((y12(:,2) - ExceTrue).^2);
MSE_Exce(4,12) = sqrt(MSE_Exce(3,12))/ExceTrue;

MSE_Exce(1,13) = mean(y13(:,2) - ExceTrue);
MSE_Exce(2,13) = var(y13(:,2),1);
MSE_Exce(3,13) = mean((y13(:,2) - ExceTrue).^2);
MSE_Exce(4,13) = sqrt(MSE_Exce(3,13))/ExceTrue;

MSE_Exce(1,14) = mean(y14(:,2) - ExceTrue);
MSE_Exce(2,14) = var(y14(:,2),1);
MSE_Exce(3,14) = mean((y14(:,2) - ExceTrue).^2);
MSE_Exce(4,14) = sqrt(MSE_Exce(3,14))/ExceTrue;

MSE_Exce(1,15) = mean(y15(:,2) - ExceTrue);
MSE_Exce(2,15) = var(y15(:,2),1);
MSE_Exce(3,15) = mean((y15(:,2) - ExceTrue).^2);
MSE_Exce(4,15) = sqrt(MSE_Exce(3,15))/ExceTrue;

MSE_Exce(1,16) = mean(y16(:,2) - ExceTrue);
MSE_Exce(2,16) = var(y16(:,2),1);
MSE_Exce(3,16) = mean((y16(:,2) - ExceTrue).^2);
MSE_Exce(4,16) = sqrt(MSE_Exce(3,16))/ExceTrue;
writematrix(MSE_Exce,"BIAS_VAR_MSE_RRMSE_Exce_Reg.csv")