function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

len = length(layers) - 1;
W = cell(len,1);
b = cell(len,1);

for i=1:len
    
    layers_now = layers(i);
    layers_next = layers(i + 1);
    %% xavier initialization with b=0
    
    varN = 1.0 ./ layers(1);
    W{i} = normrnd(0,varN,[layers_next,layers_now]);
    b{i} = zeros(layers(i + 1),1);
    
    %% normal distribution for W and b
%     W{i} = rand(layers_next,layers_now) - 0.5;
%     b{i} = rand(layers(i + 1),1) - 0.5;
    
    %% 
    
%     W{i} = randn(layers_next,layers_now);
%     b{i} = randn(layers(i + 1),1);
end

end
