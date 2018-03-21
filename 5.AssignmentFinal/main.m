clear all

%Extract all path strings into cell arrays
train_motorbikes = read_in_file_names('Caltech4/ImageSets/motorbikes_train.txt');
train_faces = read_in_file_names('Caltech4/ImageSets/faces_train.txt');
train_cars = read_in_file_names('Caltech4/ImageSets/cars_train.txt');
train_airplanes = read_in_file_names('Caltech4/ImageSets/airplanes_train.txt');

fclose('all');

%number of images visual dictionary
N = 10;

%Create empty cell array for features
motor_features = cell(N,1);

% extract features from N images
for i = 1:N
    %extract features from one image for [1.rgb 2.RGB 3.gray 4.opponent]
    motor_features{i} = extract_features(imread(train_motorbikes{i}));
    fclose('all');
end
    


%run('C:\Program Files\MATLAB\R2017b\src\vlfeat/toolbox/vl_setup')


