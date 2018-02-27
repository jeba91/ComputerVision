function [Gx, Gy, im_magnitude , im_direction] = compute_gradient(image)

I = im2double(image);

x_sobel = [-1 0 1; 
           -2 0 2; 
           -1 0 1];
 
y_sobel = [-1 -2 -1; 
            0  0  0; 
            1  2  1];
Gx = zeros(size(I));
Gy = zeros(size(I));
im_magnitude = zeros(size(I));
im_gradient = zeros(size(I));

for m = 2:(size(I,1) - 1)
    for n = 2:(size(I,2) - 1)
        Gx(m,n) = sum(sum(I(m-1:m+1,n-1:+1) * x_sobel));
        Gy(m,n) = sum(sum(I(m-1:m+1,n-1:+1) * y_sobel));
       
    end
end

im_magnitude = sqrt((Gx^2) + (Gy^2)); 
im_gradient = 1/(tan(Gx/Gy))

imshow(im_magnitude)
im_gradient
        

end

