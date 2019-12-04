clear
I = rgb2gray(imread('lena.png'));
h = imhist(I);

mybcv = zeros(1,256);

for i = 1:256
    mybcv(i) = bcv(h,i);
end

[P_max,id_max]=max(mybcv);

[M N]= size (I);
for i = 1:M
    for j = 1:N
        if I(i,j) <id_max
            G(i,j) = 0;
        else
            G(i,j) = 255;
        end
    end
end

imshow([I G]);
