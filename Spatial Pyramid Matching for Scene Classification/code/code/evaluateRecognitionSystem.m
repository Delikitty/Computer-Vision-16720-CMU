function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

load('vision.mat');
load('../data/traintest.mat');

% TODO Implement your code here
classnum=size(mapping,2);
C=zeros(classnum);
N=size(test_labels,1);
% C=8*8 matrix, i for known label, j for predicted label
%%
for i=1:N
    
    ii=test_labels(i);
    % pre-known label
    fprintf('image %d\n',i)
    restr=['../data/' test_imagenames{i}];
    image=imread(restr);
    % read image in so that got the input (just to remind myself)
    wordMap = getVisualWords(image, filterBank, dictionary);
    h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
    distances = distanceToSet(h, train_features);
    [~,nnI] = max(distances);
    % nnI is the index of train_labels
    j=train_labels(nnI);
    
    if ii~=j
        guessedImagewrong = mapping{j};
        guessedImageright = mapping{ii};
        fprintf('[Should be]:%s.\n',guessedImageright);
	    fprintf('[My Guess]:%s.\n',guessedImagewrong);
    end
    % find out the failed cases and show the right label
    C(ii,j)=C(ii,j)+1;
    % matrix which diagonal elements means correctly match while others not
end
 
C
conf=trace(C)/sum(C(:));

end