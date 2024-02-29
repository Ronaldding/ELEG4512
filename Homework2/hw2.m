%% ELEG4512 HW2
clear
close all
clc
hw1a=imread('hw1.tif');
hw1a = im2double(hw1a);

% Creating laplacian Filter
laplacianFilter = fspecial('laplacian',0);

hw1b = imfilter(hw1a, laplacianFilter);
hw1c = imsubtract(hw1a,hw1b);

% Creating sobel Filter
sobelFilter = fspecial('sobel');
hw1d = imfilter(hw1a, sobelFilter);


% Creating avgerage Filter
fiveFiveAvgFilter = 1/ (5. ^2)*ones (5);
hw1e = imfilter(hw1d, fiveFiveAvgFilter); 

hw1f = hw1e .* hw1c;
hw1g = imadd(hw1f, hw1a);
hw1h = imadjust(hw1f,[],[], 0.2);

figure;
subplot(2,4,1);imshow(hw1a);title('(a): Original');
subplot(2,4,2);imshow(hw1b, []);title('(b): laplacian');
subplot(2,4,3);imshow(hw1c, []);title('(c): (a)-(b)');
subplot(2,4,4);imshow(hw1d);title('(d): sobel');
subplot(2,4,5);imshow(hw1e);title('(e): (d) with 5*5 avg filter');
subplot(2,4,6);imshow(hw1f);title('(f)');
subplot(2,4,7);imshow(hw1g);title('(g)');
subplot(2,4,8);imshow(hw1h, []);title('(h): (g) gamma=0.2');

