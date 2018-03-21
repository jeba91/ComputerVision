function [features] = extract_features(image)

imageRGB = rgb2RGB(image);
imageGS  = rgb2gray(image);
imageOPP = rgb2OPP(image);

images = {image, imageRGB, imageGS, imageOPP};

features = cell(4,1);

for i = 1:length(images)
    if size(images{i},3)>1
        im = images{i};
        
        layer1 = single(im(:,:,1));
        layer2 = single(im(:,:,2));
        layer3 = single(im(:,:,3));

        [~, d1] = vl_sift(layer1);
        [~, d2] = vl_sift(layer2);
        [~, d3] = vl_sift(layer3);

        feats = cat(2,d1,d2);
        features{i} = cat(2,feats,d3);
    else
        im = single(images{i});
        [~, d] = vl_sift(im);
        features{i} = d;    
    end 
end
end

function [im] = rgb2RGB(image)
image = im2double(image);

total = image(:,:,1)+image(:,:,2)+image(:,:,3);

im(:,:,1) = image(:,:,1)/total;
im(:,:,2) = image(:,:,2)/total;
im(:,:,3) = image(:,:,3)/total;

end

function [im] = rgb2OPP(image)

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