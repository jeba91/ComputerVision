%%

sel = randperm(size(matches,2), 50);

points1 = f1(:,matches(1,sel));
points2 = f2(:,matches(2,sel));

points2(1,:) = points2(1,:) + length(boat1);

x(1,:) = points1(1,:);
x(2,:) = points2(1,:);
y(1,:) = points1(2,:);
y(2,:) = points2(2,:);

imshowpair(imread('boat1.pgm'),imread('boat2.pgm'), "montage")
hold on;

plot(x,y)

h1 = vl_plotframe(points1);
h2 = vl_plotframe(points1);
h3 = vl_plotframe(points2);
h4 = vl_plotframe(points2);

set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',1);
set(h3,'color','k','linewidth',3);
set(h4,'color','y','linewidth',1);