function [features] = extract_features(image, colorspace, dense)

%Save images in cell array for for-loop
if strcmp(colorspace, 'rgb') == 1
    im = single(image);
elseif strcmp(colorspace, 'RGB') == 1
    im = single(rgb2RGB(image));
elseif strcmp(colorspace, 'gray') == 1
    im = single(rgb2gray(image));
elseif strcmp(colorspace, 'opponent') == 1
    im = single(rgb2OPP(image));
end

%Get features from grayscale images for descriptors in seperate layers
[f] = vl_sift(single(rgb2gray(image)));

%If the image has more than 3 dimensions
if size(im,3) == 3
    %extract different layers
    layer1 = single(im(:,:,1));
    layer2 = single(im(:,:,2));
    layer3 = single(im(:,:,3));

    %If not dense, get descriptors per layer with gs features
    if dense == 0
        [~, d1] = vl_sift(layer1, 'frames', f);
        [~, d2] = vl_sift(layer2, 'frames', f);
        [~, d3] = vl_sift(layer3, 'frames', f);
    %If dense, get descriptors with step size 10 (per 10 pixels)
    else
        [~, d1] = vl_dsift(layer1, 'step', 10);
        [~, d2] = vl_dsift(layer2, 'step', 10);
        [~, d3] = vl_dsift(layer3, 'step', 10);
    end
    %concatenate features over dimension 1 (128)
    features = cat(1,d1,d2,d3);
else
    [~, d] = vl_sift(im);
    features = d;    
end 

features = double(features);
end

%function to convert rgb to normalized RGB
function [im] = rgb2RGB(image)
%convert to double
image = im2double(image);

%total for normalize
total = image(:,:,1)+image(:,:,2)+image(:,:,3);

%normalize layers
im(:,:,1) = image(:,:,1)./total;
im(:,:,2) = image(:,:,2)./total;
im(:,:,3) = image(:,:,3)./total;
end

%Function to convert rgb to opponent colorspace
function [im] = rgb2OPP(image)
%conver to double
image = im2double(image);

%extract each channel
R  = image(:,:,1);
G  = image(:,:,2);
B  = image(:,:,3);

%convert to opponent space
im(:,:,1) = (R-G)./sqrt(2);
im(:,:,2) = (R+G-2*B)./sqrt(6);
im(:,:,3) = (R+G+B)./sqrt(3);

end