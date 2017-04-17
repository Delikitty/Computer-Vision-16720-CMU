function [grad_W, grad_b] = Backward_dropout(W, b, X, Y, act_h, act_a, dropind)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'


len = length(W);
grad_W = cell(len,1);
grad_b = cell(len,1);
% cell term used to store the gradient in each layer
term = cell(len,1);

for i=len:-1:1
    %% output layer
    
    if i==len
        % gradient for softmax: 
        % consider both i=j (diagonal of Jacobian) and i~=j (others)
        term2 = act_h{i} - Y';% dL/df(x) * d(act_h)/d(act_a)
        % save this gradient for other layers' use
        term{i} = term2;
        % compute the gradient for this layer
        drop = act_h{i - 1};
        randind = dropind{i};
        drop(randind) = 1;
        % for the ingored hidden units
        % do not update their gradient
        grad_W{i} = term{i} * drop'; % act_h{i-1} is : d(act_a)/dw
        grad_b{i} = term{i};
    end
    %% not output layer
    
    if i~=len
        
        term11 = W{i+1}; % d(act_a i+1)/d(act_h i)
        term12 = act_h{i} .* (ones(size(act_h{i})) - act_h{i}); % d(act_h i)/d(act_a i)
        term{i} = term11' * term{i+1} .* term12;
        % if it is the input layer or not
        if i==1
            self = X;
        else
            drop = act_h{i - 1};
            randind = dropind{i};
            drop(randind) = 1;
            self = drop;
        end
        
        grad_W{i} = term{i} * self;
        grad_b{i} = term{i};
        
    end
    
end
end
