function [A] = matrix(m,t)

%Fill in transformation parameters for affine2D
A = zeros(3,3);
A(1,1:2) = m(1:2);
A(2,1:2) = m(3:4);
A(3,3) = 1;
end

