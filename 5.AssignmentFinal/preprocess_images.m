function [images_processed] = preprocess_images(images)

remove = 0;

for i = 1:size(images,1)
    if(size(imread(images{i}),3) == 1)
        remove = remove + 1;
        continue
    else
        images_processed(i-remove) = images(i);
    end
end

end
