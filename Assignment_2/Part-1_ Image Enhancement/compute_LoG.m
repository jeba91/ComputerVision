function imOut = compute_LoG(image, LOG_type)


switch LOG_type
    case 1
        image = denoise(image , 'gaussian', 0.5, 5);
        h = fspecial('laplacian');
        imOut = imfilter(image,h);
    case 2
        h = fspecial('log',5,0.5);
        imOut = imfilter(image,h);
    case 3
        A = imgaussfilt(image,3);
        B = imgaussfilt(image,0.5);
        imOut = A - B;
end
end

