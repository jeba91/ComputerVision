function [im] = affine(image, m, t)

%get dimension and corner sizes
[rows, cols, dim] = size(image);
im_corners = floor(m * [ 1  1 rows rows; 1 cols cols 1] );

%Create new bounds of new image
mini = min(im_corners,[],2);
xmin = mini(1);
ymin = mini(2);
maxi = max(im_corners,[],2);
xmax = maxi(1);
ymax = maxi(2);

%check size of new image
ysize = xmax - xmin + 1;
xsize = ymax - ymin + 1;
im_size = [xsize, ysize, dim];

%create minus 1 for interpolation
im = -1 * ones([im_size]);

%fill in new image
for x=1:rows
    for y=1:cols
        xytrans = floor(m * [x y]') - [ xmin - 1; ymin - 1];
        im(xytrans(1), xytrans(2), :) = image(x,y,:);
    end
end 

%Interpolate with neighbour to the right
for x = 2:size(im,1)-1
    for y = 2:size(im,2)-1
        if im(x,y) < 0
            im(x,y) = mean(mean(im((x-1):(x+1),(y-1):(y+1))));
        end
    end
end
    
end