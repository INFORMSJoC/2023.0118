clear,clc,close all

%---10^5-->10^7------------------------------
filenameNestedProb = 'BIAS_VAR_MSE_RRMSE_Prob_Nested.csv';
filenameNestedExce = 'BIAS_VAR_MSE_RRMSE_Exce_Nested.csv';
filenameNestedQaud = 'BIAS_VAR_MSE_RRMSE_Qaud_Nested.csv';

filenameFASTProb = 'BIAS_VAR_MSE_RRMSE_Prob_NestedJack.csv';
filenameFASTExce = 'BIAS_VAR_MSE_RRMSE_Exce_NestedJack.csv';
filenameFASTQaud = 'BIAS_VAR_MSE_RRMSE_Qaud_NestedJack.csv';

filename2FASTProb = 'BIAS_VAR_MSE_RRMSE_Prob_Nested2Jack.csv';
filename2FASTExce = 'BIAS_VAR_MSE_RRMSE_Exce_Nested2Jack.csv';
filename2FASTQaud = 'BIAS_VAR_MSE_RRMSE_Qaud_Nested2Jack.csv';

filenameRegProb = 'BIAS_VAR_MSE_RRMSE_Prob_Reg_Order5.csv';
filenameRegExce = 'BIAS_VAR_MSE_RRMSE_Exce_Reg_Order5.csv';
filenameRegQaud = 'BIAS_VAR_MSE_RRMSE_Qaud_Reg_Order5.csv';

MSENestedProb = load(filenameNestedProb);
MSENestedExce = load(filenameNestedExce);
MSENestedQaud = load(filenameNestedQaud);

MSEFASTProb = load(filenameFASTProb);
MSEFASTExce = load(filenameFASTExce);
MSEFASTQaud = load(filenameFASTQaud);

MSE2FASTProb = load(filename2FASTProb);
MSE2FASTExce = load(filename2FASTExce);
MSE2FASTQaud = load(filename2FASTQaud);

MSERegProb = load(filenameRegProb);
MSERegExce = load(filenameRegExce);
MSERegQaud = load(filenameRegQaud);

n = [1 2 4 6 8 10 20 40 60 80 100 200 400 600 800 1000];
n = n*10^4;
MSENestedProbTest = -2*(log(n) - log(100000))/3 + log(MSENestedProb(3,6));
MSENestedExceTest = -2*(log(n) - log(100000))/3 + log(MSENestedExce(3,6));
MSENestedQaudTest = -2*(log(n) - log(100000))/3 + log(MSENestedQaud(3,6));

MSEFASTProbTest = -4*(log(n) - log(100000))/5 - 9.6;
MSEFASTExceTest = -4*(log(n) - log(100000))/5 - 9.035;
MSEFASTQaudTest = -4*(log(n) - log(100000))/5 - 1.58;

MSE2FASTProbTest = -6*(log(n) - log(10000000))/7 + log(MSE2FASTProb(3,16));
MSE2FASTExceTest = -6*(log(n) - log(10000000))/7 + log(MSE2FASTExce(3,16));
MSE2FASTQaudTest = -6*(log(n) - log(10000000))/7 + log(MSE2FASTQaud(3,16));

MSERegProbTest = -(log(n) - log(10000)) + log(MSERegProb(3,1));
MSERegExceTest = -(log(n) - log(10000)) + log(MSERegExce(3,1));
MSERegQaudTest = -(log(n) - log(10000)) + log(MSERegQaud(3,1));
 
figure,
axis square
subplot(1,3,1);
h = loglog(n,MSENestedProb(3,:),'m-x',n,MSEFASTProb(3,:),'r-+',n,MSE2FASTProb(3,:),'g-<',n,MSERegProb(3,:),'b-p',n,exp(MSENestedProbTest),'k:',n,exp(MSEFASTProbTest),'k-',n,exp(MSE2FASTProbTest),'k--',n,exp(MSERegProbTest),'k-.'); hold on;
%h = plot(x1,log(MSE_tilde1),'b:p',x1,-x1+4.9,'k-.'); hold on;
set(h,'LineWidth',3)
set(h,'Markersize',15)
set(h(3),'Color','#54B345')
legend('SNS','FAST','2-FAST','LSM','Slope $-2/3$','Slope $-4/5$','Slope $-6/7$','Slope $-1$','Interpreter','latex');
%legend('$\log(n)$','Slope $-1$','Interpreter','latex');
xlabel('Sample size')
ylabel('Estimated MSE')
ylim([4*10^(-8),2*10^(-2)]);
set(gca,'fontsize',25)
set(gca,'LineWidth',3)
%set(gca,'Position',[0.04 0.25 0.27 0.5]);
title('Indicator function');
grid on;
legend('show')



subplot(1,3,2);
h = loglog(n,MSENestedExce(3,:),'m-x',n,MSEFASTExce(3,:),'r-+',n,MSE2FASTExce(3,:),'g-<',n,MSERegExce(3,:),'b-p',n,exp(MSENestedExceTest),'k:',n,exp(MSEFASTExceTest),'k-',n,exp(MSE2FASTExceTest),'k--',n,exp(MSERegExceTest),'k-.'); hold on;
%h = plot(x1,log(MSE_tilde1),'b:p',x1,-x1+4.9,'k-.'); hold on;
set(h,'LineWidth',3)
set(h,'Markersize',15)
set(h(3),'Color','#54B345')
legend('SNS','FAST','2-FAST','LSM','Slope $-2/3$','Slope $-4/5$','Slope $-6/7$','Slope $-1$','Interpreter','latex');
%legend('$\log(n)$','Slope $-1$','Interpreter','latex');
xlabel('Sample size')
ylabel('Estimated MSE')
%ylim([10^(-5),10^(-4)]);
set(gca,'fontsize',25)
set(gca,'LineWidth',3)
%set(gca,'Position',[0.04 0.25 0.27 0.5]);
title('Hockey-stick function');
grid on;
legend('show')

subplot(1,3,3);
h = loglog(n,MSENestedQaud(3,:),'m-x',n,MSEFASTQaud(3,:),'r-+',n,MSE2FASTQaud(3,:),'g-<',n,MSERegQaud(3,:),'b-p',n,exp(MSENestedQaudTest),'k:',n,exp(MSEFASTQaudTest),'k-',n,exp(MSE2FASTQaudTest),'k--',n,exp(MSERegQaudTest),'k-.'); hold on;
%h = plot(x1,log(MSE_tilde1),'b:p',x1,-x1+4.9,'k-.'); hold on;
set(h,'LineWidth',3)
set(h,'Markersize',15)
set(h(3),'Color','#54B345')
legend('SNS','FAST','2-FAST','LSM','Slope $-2/3$','Slope $-4/5$','Slope $-6/7$','Slope $-1$','Interpreter','latex');
%legend('$\log(n)$','Slope $-1$','Interpreter','latex');
xlabel('Sample size')
ylabel('Estimated MSE')
ylim([6*10^(-4),20]);
set(gca,'fontsize',25)
set(gca,'LineWidth',3)
%set(gca,'Position',[0.04 0.25 0.27 0.5]);
title('Quadratic function');
grid on;
legend('show')
