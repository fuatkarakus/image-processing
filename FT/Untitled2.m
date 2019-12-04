Fs = 2048;
N=500;
x= cos(2*pi*200*(0:1:N-1)/Fs);
x = x+4*cos(2*pi*400*(0:1:N-1)/Fs);
plot(x)
pause
X_K =myDFT(x);
f=((0:N-1)/N)*Fs;
stem(f,X_K)
