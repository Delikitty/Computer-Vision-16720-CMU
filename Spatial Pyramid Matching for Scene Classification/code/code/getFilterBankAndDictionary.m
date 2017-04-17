function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();
    
    alpha=150; %(50-200)
    k=200;  %(100-300)
    filterbanksize=length(filterBank)*3;
    filter_responses=zeros(alpha*length(imPaths),filterbanksize);
    %filtercell=cell(length(imPaths),1);
%%
    for i=1:length(imPaths)
        img=imread(imPaths{i});
        
        [filterResponses]=extractFilterResponses(img, filterBank);
        %read image in and get filtered response
        h=size(img,1);
        w=size(img,2);
        ind=randperm(w*h,alpha);
        %randomly pick alpha point with its index
        for j=1:60;
            fil=filterResponses(:,:,j);
            filter_responses((1+(i-1)*alpha):(i*alpha),j)=fil(ind)';
        end
        %get alpha random index in range of the row numbers in f_responses
        
    end
%% use kmeans to cluster the responses    
    [~, dictionary] = kmeans(filter_responses, k, 'EmptyAction','drop')
    dictionary=dictionary';

end

