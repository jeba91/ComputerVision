function [m, t] = transparams(points1, points2)
	%create parameters for equation
    x1(1,:) = points1(1,:);
    x2(1,:) = points2(1,:);
    y1(1,:) = points1(2,:);
    y2(1,:) = points2(2,:);
    zero = zeros(1,size(x1,2));
    one = ones(1,size(x1,2));
    
    %fill A and b with parameters
    A = [x1'  y1' zero' zero' zero' one';...
        zero' zero' x1'  y1'  one' zero'];
    b = [x2'; y2'];
    
    %solve equation
    tpoints = pinv(A) * b;
    
    %create m and t for return
    m = [tpoints(1:2)'; tpoints(3:4)'];
    t = tpoints(5:6);
end
