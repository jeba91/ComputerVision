%%function to plot matches on both images

%images
boat1 = imread('boat1.pgm');
boat2 = imread('boat2.pgm');

im1 = single(boat1);
im2 = single(boat2);

%get scores
[f1, f2, matches] = keypoint_matching(im1, im2);
sel = randperm(size(matches,2), 50);

%get points of matches
points1 = f1(:,matches(1,sel));
points2 = f2(:,matches(2,sel));

%replace points to xy coordinates of boat2
points2(1,:) = points2(1,:) + length(boat1);

%get x and y coordinates
x(1,:) = points1(1,:);
x(2,:) = points2(1,:);
y(1,:) = points1(2,:);
y(2,:) = points2(2,:);

imshowpair(imread('boat1.pgm'),imread('boat2.pgm'), "montage")
hold on;

%plotting lines
plot(x,y)

h1 = vl_plotframe(points1);
h2 = vl_plotframe(points1);
h3 = vl_plotframe(points2);
h4 = vl_plotframe(points2);

set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',1);
set(h3,'color','k','linewidth',3);
set(h4,'color','y','linewidth',1);

saveas(gcf,'matches.png')

