clc
clear
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

eps = 1e-6;
load('40epoch_learningrate0_01.mat');
% [W, b] = InitializeNetwork(layers);
points = 100;
results = zeros(2*points,2);
% 1st col is gradientW from back propagation
% 2nd col is gradientW from calculation

randind = randperm(size(train_data,1),1);
% randomly pick 1 sample in train data


X = train_data(randind,:);
Y = train_labels(randind,:);
[~, act_h, act_a] = Forward(W, b, X);
[grad_W, ~] = Backward(W, b, X, Y, act_h, act_a);
    
len = length(W);

    for i=1:len
        
        gradW = grad_W{i};
%         gradb = grad_b{i};
        
        [ROW,COL] = size(W{i});

        % 5 random selected coordinates for computing gradients
        for num=1:points
            
            row = randperm(ROW,1);
            col = randperm(COL,1);
                
            Wplus = W{i};
            Wplus(row,col) = Wplus(row,col) + eps;
            WPLUS = W;
            WPLUS{i} = Wplus;
             
%             bplus = b{i};
%             bplus(row,1) = bplus(row) + eps;
%             bPLUS = b;
%             bPLUS{i} = bplus;
                
            Wsub = W{i};
            Wsub(row,col) = Wsub(row,col) - eps;
            WSUB = W;
            WSUB{i} = Wsub;
                
%             bsub = b{i};
%             bsub(row,1) = bsub(row) - eps;
%             bSUB = b;
%             bSUB{i} = bsub;

            [~,Wlossplus] = ComputeAccuracyAndLoss(WPLUS, b, X, Y);
            [~,Wlosssub] = ComputeAccuracyAndLoss(WSUB, b, X, Y);
%             [~,blossplus] = ComputeAccuracyAndLoss(W, bPLUS, X, Y);
%             [~,blosssub] = ComputeAccuracyAndLoss(W, bSUB, X, Y);
                
            calgradW = (Wlossplus - Wlosssub) ./ (2*eps);
%             calgradb = (blossplus - blosssub) ./ (2*eps);
                
            results(points * (i-1) + num,1) = gradW(row,col);
            results(points * (i-1) + num,2) = calgradW;
%             results(points * (i-1)+num,3) = gradb(row);
%             results(points * (i-1)+num,4) = calgradb;
%             results(points * (i-1)+num,5) = i;
        end
        
    end

diffW = results(:,1) - results(:,2);
acrW = diffW < 1e-4;
% diffb = results(:,3) - results(:,4);
% acrb = diffb < 0.001;

acr = (sum(acrW)) ./ length(acrW);
fprintf('The accuracy of gradient checking is: %f\n' , acr);
