%% 参数设定
load('channel_data_90_10.mat');
k=2;
M = 10;
N=100;
delta=10;
Ts=5*10^(-6);
L=9;
p=0;
%% 信号输入
x = randint(7964,1);
qam_x = modulate(modem.qammod('M',16,'InputType','Bit'),x);
len=length(qam_x);
snr = 0:1:40;
for n=1:length(snr)
    y2=zeros(len,1);
    y3=zeros(len,1);
    
    y1=[zeros(L,1);qam_x];
    EbNo(n)= snr(n)-10*log10(k);
    H_estimate=DKL_BEM(M,N,delta);
    
    for t=(L+1):(len+L)
        for l=1:L
            p=p+H_estimate(l,t)*y1(t-l);
        end
        y2(t-L)=p;
    end
    
     for t=(L+1):(len+L)
        for l=1:L
            p=p+h(l,t)*y1(t-l);
        end
        y3(t-L)=p;
    end

    y2_n = awgn(y2,snr(n),'measured');
    y3_n = awgn(y3,snr(n),'measured');
    z2 = demodulate(modem.qamdemod('M',16,'OutputType','Bit'),y2_n);
    z3 = demodulate(modem.qamdemod('M',16,'OutputType','Bit'),y3_n);
    [nErrors2(n), BITBER2(n)] = biterr(x,z2);
    [nErrors3(n), BITBER3(n)] = biterr(x,z2);
    theo_err_prb(n)=(1/k)*3/2*erfc(sqrt(k*0.1*(10.^(EbNo(n)/10))));
end
% disp (nErrors2);
disp (BITBER2);
disp (BITBER3);
semilogy(snr,BITBER2,'r*',snr,BITBER3,'b-');
title('误比特率性能');
xlabel('SNR(dB)');
ylabel('误比特率');
legend('DKL\_BEM模型','实际信道');
% h = scatterplot(ynoisy(1:1*5e3),1,0,'g.');
% hold on;
% scatterplot(y(1:1*5e3),1,0,'r*',h);
% title('Received Signal');
% legend('接收信号','星座点');
% axis([-5 5 -5 5]);
% hold off;
