function [W, b] = Train_Adagrad(W, b, train_data, train_label)
% [W, b] = Train(W, b, train_data, train_label, learning_rate) trains the network
% for one epoch on the input training data 'train_data' and 'train_label'. This
% function should returned the updated network parameters 'W' and 'b' after
% performing backprop on every data sample.


% This loop template simply prints the loop status in a non-verbose way.
% Feel free to use it or discard it


fprintf('\t\t\t\t');
gradWsum = cell(length(W),1);
gradbsum = cell(length(b),1);
for len=1:length(W)
    gradWsum{len} = zeros(size(W{len}));
    gradbsum{len} = zeros(size(b{len}));
end

for i = 1:size(train_data,1)
    [~, act_h, act_a] = Forward(W, b, train_data(i,:));
    [grad_W, grad_b] = Backward(W, b, train_data(i,:), train_label(i,:), act_h, act_a);
    for j=1:length(W)
        gradWsum{j} = gradWsum{j}.^2 + grad_W{j}.^2;
        gradbsum{j} = gradbsum{j}.^2 + grad_b{j}.^2;       
    end
    [learning_rateW, learning_rateb] = Adagrad(gradWsum, gradbsum);
    [W, b] = UpdateParameters_Adagrad(W, b, grad_W, grad_b,learning_rateb, learning_rateW);
    
    if mod(i, 100) == 0
        fprintf('\b\b\b\b\b\b\b\b\b\b\b\b')
        fprintf('Done %5.2f %%', i/size(train_data,1)*100)
    end
end
fprintf('\b\b\b\b\b\b\b\b\b\b\b\b')


end
