%% ELEG4512 HW2
clear;
close all;
clc;

% input a gray-scale image ‘2.tif’
originalImage = im2double(imread('2.tif'));
[m, n]=size(originalImage);

%% Part I
% Add pepper noise to the image
tmp_mask = rand(m,n);
pepper_idx = find(tmp_mask <= 0.1);
pepperNoiseImage = originalImage;
pepperNoiseImage(pepper_idx) = 0;

% using 3x3 Contraharmonic Filter with parameter Q = 1.5
meanFilterImage = Contraharmonic_Filter(pepperNoiseImage, [3,3], 1.5);

% Apply order-statistics (median) filter to remove noise
orderStatisticsFilteredImage =  ordfilt2(pepperNoiseImage,5,ones(3,3), 'symmetric');

% Plot the images
figure;
subplot(2,2,1);imshow(originalImage);title('Original Image');
subplot(2,2,2);imshow(pepperNoiseImage);title('Pepper Noise Image');
subplot(2,2,3);imshow(meanFilterImage);title('Maen Filtered Image (1.5)');
subplot(2,2,4);imshow(orderStatisticsFilteredImage);title('Order-Statistics Filtered Image');



%% Part II
% Add motion and Gaussian noise to the image
noise_var=0.1;
PSF = fspecial('motion',10,45);                           
gb = imfilter(originalImage,PSF,'circular');                         
noise = imnoise(zeros(size(originalImage)),'gaussian',0,noise_var);      
motionGaussiannoiseImage = double(gb) + noise;

% Apply inverse filter to remove noise
inverseFilteredImage = deconvwnr(motionGaussiannoiseImage,PSF);   

% Apply wiener filters to remove noise
Sn = abs(fft(noise)).^2;
nA = sum(Sn(:))/numel(noise);
Sf = abs(fft2(originalImage)).^2;
fA = sum(Sf(:))/numel(originalImage);
R = nA/fA;
wienerFilteredImage = deconvwnr(motionGaussiannoiseImage,PSF,R);

estimated_NSR = noise_var / var(motionGaussiannoiseImage(:));

NCORR = fftshift(real(ifft2(Sn)));                       
ICORR = fftshift(real(ifft2(Sf)));  
wienerFilteredImage2 = deconvwnr(motionGaussiannoiseImage,PSF,estimated_NSR);

% Plot the images
figure;
subplot(2,2,1);imshow(originalImage);title('Original Image');
subplot(2,2,2);imshow(motionGaussiannoiseImage);title('Motion and Gaussian Noise Image');
subplot(2,2,3);imshow(inverseFilteredImage);title('Inverse Filtered Image');
subplot(2,2,4);imshow(wienerFilteredImage2);title('Wiener Filtered Image');

%% Part II (second trial)
% Simulate a Motion Blur?H(u,v)
T=1;a=0.02;b=0.02;
v=-m/2:m/2-1;u=v';
A=repmat(a.*u,1,m)+repmat(b.*v,m,1);
H=T/pi./A.*sin(pi.*A).*exp(-1i*pi.*A);
H(A==0)=T;% replace NAN

F=fftshift(fft2(originalImage));
FBlurred=F.*H;

noise_mean = 0;
noise_var = 1e-3;
noise=imnoise(zeros(m),'gaussian', noise_mean,noise_var);
FNoise=fftshift(fft2(noise));

% Get the Blurred_Noised Image
FBlurred_Noised=FNoise+FBlurred;

% Display the blurred_noised image
IBlurred_Noised=real(ifft2(ifftshift(FBlurred_Noised)));
motionGaussiannoiseImageV2 = uint8(255.*mat2gray(IBlurred_Noised));

% deblur with parametr bestRadius=30;
maxPSNR=0;
bestRadius=30;

% Displace the best Restoration
FDeblurred2=zeros(m);
for a=1:m
    for b=1:m
        if sqrt((a-m/2).^2+(b-m/2).^2)<bestRadius
            FDeblurred2(a,b)= FBlurred_Noised(a,b)./H(a,b);
        end
    end
end

FH2=abs(FDeblurred2);

IDeblurred2=real(ifft2(ifftshift(FDeblurred2)));
inverseFilteredImageV2 = uint8(255.*mat2gray(IDeblurred2));


noise_varV2=0.1;
PSFV2 = fspecial('motion',10,45);
estimated_NSRV2 = noise_varV2 / var(originalImage(:));
wienerFilteredImageV2 = deconvwnr(motionGaussiannoiseImageV2,PSFV2,estimated_NSRV2);

figure;
subplot(2,2,1);imshow(originalImage);title('Original Image');
subplot(2,2,2);imshow(motionGaussiannoiseImageV2);title('Motion and Gaussian Noise Image');
subplot(2,2,3);imshow(inverseFilteredImageV2);title('Restoration with Inverse filter (r=30)');
subplot(2,2,4);imshow(wienerFilteredImageV2);title('Wiener Filtered Image');