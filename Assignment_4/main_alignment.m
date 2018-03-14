boat1 = single(imread('boat1.pgm'));
boat2 = single(imread('boat2.pgm'));

[f1, f2, matches] = keypoint_matching(boat1, boat2);

n = 1000;
b = -1;


for N = 1:n
    sel = randperm(size(matches,2), 50);
    points1 = f1(:,matches(1,sel));
    points2 = f2(:,matches(2,sel));
    [m, t] = RANSAC(points1, points2);
    points2(1:2,:) = m * points2(1:2,:) + t;
    x = points1(1,:) - points2(1,:);
    y = points1(1,:) - points2(1,:);
    d = sqrt(x.^2 + y.^2);
    s = length(find(d<10));
    if s > b
        b = s;
        mb = m;
        tb = t;
    end
end

A = zeros(3,3);
mb = mb'
A(1,1:2) = mb(1:2);
A(2,1:2) = mb(3:4);
A(3,1:2) = tb(1:2);
A(3,3) = 1;

T = maketform('affine',A);
B = imtransform(imread('boat2.pgm'),T);

imshowpair(imread('boat1.pgm'),B, "montage")
hold on;









