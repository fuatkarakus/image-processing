clear
f = im2double(rgb2gray(imread('foot.png')));


%f = imresize(f,0.2);
%F = my2DFT(f);
F =fft2(f);
F = fftshift(F); % Center FFT


imshow(log(abs(F)+1),[]); % Display the result