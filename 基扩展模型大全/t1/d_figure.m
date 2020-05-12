clear all
close all
clc 

load 'BEM_d.mat'

hold on
plot(MEAN_NMSE(1,:),'r');
plot(MEAN_NMSE(2,:),'k');
plot(MEAN_NMSE(3,:),'g');
hold off
