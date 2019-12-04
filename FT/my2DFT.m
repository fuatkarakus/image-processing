function F = my2DFT(f)

[M N]=size(f);

F= zeros(M,N);

for u = 0:M-1
    for v = 0:N-1
        for x = 0:M-1
            for y = 0:N-1
                F(u+1,v+1)=F(u+1,v+1)+f(x+1,y+1)*exp(-1i*2*pi*(x*u/M+y*v/N));
            end
        end
    end
end