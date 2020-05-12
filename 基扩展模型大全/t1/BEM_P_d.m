clear all
clc

load('channel_data10.mat');
M=9;
N=50*(M+1);
N_end=20000;
number=1;
delta=10;
%% 构建基函数
% for m=1:M
%     for n=1:N
%         B(m,n)=(n-N/2)^m;
%     end
% end
% B=B';
% [R,C]=size(B);
% H1=(h(1,:))';
for delta=1:50
for p=1:9
    number=p;
for t=1:N_end-N+1
    if(rem(t-1,N)==0)
        H1=(h(number,t:delta:t+N-1))';
        %%
        for m=1:M
            for n=1:delta:N
                B(m,n)=(n-(N+t-1)/2)^m;
            end
            
            B1=B(:,1:delta:N);
            for n=1:N
                 B2(m,n)=(n-(N+t-1)/2)^m;
            end
        end
        B1=B1';
        [R,C]=size(B1);
        
        
        %% 基系数的计算
        b1=B1\H1;
%         if(rank(H1')==R)
%             b1=inv(H1)*B
%             b1=inv(B)*H1
%         end
        
        %% NMSE的计算
        
        H_estimate(1,t:t+N-1)=B2'*b1;
    end
end

kk=nansum((abs(h(number,:))-abs(H_estimate)).^2);
yy=sum(abs(h(number,:)).^2);
nmse= kk/yy;
NMSE(1,p)=nmse;
end
mean_NMSE=mean(NMSE);
MEAN_NMSE(1,delta)=mean_NMSE;
end
% figure;
% plot(abs(H_estimate));
% figure;
% plot(abs(h(number,:)));
figure;
plot(MEAN_NMSE);