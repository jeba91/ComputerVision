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
N = 2;         %number of images visual dictionary

%Cell array with all image paths voor vocubulary
voc_ims = [train_motorbikes(1:N) ; train_faces(1:N) ; train_cars(1:N) ; train_airplanes(1:N) ];

% extract features from N images
for c = 1:length(color_spaces)
    fprintf('%d ', c);
    %Matrix to be filled with total features for k-means algorithm
    total = [];
    total_dense = [];
    for i = 1:length(voc_ims)
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
    for k = 1:length(kernel_size)
        [centers, ~] = vl_kmeans(total,kernel_size(k));
        [centers_dense, ~] = vl_kmeans(total_dense,kernel_size(k));
        savename = strcat('kmeans/',num2str(kernel_size(k)),color_spaces{c},'.mat')
        savename_dense = strcat('kmeans/',num2str(kernel_size(k)),color_spaces{c},'_dense','.mat')
        save(savename,'centers')
        save(savename_dense,'centers_dense')
    end
end




%run('C:\Program Files\MATLAB\R2017b\src\vlfeat/toolbox/vl_setup')