n=1;
D0=50; % change the name for d0, d is usuaally the (u²+v²)⁽1/2)

A=1.5; % normally the amplitude is 1

im=imread('lena.png');

[M,N]=size(im); % is easy to get the h and w like this

% compute the 2d fourier transform in order to multiply

F=fft2(double(im));

% compute your filter and do the meshgrid for your matrix but it is M*n, and get only the real part

u=0:(M-1);
v=0:(N-1);

idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>N/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H =A * (1./(1 + (D0./D).^(2*n)));

% multiply element by element

G=H.*F;
g=real(ifft2(double(G)));
subplot(1,2,1); imshow(im); title('Input image');
subplot(1,2,2); imshow(g,[ ]); title('filtered image');