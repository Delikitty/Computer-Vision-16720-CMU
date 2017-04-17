function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
%% set uo size for output h and set calculator to zero 
    h=zeros(dictionarySize * (4^layerNum - 1)/3,1);
    %size of output matrix
    cal=0;
    
%% SPM 
    for l=(layerNum-1):-1:0;
        cellnum=2^l;
        row=floor(size(wordMap,1)/cellnum);
        col=floor(size(wordMap,2)/cellnum);
        %row&col size of each layer's sub-wordmap
        h_temp=cell(1,cellnum*cellnum);   
        for i=1:cellnum*cellnum
                cal=cal+1;
                rowvec=repmat(row,1,cellnum);
                rowvec(end)=size(wordMap,1)-(cellnum-1)*row;
                colvec=repmat(col,1,cellnum);
                colvec(end)=size(wordMap,2)-(cellnum-1)*col;
                wordMapp=mat2cell(wordMap,rowvec,colvec);
                wordMapp=wordMapp';
                h_temp{i}=wordMapp{i};
                %separated the wordmap accordingly & assign to each bin
                h_cell= getImageFeatures(h_temp{i}, dictionarySize);
                % get the histogram for each bin
                if l==0 || l==1
                    h_cell=h_cell/(2^(layerNum-1));
            else
                    h_cell=h_cell/2^(layerNum-l);
                end
                % weighted for each layer
                
                %ind=(i-1)*cellnum+j;
                % I keep it to remind myself why I was wrong at first:)
             
                h(((cal-1)*dictionarySize+1):cal*dictionarySize,:)=h_cell;
                %put histogram into output matrix
        end
    end
 
%% L1 normed output h
       h=h./sum(h(:)); 
end