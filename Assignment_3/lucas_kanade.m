
sphere1 = imread('sphere1.ppm');
sphere2 = imread('sphere2.ppm');

sphere1gr = rgb2gray(sphere1);
sphere2gr = rgb2gray(sphere2);

synth1 = imread('synth1.pgm');
synth2 = imread('synth2.pgm');

imshow(synth1)

region = 15;

V1  = LK(sphere1gr,sphere2gr,region);
visualize(sphere1, V1, region);

V2  = LK(synth1,synth2,region);
visualize(synth1, V2, region);

function [V] = LK(im1, im2, regionsize)
    im1 = (im2double(im1));
    im2 = (im2double(im2));
    
    if mod(size(im1,1),regionsize) ~= 0
        'hal'
        end_m = (size(im1,1) - mod(size(im1,1),regionsize)) - regionsize+1;
        end_n = (size(im1,2) - mod(size(im1,2),regionsize)) - regionsize+1;
    else
        end_m = size(im1,1)-(regionsize+2)
        end_n = size(im1,2)-(regionsize+2)
    end

    [Gx, Gy] = gradient(fspecial('gaussian', 15, 1));
    Ix = conv2(im1, Gx, 'same');
    Iy = conv2(im1, Gy, 'same');
    It = im2 - im1;
    
    gridsize = (size(im1,1) - mod(size(im1,1),regionsize)) / regionsize;
    
    V=zeros(gridsize,gridsize,2);
    A=zeros((regionsize^2),2);
    b=zeros((regionsize^2),1);

    for m = 1:regionsize:end_m
        for n = 1:regionsize:end_n
            counter = 1;
            for i = m:(m+regionsize)
                for j = n:(n+regionsize)
                    A(counter,1) = Ix(i,j);
                    A(counter,2) = Iy(i,j); 
                    b(counter,1) = -It(i,j);
                    counter = counter + 1;
                end
            end
            C = (inv(transpose(A)*A))*(transpose(A)*b);
            x = uint8((m-1)/regionsize)+1;
            y = uint8((n-1)/regionsize)+1;
            V(x,y,1) = C(1,:);
            V(x,y,2) = C(2,:);
        end
    end
end

function [] = visualize(im, V, regionsize)
    
    middle = 1+ ((regionsize - mod(regionsize,2)) / 2);

    
    xcoordinates = middle:regionsize:size(im,1)-1; 
    ycoordinates = middle:regionsize:size(im,1)-1;
    
    [x,y] = meshgrid(xcoordinates,ycoordinates);
    
    RI = imref2d(size(im));
    RI.XWorldLimits = [0 size(im,1)]; RI.YWorldLimits = [0 size(im,2)];
    figure; imshow(im,RI); hold on; quiver(x,y,V(:,:,1),V(:,:,2));
    
end
