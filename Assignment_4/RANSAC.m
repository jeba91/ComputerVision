function [m, t] = RANSAC(points1, points2)
    %get x and y for image 1 and image 2
    x1(1,:) = points1(1,:);
    x2(1,:) = points2(1,:);
    y1(1,:) = points1(2,:);
    y2(1,:) = points2(2,:);
    zero = zeros(1,size(x1,2));
    one = ones(1,size(x1,2));
    %Find transformation parameters by solving x = (A^T A)^?1 A^T b
    A = [x1'  y1' zero' zero' zero' one';...
        zero' zero' x1'  y1'  one' zero'];
    b = [x2'; y2'];
    tpoints = pinv(A) * b;
    % transformationpoints looks like [m1,m2,m3,m4,t1,t2], return m and t
    m = [tpoints(1:2)'; tpoints(3:4)'];
    t = tpoints(5:6);
end
