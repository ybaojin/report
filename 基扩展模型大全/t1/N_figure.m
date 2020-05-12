clear all
close all
clc 

load 'BEM_N.mat'
M=10;
N_buffer=(1:50)*M;
hold on
plot(N_buffer,MEAN_NMSE(1,:),'r');
plot(N_buffer,MEAN_NMSE(2,:),'k');
plot(N_buffer,MEAN_NMSE(3,:),'g');
hold off