clear all
close all
clc

load('channel_data10.mat');

M=9;
N_end=20000;
delta=50;
fmax=500;
Ts=5*10^(-6);
N_buffer=(1:30)*(M+1);


    %% 构建基函数
for kk=1:30;
    N=kk*(M+1);
    for p=1:9
        number=p;
             D=zeros(N,N);
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
%                     if(rank(H1')==R)
%                         b1=inv(B1)*H1;
%                     end
                    
                    %% NMSE的计算
                    
                    H_estimate(1,t:t+N-1)=B2*b1;
                end
            end
            H_e=abs(h(number,:))-abs(H_estimate);
            % NMSE= sum(abs((h(number,:)-H_estimate)).^2)/sum(abs(h(number,:)).^2);
            nmse= sum((H_e).^2)/sum(abs(h(number,:)).^2);
            NMSE(1,p)=nmse;
        end
        MEAN_NMSE=mean(NMSE);
        MEAN_NMSE_N(1,kk)=MEAN_NMSE;
    end
%% 画图
figure
plot(N_buffer,MEAN_NMSE_N);

