I = imread('image1.jpg');
Isp = imread('image1_saltpepper.jpg');
Igau = imread('image1_gaussian.jpg');

SPpsnr = myPSNR(I, Isp)
GApsnr = myPSNR(I, Igau)
