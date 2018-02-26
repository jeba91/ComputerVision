function [ PSNR ] = myPSNR( orig_image, approx_image )

I = im2double(orig_image);
Iapprox = im2double(approx_image);
Sum = 0;

for m = 1:size(I,1)
    for n = 1:size(I,2)
        Sum = Sum + (I(m,n) - Iapprox(m,n))^2;
    end
end


Sum = (1/( size(I,1)*size(I,2) ) )*(Sum);
PSNR = 20 * log10( max(max(I))/sqrt(Sum));

end
