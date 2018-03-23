%For memory problems
clear all;
fclose('all');

%Extract all path strings into cell arrays
train_motorbikes = read_in_file_names('Caltech4/ImageSets/motorbikes_train.txt');
train_faces = read_in_file_names('Caltech4/ImageSets/faces_train.txt');
train_cars = read_in_file_names('Caltech4/ImageSets/cars_train.txt');
train_airplanes = read_in_file_names('Caltech4/ImageSets/airplanes_train.txt');

%Different settings
color_spaces = {'rgb', 'RGB', 'gray', 'opponent'};
kernel_size = [400, 800, 1600, 2000, 4000];
N = 150;         %number of images visual dictionary

%Cell array with all image paths voor vocubulary
voc_ims = [train_motorbikes(1:N) ; train_faces(1:N) ; train_cars(1:N) ; train_airplanes(1:N) ];

%With 4 colorspaces, 5 kernels size and dense/not dense we have 4*5*2
%configurations. Total of 40 kmeans and SVM need to trained and tested. 

% extract features from N images
for c = 1:length(color_spaces)
    fprintf('\b %d ', c);
    %Matrix to be filled with total features for k-means algorithm
    total = [];
    total_dense = [];
    for i = 1:length(voc_ims)
        fprintf('%d ', i);
        %extract features from one image for [1.rgb 2.RGB 3.gray 4.opponent]
        if (size(imread(voc_ims{i}),3) == 1) && (strcmp(color_spaces{c},'gray') == 0)
            continue
        end
        %extract features normal and dense
        features = extract_features(imread(voc_ims{i}),color_spaces{c}, 0);
        features_dense = extract_features(imread(voc_ims{i}),color_spaces{c}, 1);            
        %concentenate for large training matrix
        total = cat(2,features,total);
        total_dense = cat(2,features_dense,total);
        fclose('all');
    end
    %Loop through all possible kernel sizes and apply kmeans for normal
    %and dense. Save these in the kmeans folder
    for k = 1:length(kernel_size)
        fprintf('\n %d ', k);
        [centers, ~] = vl_kmeans(total,kernel_size(k),'algorithm', 'elkan');
        [centers_dense, ~] = vl_kmeans(total_dense,4000(k),'algorithm', 'elkan');
        savename = strcat('kmeans/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'.mat');
        savename_dense = strcat('kmeans/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'_dense','.mat');
        save(savename,'centers')
        save(savename_dense,'centers_dense')
    end
end




%run('C:\Program Files\MATLAB\R2017b\src\vlfeat/toolbox/vl_setup')