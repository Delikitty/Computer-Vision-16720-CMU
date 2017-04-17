function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.

%% compute the cross-entropy loss
[predictions] = Classify(W, b, data);
% a D*C matrix of predicted labels

tmp = labels .* log(predictions);
loss = - sum(tmp(:)) ./ size(predictions,1);


%% compute accuracy
predtmp = max(predictions,[],2);
mmax = repmat(predtmp,[1,size(labels,2)]);
pred = predictions==mmax;
% pred is a logical matrix with 1 at predict label
eq = labels & pred;
eq = double(eq);
eq = sum(eq,2);
% if pred=label yields 1, otherwise yields 0
eqind = find(eq==1);
equnum = length(eqind);
accuracy = sum(equnum(:)) ./ size(labels,1);


end
