boat1 = single(imread('boat1.pgm'));
boat2 = single(imread('boat2.pgm'));

figure
imshowpair(imread('boat1.pgm'),imread('boat2.pgm'), "montage")
hold on;
% 
% [f1, d1] = vl_sift(boat1);
% [f2, d2] = vl_sift(boat2);

[f1, f2, matches] = keypoint_matching(boat1, boat2);

sel = randperm(size(matches,2), 50);

pointim1 = matches(1,sel);
pointim2 = matches(2,sel);

points1 = f1(:,pointim1);
points2 = f2(:,pointim2);

points2(1,:) = points2(1,:) + 850;

x = zeros(2,50);
y = zeros(2,50);

x(1,:) = points1(1,:);
x(2,:) = points2(1,:);
y(1,:) = points1(2,:);
y(2,:) = points2(2,:);

plot(x,y)

h1 = vl_plotframe(points1);
h2 = vl_plotframe(points1);

h3 = vl_plotframe(points2);
h4 = vl_plotframe(points2);

set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',1);

set(h3,'color','k','linewidth',3);
set(h4,'color','y','linewidth',1);



