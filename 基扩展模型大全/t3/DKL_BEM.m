function H_estimate=DKL_BEM(M,N,delta)

load('channel_data_90_10.mat');
N_end=2000;
fmax=250 ;
Ts=5*10^(-6);
tau=[0 3e-8 15e-8 31e-8 37e-8 71e-8 109e-8 173e-8 251e-8 ]/Ts;

for p=1:9
    number=p;
    for m=1:N
        for n=1:N
            D(m,n)=2*pi*abs(m-n)*fmax*Ts;
        end
    end
    C= besselj(0,D);
    [U,S,V]=svd(C);
    B2=U(:,1:(M+1));
    B1=B2(1:delta:N,:);
    [R,C]=size(B1);
    
    
    for t=1:N_end-N+1
        if(rem(t-1,N)==0)
            H1=(h(number,t:delta:t+N-1))';
            
            %% 基系数的计算
            b1=B1\H1;
            
            %% NMSE的计算
            
            H_estimate(p,t:t+N-1)=B2*b1;%为什么波形相似了，但是幅度不相等
        end
    end
    
end
end
