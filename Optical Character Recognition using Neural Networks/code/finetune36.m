clc
clear
num_epoch =5;
classes = 36;
layers = [32*32, 800, classes];
learning_rate = 0.01;

load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')
load('../data/nist26_model_60iters.mat')
[Wini, bini] = InitializeNetwork(layers);

W{2} = Wini{2};
b{2} = bini{2};
clear Wini bini
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
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    savedata(j,1) = train_acc;
    savedata(j,3) = train_loss;
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    savedata(j,2) = valid_acc;
    savedata(j,4) = valid_loss;

    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n\n\n\n\n\n\n\n\n', j, train_acc, valid_acc, train_loss, valid_loss)
end

% W and b were saved in finetune36_Wb.mat
% save('finetune36_Wb.mat', 'W', 'b')

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
title('Accuracy for train and validation');
legend('train accuracy','valid accuracy');hold off;
figure;
% The loss plot
plot(trainloss,'g');axis([1 num_epoch 0 max(savedata(:,3))]);
grid on;
hold on; 
plot(validloss,'r');axis([1 num_epoch 0 max(savedata(:,4))]);
xlabel('num of epoch');
ylabel('Losses');
title('Losses for train and validation');
legend('train loss','valid loss');hold off;

%% Test on trained models
load finetune36_Wb.mat;
% [test_acc, test_loss] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);

%% For visualizing the weights 
% load('finetune36_Wb.mat')
% W_learn = W{1};
% W_learn = W_learn - repmat(mean(W_learn,2),1,size(W_learn,2));
% W_learn =  W_learn./repmat(std(W_learn,0,2),1,size( W_learn,2));
% W_learn = W_learn';
% W_learn = W_learn(:);
% I_learn = reshape(W_learn,32,32,1,800);
% figure('pos',[10 10 900 900])
% weight_learn = imaqmontage(I_learn);
% 
% W_initial = W_INI{1};
% W_initial = W_initial - repmat(mean(W_initial,2),1,size(W_initial,2));
% W_initial =  W_initial./repmat(std(W_initial,0,2),1,size( W_initial,2));
% W_initial = W_initial';
% W_initial = W_initial(:);
% I_initial = reshape(W_initial,32,32,1,800);
% figure('pos',[10 10 900 900])
% weight_initial = imaqmontage(I_initial);

%% visualize confusion matrix

% [predlabel] = Classify(W, b, test_data);
% predtmp = max(predlabel,[],2);
% mmax = repmat(predtmp,[1,size(test_labels,2)]);
% pred = predlabel==mmax;
% pred = double(pred);
% % pred is a logical matrix with 1 at predict label
% 
% conf_matrix = pred' * test_labels;
% conf_matrix = conf_matrix - repmat(mean(conf_matrix,2),1,size(conf_matrix,2));
% conf_matrix =  conf_matrix./repmat(std(conf_matrix,0,2),1,size( conf_matrix,2));
% conf_matrix = resizem(conf_matrix,[360,360]);

%% plot confusion matrix with matlab function

% plotconfusion(test_labels',predlabel')
% [c,cm,ind,per] = confusion(test_labels',predlabel');
% colormap jet;
% imagesc(cm);colorbar





