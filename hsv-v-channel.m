
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
rgbImage = imread('lena.png'); % read the image
[rows1, columns1, numberOfChannels1] = size(rgbImage);
subplot(2, 2, 1);
imshow(rgbImage);
title('RGB Image', 'FontSize', fontSize);
hsvImage=rgb2hsv(rgbImage);
[rows2, columns2, numberOfChannels2]=size(hsvImage)
subplot(2, 2, 2);
imshow(hsvImage)  % Convert the colour image to HSV
title('HSV image, coded as RGB (meaningless)', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
H = hsvImage(:,:,1);
S =hsvImage(:,:,2);
vc = hsvImage(:,:,3);
subplot(2, 2, 3);
imshow(vc)
title('V Channel', 'FontSize', fontSize);
subplot(2, 2, 4);
[COUNTS,f] = imhist(vc) 
bar(f,COUNTS);
grid on;
title('V Channel Histogram', 'FontSize', fontSize);
figure()
improvedHSVImage = cat(3, H, S, mat2gray(vc));
improvedRGBImage = hsv2rgb(improvedHSVImage);
imshow(improvedRGBImage)
title('Improved RGB Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);