function [m, t] = RANSAC(f1, f2, sel)
    %get x and y for image 1 and image 2
    x1 = f1(1, sel(1, :));
    y1 = f1(2, sel(1, :));
    x2 = f2(1, sel(2, :));
    y2 = f2(2, sel(2, :));
    %Find transformation parameters by solving x = (A^T A)^?1 A^T b
    A = [x1', y1', zeros(2,size(x1,2))', ones(1,size(x1,2))', zeros(1,size(x1,2))';...
         zeros(2,size(x1,2)), x1', y1', zeros(1,size(x1,2))', ones(1,size(x1,2))];
    b = [x2'; y2'];
    tpoints = pinv(A) * b;
    % transformationpoints looks like [m1,m2,m3,m4,t1,t2], return m and t
    m = [tpoints(1:2)'; tpoints(3:4)'];
    t = tpoints(5:6);
end
