y1 = load("Optimal_0_2_EIG_Con_100000.txt");
y2 = load("Optimal_0_2_EIG_Con_200000.txt");
y3 = load("Optimal_0_2_EIG_Con_400000.txt");
y4 = load("Optimal_0_2_EIG_Con_600000.txt");
y5 = load("Optimal_0_2_EIG_Con_800000.txt");
y6 = load("Optimal_0_2_EIG_Con_1000000.txt");

EIG_true = log(2/5/pi)/2 - 8/15;
mse = zeros(4,6);

mse(1,1) = mean(y1 - EIG_true);
mse(2,1) = var(y1,1);
mse(3,1) = mean((y1 - EIG_true).^2);
mse(4,1) = sqrt(mse(3,1))/EIG_true;

mse(1,2) = mean(y2 - EIG_true);
mse(2,2) = var(y2,1);
mse(3,2) = mean((y2 - EIG_true).^2);
mse(4,2) = sqrt(mse(3,2))/EIG_true;

mse(1,3) = mean(y3 - EIG_true);
mse(2,3) = var(y3,1);
mse(3,3) = mean((y3 - EIG_true).^2);
mse(4,3) = sqrt(mse(3,3))/EIG_true;

mse(1,4) = mean(y4 - EIG_true);
mse(2,4) = var(y4,1);
mse(3,4) = mean((y4 - EIG_true).^2);
mse(4,4) = sqrt(mse(3,4))/EIG_true;

mse(1,5) = mean(y5 - EIG_true);
mse(2,5) = var(y5,1);
mse(3,5) = mean((y5 - EIG_true).^2);
mse(4,5) = sqrt(mse(3,5))/EIG_true;

mse(1,6) = mean(y6 - EIG_true);
mse(2,6) = var(y6,1);
mse(3,6) = mean((y6 - EIG_true).^2);
mse(4,6) = sqrt(mse(3,6))/EIG_true;

writematrix(mse,"BIAS_VAR_MSE_RRMSE.csv")