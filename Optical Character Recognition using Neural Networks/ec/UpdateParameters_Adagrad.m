function [W, b] = UpdateParameters_Adagrad(W, b, grad_W, grad_b, learning_rateb, learning_rateW)
% [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate) computes and returns the
% new network parameters 'W' and 'b' with respect to the old parameters, the
% gradient updates 'grad_W' and 'grad_b', and the learning rate.

len = length(W);

for i =1:len
    W{i} = W{i} - learning_rateW{i} .* grad_W{i};
    b{i} = b{i} - learning_rateb{i} .* grad_b{i};
end

end

