function y = RegResultBUaO(Budget,m,d,L0,T,tau,sigma)

S0 = 100; %%--Initial value for all d underlying stocks
mu = 8/100;
r = 5/100;
N = 52;
h = T/N;%%-- Delta t
U = 120;
z = norminv(0.95,0,1); 
K = [90 100 110];
n = round(Budget/m);
%n_prime = round(0.3*n);

%=======================TRUE VALUE===============================
V0 = d*(BarrierUpOutCallBS(S0,K(1),sigma,T-tau,U,r)+ BarrierUpOutCallBS(S0,K(2),sigma,T-tau,U,r) + BarrierUpOutCallBS(S0,K(3),sigma,T-tau,U,r));

% generate initial samples n0*m0 and bootstrap-----------------------------
temp = NestedEsti(n,m,d,T,tau,sigma); % n0-by-(m0+2)
X = temp(:,1:2*d);
SampleUp = temp(:,(2*d+1):(m+2*d)); % n0-by-m0
clear temp

regression_coff = RegEsti(X,V0 - SampleUp);
clear SampleUp

temp = NestedEsti(10000,1,d,T,tau,sigma); % n0-by-(m0+2)
X = temp(:,1:2*d);
clear temp

inMean = mean(X,1);
inStdev = std(X); 
X = bsxfun(@rdivide,bsxfun(@minus,X,inMean),inStdev); % normalized  n*2d

% % Basis 1
% num_basis = 8*d + 1; %the number of the basis function
% basis_matrix = ones(n-n_prime,num_basis);
% 
% % choose polynomial as the basis function
% basis_matrix(:,2:(d+1)) = X(:,1:d);
% basis_matrix(:,(d+2):(2*d + 1)) = X(:,1:d).^2;
% basis_matrix(:,(2*d+2):(3*d+1)) = X(:,1:d).^3;
% basis_matrix(:,(3*d+2):(4*d + 1)) = X(:,1:d).^4;
% 
% basis_matrix(:,(4*d+2):(5*d+1)) = X(:,(d+1):2*d);
% basis_matrix(:,(5*d+2):(6*d + 1)) = X(:,(d+1):2*d).^2;
% basis_matrix(:,(6*d+2):(7*d+1)) = X(:,(d+1):2*d).^3;
% basis_matrix(:,(7*d+2):(8*d + 1)) = X(:,(d+1):2*d).^4;

% % Basis 2
% num_basis = 6*d + 1; %the number of the basis function
% basis_matrix = ones(10000,num_basis);
% 
% % choose polynomial as the basis function
% basis_matrix(:,2:(d+1)) = X(:,1:d);
% basis_matrix(:,(d+2):(2*d+1)) = X(:,1:d).^2;
% basis_matrix(:,(2*d+2):(3*d+1)) = X(:,1:d).^3;
% 
% basis_matrix(:,(3*d+2):(4*d+1)) = X(:,(d+1):2*d);
% basis_matrix(:,(4*d+2):(5*d+1)) = X(:,(d+1):2*d).^2;
% basis_matrix(:,(5*d+2):(6*d+1)) = X(:,(d+1):2*d).^3;

% Basis 3
num_basis = 10*d + 1; %the number of the basis function
basis_matrix = ones(10000,num_basis);

% choose polynomial as the basis function
basis_matrix(:,2:(d+1)) = X(:,1:d);
basis_matrix(:,(d+2):(2*d+1)) = X(:,1:d).^2;
basis_matrix(:,(2*d+2):(3*d+1)) = X(:,1:d).^3;
basis_matrix(:,(3*d+2):(4*d+1)) = X(:,1:d).^4;
basis_matrix(:,(4*d+2):(5*d+1)) = X(:,1:d).^5;

basis_matrix(:,(5*d+2):(6*d+1)) = max(X(:,1:d) - U,0);
basis_matrix(:,(6*d+2):(7*d+1)) = basis_matrix(:,(5*d+2):(6*d+1)).^2;
basis_matrix(:,(7*d+2):(8*d+1)) = basis_matrix(:,(5*d+2):(6*d+1)).^3;
basis_matrix(:,(8*d+2):(9*d+1)) = basis_matrix(:,(5*d+2):(6*d+1)).^4;
basis_matrix(:,(9*d+2):(10*d+1)) = basis_matrix(:,(5*d+2):(6*d+1)).^5;

% % Basis 4
% num_basis = 8*d + 1; %the number of the basis function
% basis_matrix = ones(10000,num_basis);
% 
% % choose polynomial as the basis function
% basis_matrix(:,2:(d+1)) = X(:,1:d);
% basis_matrix(:,(d+2):(2*d+1)) = X(:,1:d).^2;
% basis_matrix(:,(2*d+2):(3*d+1)) = X(:,1:d).^3;
% basis_matrix(:,(3*d+2):(4*d+1)) = X(:,1:d).^4;
% 
% basis_matrix(:,(4*d+2):(5*d+1)) = max(X(:,1:d) - U,0);
% basis_matrix(:,(5*d+2):(6*d+1)) = basis_matrix(:,(4*d+2):(5*d+1)).^2;
% basis_matrix(:,(6*d+2):(7*d+1)) = basis_matrix(:,(4*d+2):(5*d+1)).^3;
% basis_matrix(:,(7*d+2):(8*d+1)) = basis_matrix(:,(4*d+2):(5*d+1)).^4;


EstiLoss = basis_matrix*regression_coff;

EstiLoss_Prob = mean(EstiLoss > L0);
EstiLoss_Exce = mean(max(EstiLoss - L0,0));
EstiLoss_Qaud = mean(EstiLoss.^2);

y = [EstiLoss_Prob EstiLoss_Exce EstiLoss_Qaud];

