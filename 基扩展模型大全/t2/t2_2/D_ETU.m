clear all
close all
clc

load 'D_ETU.mat';
hold on
plot(MEAN_NMSE_D(1,:),'r');
plot(MEAN_NMSE_D(2,:),'k');
plot(MEAN_NMSE_D(3,:),'g');
plot(MEAN_NMSE_D(4,:),'b');
hold off
