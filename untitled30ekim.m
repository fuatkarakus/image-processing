% derste yapilan
% I = rgb2gray(imread('lena.png'));
% h = [ 0 -1 0;
%     -1 4 -1;
%     0 -1 0];
% G = uint8(conv2(I, h, 'same'));
% Isharp = I + G;
% imshow([I Isharp]);

M = 200;
I = zeros(200);

for i = 20:50
    for j = 20:50
        if i == j
            I(i,j) = 1;
        end
    end
end

hs = zeros(180, 1000);

for i = 1:M
    for j = 1:M
        if I(i,j) == j
            for fi = 1:180
                fi_rad = fi*pi/180;
                r = i*cos(fi_rad)+sin(fi_rad);
                r = fix(r) + 1;
                hs(r, fi) = hs(r, fi) + 1;
            end
        end
    end
end




% found in web

% I = rgb2gray(imread('lena.png'));
% imshow(I);
% H = padarray(2,[2 2]) - fspecial('gaussian' ,[5 5],2);
% sharpened = imfilter(I,H);
% imshow([I sharpened]); 


% found in web

% clc;
% close all;
% a = im2double(imread('lena.png')); %// Read in your image
% lap = [-1 -1 -1; -1 8 -1; -1 -1 -1]; %// Change - Centre is now positive
% resp = imfilter(a, lap, 'conv'); %// Change
% 
% %// Change - Normalize the response image
% minR = min(resp(:));
% maxR = max(resp(:));
% resp = (resp - minR) / (maxR - minR);
% 
% %// Change - Adding to original image now
% sharpened = a + resp;
% 
% %// Change - Normalize the sharpened result
% minA = min(sharpened(:));
% maxA = max(sharpened(:));
% sharpened = (sharpened - minA) / (maxA - minA);
% 
% %// Change - Perform linear contrast enhancement
% sharpened = imadjust(sharpened, [60/255 200/255], [0 1]);
% 
% figure; 
% subplot(1,3,1);imshow(a); title('Original image');
% subplot(1,3,2);imshow(resp); title('Laplacian filtered image');
% subplot(1,3,3);imshow(sharpened); title('Sharpened image');
