%images
boat1 = single(imread('boat1.pgm'));
boat2 = single(imread('boat2.pgm'));

%get scores
[f1, f2, matches] = keypoint_matching(boat1, boat2);

%paramters
iterations = 10000;
current_best = -1;
threshold = 10 %10 pixels


for N = 1:iterations
    %select 50 randoms points
    sel = randperm(size(matches,2), 50);
    points1 = f1(:,matches(1,sel));
    points2 = f2(:,matches(2,sel));
    
    %calculate transformation parameters
    [m, t] = RANSAC(points1, points2);
    
    %transform points of image1
    points1(1:2,:) = m * points1(1:2,:) + t;
    
    %Calculate distance between points1 and points2
    x = points1(1,:) - points2(1,:);
    y = points1(2,:) - points2(2,:);
    distance = sqrt(x.^2 + y.^2);
    
    %find number of inliers
    inliers = length(find(distance<threshold));
    
    %if inliers better, save inliers and transformation parameters
    if inliers > current_best
        current_best = inliers;
        mbest = m;
        tbest = t;
    end
end

%Fill in transformation parameters for affine2D
A = zeros(3,3);
A(1,1:2) = mb(1:2);
A(2,1:2) = mb(3:4);
A(3,1:2) = tb(1:2);
A(3,3) = 1;

%transform from boat1 to boat2
T = affine2d(A);
B = imwarp(imread('boat1.pgm'),T);
imshowpair(imread('boat2.pgm'),B, 'montage')

%transform from boat2 to boat1 (invert used)
T = invert(T)
B = imwarp(imread('boat2.pgm'),T);
imshowpair(imread('boat1.pgm'),B, 'montage')

%run('C:\Program Files\MATLAB\R2017b\src\vlfeat/toolbox/vl_setup')






