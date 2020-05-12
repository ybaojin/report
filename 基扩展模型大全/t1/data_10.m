 

h2=reshape(h',180000,1);
 h3=reshape(h,180000,1);
plot(abs(h2));
figure;
%  plot(abs(h3));
x=autocorr(h2);
plot(abs(x));
