%For memory problems
clear all;
fclose('all');

%Different settings
color_spaces = {'rgb'};
%, 'RGB', 'gray', 'opponent'
kernel_size = [2000];
% , 800, 1600, 2000
%, 4000

%Extract all path strings into cell arrays
test_motor = read_in_file_names('Caltech4/ImageSets/motorbikes_test.txt');
test_faces = read_in_file_names('Caltech4/ImageSets/faces_test.txt');
test_cars = read_in_file_names('Caltech4/ImageSets/cars_test.txt');
test_airplanes = read_in_file_names('Caltech4/ImageSets/airplanes_test.txt');

which train()
which predict()

test_motor = preprocess_images(test_motor);
test_faces = preprocess_images(test_faces);
test_cars = preprocess_images(test_cars);
test_airplanes = preprocess_images(test_airplanes);

for c = 1:length(color_spaces)
    for k = 1:length(kernel_size)     
        hist = importdata(strcat('histograms/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'.mat'));
        hist_s = sparse(hist);
        
        %1 motorbikes, 2 faces, 3 cars, 4 airplanes
        label = zeros(1004,1);
        %label(1:251) = 1;
        label(251:502) = 1.0;
        %label(502:753) = 3.0;
        %label(753:end) = 4.0;
        
        %SVMModel = fitcsvm(hist,label,'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');
        
        bestC = train(label, hist_s, '-s 1 -C -s 0');
        model = train(label, hist_s, sprintf('-s 1 -c %f -s 0', bestC(1)));

        voc_ims = [test_faces];   
        centers = importdata(strcat('kmeans/',num2str(kernel_size(k)),'_',num2str(c),color_spaces{c},'.mat'));

        for i = 1:size(voc_ims,2)
            fprintf('%d ', i);

            %extract features normal and dense
            features = extract_features(imread(voc_ims{i}),color_spaces{c}, 0);
            %features_dense = extract_features(imread(voc_ims{i}),color_spaces{c}, 1);

            [~, all_center] = min(vl_alldist(centers, features));
            edges = [0:1:kernel_size(k)];
            all_hist(i,:) = histcounts(all_center , edges , 'Normalization' , 'pdf' );       
        end
    end
end

'test'
all_hist_s = sparse(all_hist);
label_t = zeros(50,1);
label_t(1:50) = 1.0;

%slabel = predict(SVMModel,all_hist);

[predicted_label, accuracy, prob_estimates] = predict(label_t, all_hist_s, model);

fclose('all');
