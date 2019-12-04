Fs = 2048;
N=32;
x = cos(2*pi*128*(0:1:N-1)/Fs);

plot(x)

X_K = Untitled(x);
f = ((0:N-1)/N*Fs);
stem(X_K)