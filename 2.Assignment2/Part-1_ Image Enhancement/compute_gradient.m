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

for m = 2:(size(I,1) - 1)
    for n = 2:(size(I,2) - 1)
        Gx(m,n) = sum(sum(I(m-1:m+1,n-1:n+1) .* x_sobel));
        Gy(m,n) = sum(sum(I(m-1:m+1,n-1:n+1) .* y_sobel));       
    end
end

im_magnitude = sqrt((Gx.^2) + (Gy.^2)); 
im_direction = 1./(tan(Gx./Gy));

subplot(2,2,1),imshow(Gx)
title('Gradient x-direction')
subplot(2,2,2),imshow(Gy)
title('Gradient y-direction')
subplot(2,2,3),imshow(im_magnitude)
title('Gradient magnitude pixel')
subplot(2,2,4),imshow(im_direction)
title('Gradient direction pixel')

saveas(gcf,'gradient.png')

end

