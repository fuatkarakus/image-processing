I = im2double(rgb2gray(imread('lena.jpg')));

[M N] = size(I);


I1 = I(1:M/2,1:N/2);
I2 = I(1:M/2,N/2+1:N);
I3 = I(M/2+1:M,1:N/2);
I4 = I(M/2+1:M,N/2+1:N);

I43 = [I4 I3];
I21 = [I2 I1];
If = [I43; I21];
imshow([I If]);



%imshow(Is);