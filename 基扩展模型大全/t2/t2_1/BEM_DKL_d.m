clear all
clc
%% 参数设定
K1=load('channel_data_90_10.mat');
K2=load('channel_data_180_10.mat');
K3=load('channel_data_270_10.mat');
K4=load('channel_data_450_10.mat');
K=[K1 K2 K3 K4];

M=9;
N_end=8000;
number=1;
N=200;
fmax=[250 500 750 1250];
Ts=5*10^(-6);
delta_length=10;
MEAN_NMSE_D=zeros(4,delta_length);

for k=1:4
      h=K(1,k).h;
    if(k==2||k==3)
        h=h(:,1:8000);
    end
    %% 构建基函数
    for delta=1:delta_length
        for p=1:9
            number=p;
            for m=1:N
                for n=1:N
                    D(m,n)=2*pi*abs(m-n)*fmax(1,k)*Ts;
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
                    %%
                    %         for m=1:M
                    %             for n=1:N
                    %                 B(m,n)=exp((2*pi*j*(m-0.5*M)*(t+n))/(N_end));
                    %             end
                    %         end
                    %         B=B';
                    %         [R,C]=size(B);
                    
                    
                    %% 基系数的计算
                    b1=B1\H1;
                    if(rank(H1')==R)
                        b1=inv(B1)*H1;
                    end
                    
                    %% NMSE的计算
                    
                    H_estimate(1,t:t+N-1)=B2*b1;%为什么波形相似了，但是幅度不相等
                end
            end
            H_e=abs(h(number,:))-abs(H_estimate);
            % NMSE= sum(abs((h(number,:)-H_estimate)).^2)/sum(abs(h(number,:)).^2);
            nmse= sum((H_e).^2)/sum(abs(h(number,:)).^2);
            NMSE(1,p)=nmse;
        end
        MEAN_NMSE=mean(NMSE);
        MEAN_NMSE_D(k,delta)=MEAN_NMSE;
    end
end
%% 画图
hold on
plot(MEAN_NMSE_D(1,:),'r');
plot(MEAN_NMSE_D(2,:),'k');
plot(MEAN_NMSE_D(3,:),'g');
plot(MEAN_NMSE_D(4,:),'b');
hold off

% figure;
% plot(abs(H_estimate))
% figure;
% % plot(abs(H1))
% plot(abs(h(number,:)));
% figure;
% plot(MEAN_NMSE)
