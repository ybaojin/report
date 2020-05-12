function  h=ETU_channel(Ts,fd)
x=ones(1,8000);
tau=[0 5e-8 12e-8 2e-7 23e-8 5e-7 16e-7 23e-7 5e-6];%the protocol of 3GPP 36.104
PdB=[-1 -1 -1 0 0 0 -3 -5 -7];
chan = rayleighchan(Ts, fd, tau, PdB);  % Create channel object
 h = filter(chan,x);  