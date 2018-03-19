function [mbest tbest] = RANSAC(im1, im2, iterations, threshold, P)

%convert to grayscale when more dimensions
if(size(im1,3)>1)
    im1 = rgb2gray(im1);
    im2 = rgb2gray(im2);
end

%convert to single
im1 = single(im1);
im2 = single(im2);

%get scores
[f1, f2, matches] = keypoint_matching(im1, im2);

%parameters
current_best = -1;

for N = 1:iterations
    %select P randoms points
    sel = randperm(size(matches,2), P);
    points1 = f1(:,matches(1,sel));
    points2 = f2(:,matches(2,sel));
    
    %calculate transformation parameters
    [m, t] = transparams(points1, points2);
    
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

end