function result = AdaptiveNonuniform(m0,n0,d,epoch,Budget,L0,T,tau,sigma)

CorMatrix = 0.3*ones(d,d)+0.7*diag(ones(1,d));
temp = chol(CorMatrix);
CorL = temp'; %%-- A lower triangular matrix
clear temp

S0 = 100; %%--Initial value for all d underlying stocks
mu = 8/100;
r = 5/100;
N = 52;
h = T/N;%%-- Delta t
U = 120; 
K = [90 100 110];
b = 5;

%=======================TRUE VALUE===============================
V0 = d*(BarrierUpOutCallBS(S0,K(1),sigma,T-tau,U,r)+ BarrierUpOutCallBS(S0,K(2),sigma,T-tau,U,r) + BarrierUpOutCallBS(S0,K(3),sigma,T-tau,U,r));

% set alpha_bar = TrueValue
alpha_bar = 0.1;

% generate initial samples n0*m0
temp = NestedEsti(n0,m0,d,T,tau,sigma); % n0-by-(m0+3d)
SamplePath_t = temp(:,1:d);% n0-by-d
SampleMax_t = temp(:,(d+1):2*d);% n0-by-d
MaxPre = temp(:,(2*d+1):3*d);% n0-by-d

SamplePath_t = SamplePath_t';
SampleMax_t = SampleMax_t';
MaxPre = MaxPre';

SampleUp = temp(:,(3*d+1):(m0+3*d)); % n0-by-m0
clear temp

% Using cells allows for better adaptive to the nonuniform scheme
SamplePath_t = num2cell(SamplePath_t',2); %n0-by-1 cell, every element represent a 1-by-d vector
SampleMax_t = num2cell(SampleMax_t',2);
MaxPre = num2cell(MaxPre',2);

n = n0;
M = zeros(1,n0);
for i = 1:n0
    M(i) = m0;
end

Y_Sample = cell(1,n);
for i = 1:n
    Y_Sample{1,i} = V0 - SampleUp(i,:);
end

iter = ceil(Budget/epoch);

for l = 1:iter
    %estimate sigma_i
    if l == 1
        L_hat = cellfun(@mean,Y_Sample); % mean of inner sample 1-by-n0
        sigma_tilde = cellfun(@std,Y_Sample); % std of inner sample 1-by-n0
        sigma_bar = mean(sigma_tilde);
        sigma_hat = (M./(M+b)).*sigma_tilde + (b./(M+b)).*sigma_bar; % estimate of sigma 1-by-n0
    end
   
    %estimate B_hat V_hat
    alpha_hat = mean(L_hat > L0);
    %alpha_bar = mean(normcdf((M.*(L_hat-L0))./sigma_hat));
    B_hat = alpha_hat - alpha_bar;
    V_hat = alpha_bar*(1-alpha_bar)/n;
    
    m_bar = mean(M);
    
    %determine n'
    n_prime = floor(min(max((V_hat*n*((m_bar*n + epoch)^4)/4/(B_hat^2)/(m_bar^4))^(1/5),n),n+epoch));  %epoch/m0
    
    %addition init operations
    M(n+1:n_prime) = zeros(1,n_prime - n);
    L_hat(n+1:n_prime) = zeros(1,n_prime - n);
    sigma_hat(n+1:n_prime) = ones(1,n_prime - n);
    Y_Sample(n+1:n_prime) = cell(1,n_prime-n);
    SamplePath_t(n+1:n_prime) = cell(n_prime-n,1);
    SampleMax_t(n+1:n_prime) = cell(n_prime-n,1);
    MaxPre(n+1:n_prime) = cell(n_prime-n,1);
    
    
    n = n_prime;

    while(sum(M) < m0*n0 + l*epoch) % Question: ensure M > 0
        if min(M) < m0
            [value,location] = min(M);
            i_star = location;
        else
            error_margin = M.*(abs(L_hat - L0))./sigma_hat;
            [value,location] = min(error_margin);
            i_star = location;
        end
        
        % M(i_star)==0, generate samples from the beginning
        if M(i_star) == 0
            NewSample = NestedEsti(1,1,d,T,tau,sigma);
            Y_Sample{i_star} = [Y_Sample{i_star},V0 - NewSample(1,3*d+1)];
            M(i_star) = M(i_star) + m0;
            %sigma_tilde(i_star) = std(Y_Sample{i_star});
            sigma_hat(i_star) = sigma_bar;
            L_hat(i_star) = mean(Y_Sample{i_star});
            SamplePath_t{i_star} = NewSample(1,1:d);
            SampleMax_t{i_star} = NewSample(1,(d+1):2*d);
            MaxPre{i_star} = NewSample(1,(2*d+1):3*d);

        % M(i_star) != 0, generate inner sample in the corresponding outer sample   
        else
            NewSample_inner = 0;
            SamplePath = zeros(d,N-11);
            SampleMax = zeros(d,N-11);
            SamplePath(:,1) = SamplePath_t{i_star}';
            SampleMax(:,1) = SampleMax_t{i_star}';
            for k = 1:(N-12)
                SamplePath(:,k+1) = SamplePath(:,k).*exp((r-sigma^2/2)*h*ones(d,1) + sigma*sqrt(h)*CorL*normrnd(0,1,d,1));
            end
            RandUnif1 = rand(d,N-11);
            for k = 1:(N-12)
                SampleMax(:,k+1) = exp((log(SamplePath(:,k).*SamplePath(:,k+1)) + sqrt(power(log(SamplePath(:,k+1)./SamplePath(:,k)),2) - 2*sigma^2*h*log(RandUnif1(:,k+1))))/2);
            end
            MaxLat = max(max(SampleMax(:,2:(N-11)),[],2),max(SamplePath(:,2:(N-11)),[],2));
            for k = 1:d
                for w= 1:3
                    NewSample_inner = NewSample_inner + exp(-r*(T-tau))*max(SamplePath(k,N-11) - K(w),0).*(MaxLat(k)<=U).*(MaxPre{i_star}(k)<=U);
                end
            end
            Y_Sample{1,i_star} = [Y_Sample{1,i_star},V0 - NewSample_inner];
            
            M(i_star) = M(i_star) + 1;
            L_hat(i_star) = mean(Y_Sample{i_star});
            sigma_tilde(i_star) = std(Y_Sample{i_star});
            sigma_hat(i_star) = (M(i_star)/(M(i_star)+b))*sigma_tilde(i_star) + ((b/(M(i_star)+b)))*sigma_bar;
        end
    end

end

result = [mean(L_hat > L0),n,mean(M)];



