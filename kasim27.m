I = im2double(rgb2gray(imread('lena.png')));

[M N] = size(I);

F = fft2(I);
F = fftshift(F);
imshow(abs(log(F)), []);

H = zeros(M, N);
D0 = 100;x
xc = M/2;
yc = N/2;
for i = 1:M
    for j = 1:N
        dist = sqrt(power( i-xc, 2 ) + power( j-yc, 2 ));
        if dist < D0
            H( i, j ) = i;
        end
    end
end

F = F.*H;

IF = ifftshift( F );
g = ifft2( IF );

imshow( g );

