function [W, b] = Train(W, b, train_data, train_label, learning_rate)
% [W, b] = Train(W, b, train_data, train_label, learning_rate) trains the network
% for one epoch on the input training data 'train_data' and 'train_label'. This
% function should returned the updated network parameters 'W' and 'b' after
% performing backprop on every data sample.


% This loop template simply prints the loop status in a non-verbose way.
% Feel free to use it or discard it


fprintf('\t\t\t\t');

for i = 1:size(train_data,1)
    [~, act_h, act_a] = Forward(W, b, train_data(i,:));
    [grad_W, grad_b] = Backward(W, b, train_data(i,:), train_label(i,:), act_h, act_a);
    [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);
    
    if mod(i, 100) == 0
        fprintf('\b\b\b\b\b\b\b\b\b\b\b\b')
        fprintf('Done %5.2f %%', i/size(train_data,1)*100)
    end
end
fprintf('\b\b\b\b\b\b\b\b\b\b\b\b')


end
