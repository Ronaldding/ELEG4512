%% spatial resolution
clear
close all
clc
I1=imread('lena.jpg');
I2=I1(1:2:end,1:2:end);
I3=I1(1:4:end,1:4:end);
I4=I1(1:8:end,1:8:end);
I5=I1(1:16:end,1:16:end);
I6=I1(1:32:end,1:32:end);

figure;
subplot(2,3,1);imshow(I1);
subplot(2,3,2);imshow(I2);
subplot(2,3,3);imshow(I3);
subplot(2,3,4);imshow(I4);
subplot(2,3,5);imshow(I5);
subplot(2,3,6);imshow(I6);


%% intensitiy resolution

I1=imread('lena.jpg');

I128=histeq(I1,128);
I64=histeq(I1,64);
I32=histeq(I1,32);
I16=histeq(I1,16);
I8=histeq(I1,8);
I4=histeq(I1,4);
I2=histeq(I1,2);

figure;
subplot(2,3,1),imshow(I64),title('64 levels');
subplot(2,3,2),imshow(I32),title('32 levels');
subplot(2,3,3),imshow(I16),title('16 levels');
subplot(2,3,4),imshow(I8),title('8 levels');
subplot(2,3,5),imshow(I4),title('4 levels');
subplot(2,3,6),imshow(I2),title('2 levels');


%% Interpolation for block images
clc;
clear;
A = rand([10,10]) .* 255;

A_nearest=imresize(A,[512,512],'nearest');
A_bilinear=imresize(A,[512,512],'bilinear');
A_bicubic=imresize(A,[512,512],'bicubic');

figure; imagesc(A); colorbar; title('original');
figure;imagesc(A_nearest);colorbar;title('nearest');
figure;imagesc(A_bilinear);colorbar;title('bilinear');
figure;imagesc(A_bicubic);colorbar;title('bicubic');


%% Interpolation for block imagesimage example
clc;
clear;
A_ori = imread('lena.jpg');
A = imresize(A_ori,[64,64]);

A_nearest=imresize(A,[512,512],'nearest');
A_bilinear=imresize(A,[512,512],'bilinear');
A_bicubic=imresize(A,[512,512],'bicubic');

figure;
subplot(2,2,1); imshow(A);title('original');
subplot(2,2,2); imshow(A_nearest);title('nearest');
subplot(2,2,3); imshow(A_bilinear);title('bilinear');
subplot(2,2,4); imshow(A_bicubic);title('bicubic');

