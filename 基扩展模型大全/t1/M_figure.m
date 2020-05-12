clear all
close all
clc 

load 'BEM_M.mat'

hold on
plot(MEAN_NMSE(1,:),'b¡£-');
plot(MEAN_NMSE(2,:),'k>-');
plot(MEAN_NMSE(3,:),'g<-');
hold off
