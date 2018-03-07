sphere1 = imread('sphere1.ppm');
sphere2 = imread('sphere2.ppm');

sphere1gr = rgb2gray(sphere1);
sphere2gr = rgb2gray(sphere2);

synth1 = imread('synth1.pgm');
synth2 = imread('synth2.pgm');

region = 15;

%V1  = LK(sphere1gr,sphere2gr,region);
%visualize(sphere1, V1, region);

%V2  = LK(synth1,synth2,region);
%visualize(synth1, V2, region);

%V3 = LK(sphere1gr,sphere2gr,region,[15 30 45 60 75],[75 75 75 75 75])

function [V] = LK(im1, im2, regionsize, list1, list2)
    if mod(regionsize,2) == 0
        "no even numbers for regionsize"
        return
    end
    
    im1 = (im2double(im1));
    im2 = (im2double(im2));
    
    if exist('list1') == 1
        V = zeros(length(list1), 2)
        for m = 1:length(list1)
            V(m,:) = LucasKanade(im1,im2,regionsize,[list1(m),list2(m)]);
        end
        [x,y] = meshgrid(list1,list2);
        quiver(x,y,V(1,:),V(2,:));
    else
        if mod(size(im1,1),regionsize) ~= 0
            end_m = (size(im1,1) - mod(size(im1,1),regionsize)) - regionsize+1;
            end_n = (size(im1,2) - mod(size(im1,2),regionsize)) - regionsize+1;
        else
            end_m = size(im1,1)-(regionsize+2)
            end_n = size(im1,2)-(regionsize+2)
        end

        gridsize = (size(im1,1) - mod(size(im1,1),regionsize)) / regionsize;
        V=zeros(gridsize,gridsize,2);

        for m = 1:regionsize:end_m
            for n = 1:regionsize:end_n

                half = ((regionsize - mod(regionsize,2)) / 2);

                v = LucasKanade(im1,im2,regionsize,[m+half,n+half]);

                x = uint8((m-1)/regionsize)+1;            
                y = uint8((n-1)/regionsize)+1;

                V(x,y,1) = v(1);
                V(x,y,2) = v(2);           
            end
        end
    end
end

function [v] = LucasKanade(image1, image2, regionsize, centerpoint)

    [Gx, Gy] = gradient(fspecial('gaussian', 15, 1.5));
    Ix = conv2(image1, Gx, 'same');
    Iy = conv2(image2, Gy, 'same');
    It = image2 - image1;
    
    start_i = centerpoint(1) - ((regionsize - mod(regionsize,2)) / 2);
    start_j = centerpoint(2) - ((regionsize - mod(regionsize,2)) / 2);
    
    A=zeros((regionsize^2),2);
    b=zeros((regionsize^2),1);
    
    counter = 1;
    
    for i = start_i:start_i+regionsize
        for j = start_j:start_j+regionsize
            A(counter,1) = Ix(i,j);
            A(counter,2) = Iy(i,j); 
            b(counter,1) = -It(i,j);
            counter = counter + 1;
        end
    end
    
    v = (inv(transpose(A)*A))*(transpose(A)*b);   
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
