%Read in images, convert sphere images to grayscale voor LK algorithm
sphere1 = imread('sphere1.ppm');
sphere2 = imread('sphere2.ppm');

sphere1gr = rgb2gray(sphere1);
sphere2gr = rgb2gray(sphere2);

synth1 = imread('synth1.pgm');
synth2 = imread('synth2.pgm');

%Region size paramter
region = 5;

%Use LK algorithm on sphere image
V1  = LK(sphere1gr,sphere2gr,region);
visualize(sphere1, V1, region);

%Use LK algoritm on synth image
V2  = LK(synth1,synth2,region);
visualize(synth1, V2, region);

%Function to visualize sections arrow on images
function [] = visualize(im, V, regionsize)

    middle = 1+ ((regionsize - mod(regionsize,2)) / 2);

    xcoordinates = middle:regionsize:size(im,1)-1; 
    ycoordinates = middle:regionsize:size(im,1)-1;
    
    [x,y] = meshgrid(xcoordinates,ycoordinates);
    
    RI = imref2d(size(im));
    RI.XWorldLimits = [0 size(im,1)]; RI.YWorldLimits = [0 size(im,2)];
    figure; imshow(im,RI); hold on; quiver(x,y,V(:,:,1),V(:,:,2));
    
    
    saveas(gcf,'sphere5.png')
end
