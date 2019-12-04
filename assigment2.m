rgbImage = imread('lena.png');
kernel = fspecial('gaussian', [7 7], 1.6);
blurredImage = imfilter(rgbImage, kernel);
downSample = imresize(blurredImage, 1/3); % downSample by factor of 3 
imshow(downSample);
