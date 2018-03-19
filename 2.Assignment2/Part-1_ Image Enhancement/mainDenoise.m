%Read in 3 images
I    = imread('image1.jpg');
Isp  = imread('image1_saltpepper.jpg');
Igau = imread('image1_gaussian.jpg');

%Salt and pepper denoise with box filter
Ispbox3 = denoise(Isp , 'box', 3);
Ispbox5 = denoise(Isp , 'box', 5);
Ispbox7 = denoise(Isp , 'box', 7);

%Gaussian image denoise with box filter
Igaubox3 = denoise(Igau , 'box', 3);
Igaubox5 = denoise(Igau , 'box', 5);
Igaubox7 = denoise(Igau , 'box', 7);

%Salt and pepper image denoise with median filter
Ispmedian3 = denoise(Isp , 'median', 3,3);
Ispmedian5 = denoise(Isp , 'median', 5,5);
Ispmedian7 = denoise(Isp , 'median', 7,7);

%Gaussian image denoise with median filter
Igaumedian3 = denoise(Igau , 'median', 3,3);
Igaumedian5 = denoise(Igau , 'median', 5,5);
Igaumedian7 = denoise(Igau , 'median', 7,7);

%Gaussian images denoise with gaussian filter
Igauss2d0 = denoise(Igau , 'gaussian', 0.25, 3);
Igauss2d1 = denoise(Igau , 'gaussian', 0.5, 3);
Igauss2d2 = denoise(Igau , 'gaussian', 1, 3);
Igauss2d3 = denoise(Igau , 'gaussian', 2, 3);
Igauss2d4 = denoise(Igau , 'gaussian', 3, 3);

%Plot box filter images
subplot(1,3,1), imshow(Ispbox3)
title('S&P box 3x3')
subplot(1,3,2), imshow(Ispbox5)
title('S&P box 5x5')
subplot(1,3,3), imshow(Ispbox7)
title('S&P box 7x7')
saveas(gcf,'filters1.png')

subplot(1,3,1), imshow(Igaubox3)
title('Gauss box 3x3')
subplot(1,3,2), imshow(Igaubox5)
title('Gauss box 5x5')
subplot(1,3,3), imshow(Igaubox7)
title('Gauss box 7x7')
saveas(gcf,'filters2.png')

%Plot median filter images
subplot(1,3,1), imshow(Ispmedian3)
title('S&P median 3x3')
subplot(1,3,2), imshow(Ispmedian5)
title('S&P median 5x5')
subplot(1,3,3), imshow(Ispmedian7)
title('S&P median 7x7')
saveas(gcf,'filters3.png')

subplot(1,3,1), imshow(Igaumedian3)
title('Gauss median 3x3')
subplot(1,3,2), imshow(Igaumedian5)
title('Gauss median 5x5')
subplot(1,3,3), imshow(Igaumedian7)
title('Gauss median 7x7')

saveas(gcf,'filters4.png')

subplot(1,3,1), imshow(Igauss2d1)
title('Gauss gaussian2d 0.5')
subplot(1,3,2), imshow(Igauss2d2)
title('Gauss gaussian2d 1')
subplot(1,3,3), imshow(Igauss2d3)
title('Gauss gaussian2d 2')

saveas(gcf,'filters5.png')

%PSNR of box filter images
spbox3 = myPSNR(I, Ispbox3)
spbox5 = myPSNR(I, Ispbox5)
spbox7 = myPSNR(I, Ispbox7)
gaubox3 = myPSNR(I, Igaubox3)
gaubox5 = myPSNR(I, Igaubox5)
gaubox7 = myPSNR(I, Igaubox7)

%PSNR of median filter images
spmedian3 = myPSNR(I, Ispmedian3)
spmedian5 = myPSNR(I, Ispmedian5)
spmedian7 = myPSNR(I, Ispmedian7)
gaumedian3 = myPSNR(I, Igaumedian3)
gaumedian5 = myPSNR(I, Igaumedian5)
gaumedian7 = myPSNR(I, Igaumedian7)

%PSNR of gaussian filter images
gaugauss0 = myPSNR(I, Igauss2d0)
gaugauss1 = myPSNR(I, Igauss2d1)
gaugauss2 = myPSNR(I, Igauss2d2)
gaugauss3 = myPSNR(I, Igauss2d3)
gaugauss4 = myPSNR(I, Igauss2d4)




