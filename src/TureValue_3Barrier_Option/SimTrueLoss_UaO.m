function y = SimTrueLoss_UaO(n,d,V0)
global   r  K tau T h mu S0 N sigma U

CorMatrix = 0.3*ones(d,d)+0.7*diag(ones(1,d));
%CorMatrix = 0*ones(d,d) + 1*diag(ones(1,d));
temp = chol(CorMatrix);
CorL = temp'; %%-- A lower triangular matrix
clear temp


%===========================Compute V0 ================================

TrueLoss = V0;

NormRand = normrnd(0,1,d,n,N);
SamplePath = zeros(d,n,12);
RandUnif = rand(d,n,12);

SamplePath(:,:,1) = S0*exp((mu-sigma^2/2)*h*ones(d,n) + sigma*sqrt(h)*CorL*NormRand(:,:,1));  %%d-by-n-by-1
for k = 1:12-1
    SamplePath(:,:,k+1) = SamplePath(:,:,k).*exp((mu-sigma^2/2)*h*ones(d,n) + sigma*sqrt(h)*CorL*NormRand(:,:,k+1));  %%d-by-n-by-1
end

SampleMax = zeros(d,n,12);

SampleMax(:,:,1) = exp((log(S0*SamplePath(:,:,1)) + sqrt(power(log(SamplePath(:,:,1)/S0),2) - 2*sigma^2*h*log(RandUnif(:,:,1))))/2);

for k = 1:12-1
    SampleMax(:,:,k+1) = exp((log(SamplePath(:,:,k).*SamplePath(:,:,k+1)) + sqrt(power(log(SamplePath(:,:,k+1)./SamplePath(:,:,k)),2) - 2*sigma^2*h*log(RandUnif(:,:,k+1))))/2);
end

MaxPre = max(max(SampleMax(:,:,1:12),[],3),max(SamplePath(:,:,1:12),[],3));
clear RandUnif

for k = 1:d
    for w = 1:3
        TrueLoss = TrueLoss - BarrierUpOutCallBS(SamplePath(k,:,end),K(w),sigma,T-tau,U,r).*(MaxPre(k,:)<=U);
    end
end
y = TrueLoss;
