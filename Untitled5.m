clear
f = im2double(rgb2gray(imread('Lenna.png')));
f = imresize(f,0.1);
F = fft2(f);
F1 = my2DFT(f);
imshow([F F1]);