y1 = load("EIG_10w_Two_Jack_0_2.txt");
y2 = load("EIG_20w_Two_Jack_0_2.txt");
y3 = load("EIG_40w_Two_Jack_0_2.txt");
y4 = load("EIG_60w_Two_Jack_0_2.txt");
y5 = load("EIG_80w_Two_Jack_0_2.txt");
y6 = load("EIG_100w_Two_Jack_0_2.txt");
y1 = y1(:,1);
y2 = y2(:,1);
y3 = y3(:,1);
y4 = y4(:,1);
y5 = y5(:,1);
y6 = y6(:,1);

EIG_true = log(2/5/pi)/2 - 8/15;
mse = zeros(6,6);

mse(1,1) = mean(y1 - EIG_true);
mse(2,1) = var(y1,1);
mse(3,1) = mean((y1 - EIG_true).^2);
mse(4,1) = sqrt(mse(3,1))/EIG_true;
mse(5,1) = mse(1,1) - 1.64*sqrt(mse(2,1)/2000);
mse(6,1) = mse(1,1) + 1.64*sqrt(mse(2,1)/2000);

mse(1,2) = mean(y2 - EIG_true);
mse(2,2) = var(y2,1);
mse(3,2) = mean((y2 - EIG_true).^2);
mse(4,2) = sqrt(mse(3,2))/EIG_true;
mse(5,2) = mse(1,2) - 1.64*sqrt(mse(2,2)/2000);
mse(6,2) = mse(1,2) + 1.64*sqrt(mse(2,2)/2000);

mse(1,3) = mean(y3 - EIG_true);
mse(2,3) = var(y3,1);
mse(3,3) = mean((y3 - EIG_true).^2);
mse(4,3) = sqrt(mse(3,3))/EIG_true;
mse(5,3) = mse(1,3) - 1.64*sqrt(mse(2,3)/2000);
mse(6,3) = mse(1,3) + 1.64*sqrt(mse(2,3)/2000);

mse(1,4) = mean(y4 - EIG_true);
mse(2,4) = var(y4,1);
mse(3,4) = mean((y4 - EIG_true).^2);
mse(4,4) = sqrt(mse(3,4))/EIG_true;
mse(5,4) = mse(1,4) - 1.64*sqrt(mse(2,4)/2000);
mse(6,4) = mse(1,4) + 1.64*sqrt(mse(2,4)/2000);

mse(1,5) = mean(y5 - EIG_true);
mse(2,5) = var(y5,1);
mse(3,5) = mean((y5 - EIG_true).^2);
mse(4,5) = sqrt(mse(3,5))/EIG_true;
mse(5,5) = mse(1,5) - 1.64*sqrt(mse(2,5)/2000);
mse(6,5) = mse(1,5) + 1.64*sqrt(mse(2,5)/2000);

mse(1,6) = mean(y6 - EIG_true);
mse(2,6) = var(y6,1);
mse(3,6) = mean((y6 - EIG_true).^2);
mse(4,6) = sqrt(mse(3,6))/EIG_true;
mse(5,6) = mse(1,6) - 1.64*sqrt(mse(2,6)/2000);
mse(6,6) = mse(1,6) + 1.64*sqrt(mse(2,6)/2000);

writematrix(mse,"BIAS_VAR_MSE_RRMSE.csv")