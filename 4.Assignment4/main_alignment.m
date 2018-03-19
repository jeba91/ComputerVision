%images
boat1 = imread('boat1.pgm');
boat2 = imread('boat2.pgm');
left  = imread('left.jpg');
right = imread('right.jpg');

%parameters
iterations = 50000;
threshold = 10;

%Perform RANSAC on both image pairs
[m1, t1] = RANSAC(boat1, boat2, 5000, 10, 50);
[m2, t2] = RANSAC(left, right, 50000, 10, 25);

%Create affine transformation of images
boat2aff = affine(boat2, m1);
boat1aff = affine(boat1, m1');

%show image with own affine transformation
figure
imshowpair(boat1,boat2aff, 'montage')
saveas(gcf,'boat1boat2own.png')

figure
imshowpair(boat2,boat1aff, 'montage')
saveas(gcf,'boat2boat1own.png')

%Fill in transformation parameters for affine2D
A1 = matrix(m1,t1);
A2 = matrix(m2,t2);

%transform from boat1 to boat2 and from boat2 to boat1 (invert used)
T1 = affine2d(A1);
T1i = invert(T1);
boat1a = imwarp(boat1,T1);
boat2a = imwarp(boat2,T1i);

%show image with matlab affine transformation of boat1 and boat2
figure
imshowpair(boat2,boat1a, 'montage')
saveas(gcf,'boat2boat1mat.png')

figure
imshowpair(boat1,boat2a, 'montage')
saveas(gcf,'boat1boat2mat.png')

%transform from left to right and from right to left (invert used)
T2 = affine2d(A2);
T2i = invert(T2);
lefta = imwarp(left,T2);
righta = imwarp(right,T2i);

figure
imshowpair(left,righta, 'montage')

imstitch = stitch(left,righta,t2);
imshow(imstitch)

figure
imshowpair(left,righta, 'montage')
figure
imshowpair(lefta,right, 'montage')


%run('C:\Program Files\MATLAB\R2017b\src\vlfeat/toolbox/vl_setup')





