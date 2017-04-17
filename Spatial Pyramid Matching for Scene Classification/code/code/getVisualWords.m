function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.
        
        [filterResponses] = extractFilterResponses(img, filterBank);
        h=size(img,1);
        w=size(img,2);
        wordMap=zeros(w*h,1);
        filter_2dim=zeros(w*h,3*length(filterBank));
%% get 2-dim matrix
        for ii=1:60
            im=filterResponses(:,:,ii);
            filter_2dim(:,ii)=im(:);
        end
%% calculate distance between filterresponse and dictonary 
        dis=pdist2(dictionary',filter_2dim);
        %dis is a k*(w*h) matrix
%% find the minumum distance and its index to create wordMap
        [dismin idx]=min(dis);
        %return to a row vector of minimum of each column with index
        wordMap=idx;
%% get wordMap within size of input image and show        
        wordMap=reshape(wordMap,[h,w]);
        imagesc(wordMap);
               
        
        
% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here

end
