I    = imread('image1.jpg');
Isp  = imread('image1_saltpepper.jpg');
Igau = imread('image1_gaussian.jpg');

images = [];

Ispbox3 = denoise(Isp , 'box', 3);
Ispbox5 = denoise(Isp , 'box', 5);
Ispbox7 = denoise(Isp , 'box', 7);

Igaubox3 = denoise(Igau , 'box', 3);
Igaubox5 = denoise(Igau , 'box', 5);
Igaubox7 = denoise(Igau , 'box', 7);

Ispmedian3 = denoise(Isp , 'median', 3,3);
Ispmedian5 = denoise(Isp , 'median', 5,5);
Ispmedian7 = denoise(Isp , 'median', 7,7);

Igaumedian3 = denoise(Igau , 'median', 3,3);
Igaumedian5 = denoise(Igau , 'median', 5,5);
Igaumedian7 = denoise(Igau , 'median', 7,7);

subplot(4,3,1), imshow(Ispbox3)
subplot(4,3,2), imshow(Ispbox5)
subplot(4,3,3), imshow(Ispbox7)

subplot(4,3,4), imshow(Igaubox3)
subplot(4,3,5), imshow(Igaubox5)
subplot(4,3,6), imshow(Igaubox7)

subplot(4,3,7), imshow(Ispmedian3)
subplot(4,3,8), imshow(Ispmedian5)
subplot(4,3,9), imshow(Ispmedian7)

subplot(4,3,10), imshow(Igaumedian3)
subplot(4,3,11), imshow(Igaumedian5)
subplot(4,3,12), imshow(Igaumedian7)

spbox3 = myPSNR(I, Ispbox3)
spbox5 = myPSNR(I, Ispbox5)
spbox7 = myPSNR(I, Ispbox7)

gaubox3 = myPSNR(I, Igaubox3)
gaubox5 = myPSNR(I, Igaubox5)
gaubox7 = myPSNR(I, Igaubox7)

spmedian3 = myPSNR(I, Ispmedian3)
spmedian5 = myPSNR(I, Ispmedian5)
spmedian7 = myPSNR(I, Ispmedian7)

gaumedian3 = myPSNR(I, Igaumedian3)
gaumedian5 = myPSNR(I, Igaumedian5)
gaumedian7 = myPSNR(I, Igaumedian7)


