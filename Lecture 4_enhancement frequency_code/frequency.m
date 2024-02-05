[x,y]=meshgrid(-2:1/16:2,-2:1/16:2);
f=cos(2*pi*x+3*pi*y);
imagesc(f),colormap(gray);


figure;imshow(abs(fftshift(fft2(f))),[])