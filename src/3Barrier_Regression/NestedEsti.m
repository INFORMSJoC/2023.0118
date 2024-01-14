function y = NestedEsti(n,m,d,T,tau,sigma) % n-outer sample, m-inner sample

CorMatrix = 0.3*ones(d,d)+0.7*diag(ones(1,d));
temp = chol(CorMatrix);
CorL = temp'; %%-- A lower triangular matrix
clear temp

S0 = 100; %%--Initial value for all d underlying stocks
mu = 8/100;
r = 5/100;
N = 52;
h = T/N;
U = 120;
z = norminv(0.95,0,1); 
K = [90 100 110];

NormRand = normrnd(0,1,d,n,N);
SamplePath = zeros(d,n,N);
RandUnif = rand(d,n,12);

% Generate Sample path
SamplePath(:,:,1) = S0*exp((mu-sigma^2/2)*h*ones(d,n) + sigma*sqrt(h)*CorL*NormRand(:,:,1));  %%d-by-n-by-1
for k = 1:12-1
    SamplePath(:,:,k+1) = SamplePath(:,:,k).*exp((mu-sigma^2/2)*h*ones(d,n) + sigma*sqrt(h)*CorL*NormRand(:,:,k+1));  %%d-by-n-by-1
end

% max except for t1,...,t12
SampleMax = zeros(d,n,N);

SampleMax(:,:,1) = exp((log(S0*SamplePath(:,:,1)) + sqrt(power(log(SamplePath(:,:,1)/S0),2) - 2*sigma^2*h*log(RandUnif(:,:,1))))/2);
for k = 1:12-1
    SampleMax(:,:,k+1) = exp((log(SamplePath(:,:,k).*SamplePath(:,:,k+1)) + sqrt(power(log(SamplePath(:,:,k+1)./SamplePath(:,:,k)),2) - 2*sigma^2*h*log(RandUnif(:,:,k+1))))/2);
end

% max of $1 \leq v \leq t_tau$
MaxPre = max(max(SampleMax(:,:,1:12),[],3),max(SamplePath(:,:,1:12),[],3));
clear RandUnif

X = [SamplePath(:,:,12)' MaxPre']; % outer samples n-by-2d, columns 1-d represent samplepath, d+1-2d represent the max value

SampleUp = zeros(n,m);
for j = 1:m
    for k = 12:(N-1)
        SamplePath(:,:,k+1) = SamplePath(:,:,k).*exp((r-sigma^2/2)*h*ones(d,n) + sigma*sqrt(h)*CorL*normrnd(0,1,d,n));
    end
    RandUnif1 = rand(d,n,N);
    for k = 12:(N-1)
        SampleMax(:,:,k+1) = exp((log(SamplePath(:,:,k).*SamplePath(:,:,k+1)) + sqrt(power(log(SamplePath(:,:,k+1)./SamplePath(:,:,k)),2) - 2*sigma^2*h*log(RandUnif1(:,:,k+1))))/2);
    end
    MaxLat = max(max(SampleMax(:,:,12+1:N),[],3),max(SamplePath(:,:,12+1:N),[],3));
    for k = 1:d
        for w= 1:3
            SampleUp(:,j) = SampleUp(:,j) + (exp(-r*(T-tau))*max(SamplePath(k,:,N) - K(w)*ones(1,n),0).*(MaxLat(k,:)<=U).*(MaxPre(k,:)<=U))';
        end
    end
    clear RandUnif1
end
%clear SamplePath SampleMax MaxLat 

y = [X SampleUp]; % n-by-(2d+m)

