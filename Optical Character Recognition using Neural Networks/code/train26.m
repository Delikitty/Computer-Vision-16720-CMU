clc
clear
num_epoch = 40;
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

[W, b] = InitializeNetwork(layers);

savedata = zeros(num_epoch,4);
% matrix for saving acrs and losses for plot

% shuffle data
ind = randperm(length(train_data));
train_data = train_data(ind,:);
train_labels = train_labels(ind,:);
% normalize data to mean 0 and sigma 1
train_data = train_data - repmat(mean(train_data,2),[1,size(train_data,2)]);
train_data = train_data ./ repmat(std(train_data,0,2),[1,size(train_data,2)]);

W_INI = W;
% save the weight after initialization for visualization

for j = 1:num_epoch
    % Train_dropout is for the extra credit part
    [W, b] = Train_dropout(W, b, train_data, train_labels, learning_rate);
    % [W, b] = Train(W, b, train_data, train_labels, learning_rate);
    % [W, b] = Train_Adagrad(W, b, train_data, train_labels);
    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    savedata(j,1) = train_acc;
    savedata(j,3) = train_loss;
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    savedata(j,2) = valid_acc;
    savedata(j,4) = valid_loss;


    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n\n\n\n\n\n\n\n\n', j, train_acc, valid_acc, train_loss, valid_loss)
end

%% generate the plot

trainacr = savedata(:,1);
validacr = savedata(:,2);
trainloss = savedata(:,3);
validloss = savedata(:,4);

% the Accuracy plot
plot(trainacr,'g');axis([1 num_epoch 0 1]);
grid on;
hold on; 
plot(validacr,'r');axis([1 num_epoch 0 1]);
xlabel('num of epoch');
ylabel('Accuracy');
title('Accuracy for train and validation ; Adagrad');
legend('train accuracy','valid accuracy');hold off;
figure;
% The loss plot
plot(trainloss,'g');axis([1 num_epoch 0 max(savedata(:,3))]);
grid on;
hold on; 
plot(validloss,'r');axis([1 num_epoch 0 max(savedata(:,4))]);
xlabel('num of epoch');
ylabel('Losses');
title('Losses for train and validation ; Adagrad');
legend('train loss','valid loss');hold off;

% save('nist26_model.mat', 'W', 'b')

%% For learning rate is 0.01 part
% W and b saved in 40epoch_learningrate0_01.mat
% W and b saved in 240epoch_learningrate0_01.mat for 240 epochs training

%% For changing learning rate to 0.001 part
% W and b were saved in 240epoch_learningrate0_001.mat

%% Test on these two trained models

% load('240epoch_learningrate0_01.mat');
% [test_acc1, test_loss1] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);
% clear W b
% load('240epoch_learningrate0_001.mat');
% [test_acc2, test_loss2] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);

%% For Q3.1.3 visualize the weights 
% best network is with learning rate=0.01

load('240epoch_learningrate0_01.mat');
W_learn = W{1}';
% normalize the weight matrix
W_learn = W_learn - repmat(mean(W_learn,2),1,size(W_learn,2));
W_learn =  W_learn./repmat(std(W_learn,0,2),1,size( W_learn,2));

W_learn = W_learn(:);
I_learn = reshape(W_learn,32,32,1,400);
weight_learn = imaqmontage(I_learn);

W_initial = W_INI{1}';

W_initial = W_initial - repmat(mean(W_initial,2),1,size(W_initial,2));
W_initial =  W_initial./repmat(std(W_initial,0,2),1,size( W_initial,2));

W_initial = W_initial(:);
I_initial = reshape(W_initial,32,32,1,400);
figure('pos',[10 10 900 900])
weight_initial = imaqmontage(I_initial); 


%% For Q3.1.4 confusion matrix

load('240epoch_learningrate0_01.mat');
load('../data/nist26_test.mat', 'test_data', 'test_labels');

[predlabel] = Classify(W, b, test_data);
% predtmp = max(predlabel,[],2);
% mmax = repmat(predtmp,[1,size(test_labels,2)]);
% pred = predlabel==mmax;
% pred = double(pred);
% % pred is a logical matrix with 1 at predict label
% 
% conf_matrix = pred' * test_labels;
% conf_matrix = conf_matrix - repmat(mean(conf_matrix,2),1,size(conf_matrix,2));
% conf_matrix =  conf_matrix./repmat(std(conf_matrix,0,2),1,size( conf_matrix,2));
% conf_matrix = resizem(conf_matrix,[260,260]);

%% plot confusion matrix with matlab function

% plotconfusion(test_labels',predlabel')
[c,cm,ind,per] = confusion(test_labels',predlabel');
colormap jet;
imagesc(cm);colorbar




