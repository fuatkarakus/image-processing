close all; clear all;

img   = imread('Lenna.png');
imagesc(img)
img   = fftshift(img(:,:,2));
F     = fft2(img);

figure;

imagesc(100*log(1+abs(fftshift(F)))); colormap(gray); 
title('magnitude spectrum');

figure;
imagesc(angle(F));  colormap(gray);
title('phase spectrum');