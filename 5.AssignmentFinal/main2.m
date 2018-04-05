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
kernel_size = [400, 800, 1600, 2000 ];
%, 4000 


%number of images visual dictionary
N = 150;         
M = 400;

%With 4 colorspaces, 5 kernels size and dense/not dense we have 4*5*2
%configurations. Total of 40 kmeans and SVM need to trained and tested.

%Preprocess data for removal grayscale and therefore even sized arrays of histograms
train_motorbikes = preprocess_images(train_motorbikes);
train_faces      = preprocess_images(train_faces);
train_cars       = preprocess_images(train_cars);
train_airplanes  = preprocess_images(train_airplanes);

%Cell array with all image paths voor vocubulary
voc_ims = [train_motorbikes(N:M) train_faces(N:M) train_cars(N:M) train_airplanes(N:M)];

% extract features from N images
for c = 1:length(color_spaces)
    for k = 1:length(kernel_size)        
        %Get centers from correct colorspace and kernel
        centers = importdata(strcat('kmeans/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'.mat'));
        for i = 1:size(voc_ims,2)
            fprintf('%d ', i);
            %extract features normal and dense
            features = extract_features(imread(voc_ims{i}),color_spaces{c}, 0);
            %features_dense = extract_features(imread(voc_ims{i}),color_spaces{c}, 1);
            [~, all_center] = min(vl_alldist(centers, features));
            edges = [0:1:kernel_size(k)];
            all_hist(i,:) = histcounts(all_center,edges,'Normalization','pdf');
        end
        
        savename = strcat('histograms/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'.mat');
        %savename_dense = strcat('kmeans/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'_dense','.mat');

        save(savename,'all_hist')
        %save(savename_dense,'centers_dense')
        
        fclose('all');
    end
end




%run('C:\Program Files\MATLAB\R2017b\src\vlfeat/toolbox/vl_setup')