function p = RegEsti(X,Y) %X denotes the inner samples, Y denotes the outer samples and m denotes the sample size of inner samples
U = 120;

temp = size(X);
n = temp(1);
d = temp(2)/2;
clear temp

inMean = mean(X,1);
inStdev = std(X); 
X = bsxfun(@rdivide,bsxfun(@minus,X,inMean),inStdev); % normalized  n*2d

Y = mean(Y,2);

% % Basis 1
% num_basis = 8*d + 1; %the number of the basis function
% basis_matrix = ones(n,num_basis);
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
% basis_matrix = ones(n,num_basis);
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
basis_matrix = ones(n,num_basis);

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
% basis_matrix = ones(n,num_basis);
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



clear X


p = basis_matrix\Y;


