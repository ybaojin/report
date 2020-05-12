function  h=EPA_channel(Ts,fd)
x=ones(1,8000);
tau=[0 3e-8 7e-8 9e-8 11e-8 19e-8 41e-8 ];%the protocol of 3GPP 36.104
PdB=[0 -1 -2 -3 -8 -17.2 -20.8];
chan = rayleighchan(Ts, fd, tau, PdB);  % Create channel object
 h = filter(chan,x);  