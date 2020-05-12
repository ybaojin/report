clear all
clc

load('channel_data10.mat');
M=9;
N=30*(M+1);
N_end=20000;
number=1;
delta=20;

;%% ����������

for m=1:M
    for n=1:delta:N
        B(m,n)=exp((2*pi*j*(m-0.5*M)*n)/(N_end));
    end
    B1=B(:,1:delta:N);
   
    for n=1:N
        B2(m,n)=exp((2*pi*j*(m-0.5*M)*n)/(N_end));
    end
end

B1=B1';
[R,C]=size(B1);
% H1=(h(1,:))';

for t=1:N_end
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
        
        
        %% ��ϵ���ļ���
        b1=B1\H1;
        if(rank(H1')==R)
            b1=inv(B1)*H1
        end
        
        %% NMSE�ļ���
        
        H_estimate(1,t:t+N-1)=B2'*b1;%Ϊʲô���������ˣ����Ƿ��Ȳ����
    end
end
H_e=abs(h(number,:))-abs(H_estimate);
% NMSE= sum(abs((h(number,:)-H_estimate)).^2)/sum(abs(h(number,:)).^2);
NMSE= sum((H_e).^2)/sum(abs(h(number,:)).^2)

figure;
plot(abs(H_estimate))
figure;
% plot(abs(H1))
plot(abs(h(number,:)));
