function Y = Two_level_EIG(Gamma)
boottime1 = 1000;
boottime2 = 1000;
J1 = 2;
J2 = 4;
m0 = 100;
n0 = 100;
Init_Sample = zeros(m0,n0);
X = rand(1,n0);
X = X.*2;

for i = 1:n0
    theta = normrnd(0,1,1,m0);
    for j = 1:m0
        Init_Sample(j,i) = sqrt(2/pi) * exp(-2*(X(i) - theta(j))^2);
    end
end

m = 40:12:100;
result_A = zeros(boottime1,1);
MeanBoot = zeros(length(m),1);
reduce_minus = zeros(J1,n0);
reduce_minus_2 = zeros(J2,n0);
for i = 1:length(m)
    for j = 1:boottime1
        outboot = [1:1:n0]; %1-by-n0
        inboot = randi(m0,m(i),n0);%m(i)-by-n0
        a1 = repmat(outboot,size(inboot,1),1);%m(i)-by-n0
        index = sub2ind(size(Init_Sample),inboot,a1);
        reduce = Init_Sample(index);
        reduce_1 = reduce(1:m(i)/J1,:);
        reduce_2 = reduce(m(i)/J1 + 1:m(i),:);
        reduce_minus(1,:) = mean(reduce_2,1);
        reduce_minus(2,:) = mean(reduce_1,1);
        Reduce_minus = log(reduce_minus);
        resboot = J1*(log(mean(reduce,1))) - (J1-1)*mean(Reduce_minus,1);
        
        reduce_1_2 = reduce(1:3*m(i)/J2,:);
        reduce_2_2 = reduce;
        reduce_2_2(2*m(i)/J2+1:3*m(i)/J2,:) = [];
        reduce_3_2 = reduce;
        reduce_3_2(m(i)/J2+1:2*m(i)/J2,:) = [];
        reduce_4_2 = reduce(m(i)/J2 +1:4*m(i)/J2,:);
        reduce_minus_2(1,:) = mean(reduce_1_2,1);
        reduce_minus_2(2,:) = mean(reduce_2_2,1);
        reduce_minus_2(3,:) = mean(reduce_3_2,1);
        reduce_minus_2(4,:) = mean(reduce_4_2,1);
        Reduce_minus_2 = log(reduce_minus_2);
        resboot_2 = J2*(log(mean(reduce,1))) - (J2-1)*mean(Reduce_minus_2,1);
        
        result_A(j) = mean(3*resboot_2 - 2*resboot);
    end
    MeanBoot(i) = mean(result_A);
end
Bias = [ones(1,length(m));1./(m.^3)]'\MeanBoot;
A = Bias(2);

% Estimate B
n = 50:10:100;
result_B = zeros(boottime2,1);
VarBoot = zeros(length(n),1);
for i = 1:length(n)
    reduce_minus = zeros(J1,n(i));
    reduce_minus_2 = zeros(J2,n(i));
    for j = 1:boottime2
        outboot = randi(n0,1,n(i)); %1-by-n(i)
        inboot = repmat([1:1:m0]',1,n(i));%m0-by-n(i)
        a1 = repmat(outboot,size(inboot,1),1);%m0-by-n(i)
        index = sub2ind(size(Init_Sample),inboot,a1);
        reduce = Init_Sample(index);
        reduce_1 = reduce(1:m0/J1,:);
        reduce_2 = reduce(m0/J1 + 1:m0,:);
        reduce_minus(1,:) = mean(reduce_2,1);
        reduce_minus(2,:) = mean(reduce_1,1);
        Reduce_minus = log(reduce_minus);
        resboot = J1*(log(mean(reduce,1))) - (J1-1)*mean(Reduce_minus,1);
        
        reduce_1_2 = reduce(1:3*m0/J2,:);
        reduce_2_2 = reduce;
        reduce_2_2(2*m0/J2+1:3*m0/J2,:) = [];
        reduce_3_2 = reduce;
        reduce_3_2(m0/J2+1:2*m0/J2,:) = [];
        reduce_4_2 = reduce(m0/J2 +1:4*m0/J2,:);
        reduce_minus_2(1,:) = mean(reduce_1_2,1);
        reduce_minus_2(2,:) = mean(reduce_2_2,1);
        reduce_minus_2(3,:) = mean(reduce_3_2,1);
        reduce_minus_2(4,:) = mean(reduce_4_2,1);
        Reduce_minus_2 = log(reduce_minus_2);
        resboot_2 = J2*(log(mean(reduce,1))) - (J2-1)*mean(Reduce_minus_2,1);
        
        result_B(j) = mean(3*resboot_2 - 2*resboot);
    end
    VarBoot(i) = var(result_B,1);
end
B = 1./n'\VarBoot;

c = B/(6*A^2);
M = round((Gamma/c)^(1/7));
N = round(Gamma/M);
M = (fix(M/J2)+1)*J2;

X = rand(1,N);
X = X.*2;

X_Sample = zeros(M,N);
for j = 1:N
    theta = normrnd(0,1,1,M);
    for k = 1:M
        X_Sample(k,j) = sqrt(2/pi) * exp(-2*(X(j) - theta(k))^2);
    end
end

Jack_1 = X_Sample(1:M/2,:);
Jack_2 = X_Sample(M/2+1:M,:);
Jack = zeros(J1,N);
Jack(1,:) = mean(Jack_2,1);
Jack(2,:) = mean(Jack_1,1);
% Rename
Jack_logical = log(Jack);
alpha = J1*(log(mean(X_Sample,1))) - (J1-1)*mean(Jack_logical,1);


Jack_1 = X_Sample(1:3*M/4,:);
Jack_2 = X_Sample;
Jack_2(2*M/4+1:3*M/4,:) = [];
Jack_3 = X_Sample;
Jack_3(M/4+1:2*M/4,:) = [];
Jack_4 = X_Sample(M/4+1:M,:);
Jack = zeros(J2,N);
Jack(1,:) = mean(Jack_1,1);
Jack(2,:) = mean(Jack_2,1);
Jack(3,:) = mean(Jack_3,1);
Jack(4,:) = mean(Jack_4,1);
% Rename
Jack_logical = log(Jack);
beta = J2*(log(mean(X_Sample,1))) - (J2-1)*mean(Jack_logical,1);
y = mean(3*beta - 2*alpha);
Y = [y,M,N];
