function X_K = myDFT(x_n)

N = length(x_n);

X_K = zeros(1,N);

for k = 0:N-1
    for n = 0:N-1
        X_K(1,k+1)= X_K(1,k+1)+x_n(n+1)*exp(-2*1i*pi*n*k/N);
    end
end
