%% main function 


%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

nets.fine_tuned = load(fullfile(expdir, 'net-epoch-120.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-caltech.mat'));


%% train svm and extract features
[pre_trained_train, pre_trained_test,...
    fine_tuned_train, fine_tuned_test]= train_svm(nets, data);

%% tsne 
figure(1);
tsne_pre_trained = tsne(full(cat(1,pre_trained_train.features, pre_trained_test.features)));%,cat(1,pre_trained_train.labels, pre_trained_test.labels));
gscatter(tsne_pre_trained(:,1), tsne_pre_trained(:,2),cat(1,pre_trained_train.labels, pre_trained_test.labels))

figure(2);
tsne_fine_tuned = tsne(full(cat(1,fine_tuned_train.features, fine_tuned_test.features)));%, cat(1,fine_tuned_train.labels, fine_tuned_test.labels));
gscatter(tsne_fine_tuned(:,1), tsne_fine_tuned(:,2),cat(1,fine_tuned_train.labels, fine_tuned_test.labels))

