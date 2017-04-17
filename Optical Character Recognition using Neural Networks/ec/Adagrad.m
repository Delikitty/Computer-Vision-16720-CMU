function [learning_rateW, learning_rateb] = Adagrad(gradWsum, gradbsum)

learning_rateW = cell(length(gradWsum),1);
learning_rateb = cell(length(gradbsum),1);
e = 1e-8;
eta = 0.01;

for i=1:length(gradWsum)
    gradW = gradWsum{i};
    learning_rateW{i} = eta ./ sqrt(gradW + e);
    
    gradb = gradbsum{i};
    learning_rateb{i} = eta ./ sqrt(gradb + e);
    
end

end
