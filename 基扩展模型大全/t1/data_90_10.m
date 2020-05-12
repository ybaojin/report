clc
clear all
close all
load 'channel_data10.mat'
data=h;
y=abs(fft(data(1,:)));
figure;
plot(y)
abs_data=abs(data(1,:));
figure;
plot(abs_data);
% subplot(512)
% plot(h(2,:))
% subplot(513)
% plot(h(3,:))
% subplot(514)
% plot(h(4,:))
% subplot(515)
% plot(h(5,:))