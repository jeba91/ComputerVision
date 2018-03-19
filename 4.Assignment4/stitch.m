function [im] = stitch(image1, image2, t)

[rows1, cols1, dim1] = size(image1);
[rows2, cols2, dim2] = size(image2);

im_corners1 = floor([ 1  1 rows1 rows1; 1 cols1 cols1 1] );
im_corners2 = floor([ 1  1 rows2 rows2; 1 cols2 cols2 1] );

xmax = rows2 + t(1);
ymax = cols2 + t(2);

end