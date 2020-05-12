function  h=EVA_channel(Ts,fd)
x=ones(1,8000);
tau=[0 3e-8 15e-8 31e-8 37e-8 71e-8 109e-8 173e-8 251e-8 ];%the protocol of 3GPP 36.104
PdB=[0 -1.5 -1.4 -3.6 -0.6 -9.1 -7.0 -12.0 -16.9];
chan = rayleighchan(Ts, fd, tau, PdB);  % Create channel object
 h = filter(chan,x);  