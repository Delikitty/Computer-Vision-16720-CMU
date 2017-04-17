function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
	
%% get the histogram of wordMap in scale of dictionarysize
    h=hist(wordMap(:),1:dictionarySize)';
    
%% L1 normed h
    h=h./sum(h(:));
    
    assert(numel(h) == dictionarySize);

    
end