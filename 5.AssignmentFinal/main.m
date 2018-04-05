%For memory problems
clear all;
fclose('all');

%Extract all path strings into cell arrays
train_motorbikes = read_in_file_names('Caltech4/ImageSets/motorbikes_train.txt');
train_faces      = read_in_file_names('Caltech4/ImageSets/faces_train.txt');
train_cars       = read_in_file_names('Caltech4/ImageSets/cars_train.txt');
train_airplanes  = read_in_file_names('Caltech4/ImageSets/airplanes_train.txt');

train_motorbikes = preprocess_images(train_motorbikes);
train_faces      = preprocess_images(train_faces);
train_cars       = preprocess_images(train_cars);
train_airplanes  = preprocess_images(train_airplanes);

%Different settings
color_spaces = {'RGB'};
kernel_size = [4000];
N = 150;                  %number of images visual dictionary

%Cell array with all image paths voor vocubulary
voc_ims = [train_motorbikes(1:N) train_faces(1:N) train_cars(1:N) train_airplanes(1:N)];

%With 4 colorspaces, 5 kernels size and dense/not dense we have 4*5*2
%configurations. Total of 40 kmeans and SVM need to be trained and tested. 

% extract features from N images for every colorspace and kernel
%extract features from one image for [1.rgb 2.RGB 3.gray 4.opponent]
for c = 1:length(color_spaces)
    fprintf('\b %d ', c);
    %Matrix to be filled with total features for k-means algorithm
    total = [];
    total_dense = [];
    for i = 1:size(voc_ims,2)
        image = imread(voc_ims{i});
        fprintf('%d ', i);
        %extract features normal
        features       = extract_features(image ,color_spaces{c}, 0);
        %extract features dense
        features_dense = extract_features(image ,color_spaces{c}, 1);            
        %concentenate for large training matrix
        total = cat(2,features,total);
        %concentenate for large training matrix dense
        total_dense = cat(2,features_dense,total);
        %close all files
        fclose('all');
    end
    %Loop through all possible kernel sizes and apply kmeans for normal
    %and dense. Save these in the kmeans folder
    for k = 1:length(kernel_size)
        fprintf('\n %d ', k);
        %Apply kmeans and get 128xkernel size matrix with centers
        [centers, ~] = vl_kmeans(total,kernel_size(k),'algorithm', 'elkan');
        [centers_dense, ~] = vl_kmeans(total_dense,kernel_size(k),'algorithm', 'elkan');
        %Save centers for later use
        savename = strcat('kmeans/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'.mat');
        savename_dense = strcat('kmeans/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'_dense','.mat');
        save(savename,'centers')
        save(savename_dense,'centers_dense')
    end
end




%run('C:\Program Files\MATLAB\R2017b\src\vlfeat/toolbox/vl_setup')