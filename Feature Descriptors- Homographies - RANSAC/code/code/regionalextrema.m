function [regmax,regmin]=regionalextrema(DoGPyramid)
% considered 26 neighbor for a point 
% ignored first and last level of DoGPyramid
L_dog = size(DoGPyramid,3);
regmax = zeros(size(DoGPyramid,1),size(DoGPyramid,2),5);
regmin = zeros(size(DoGPyramid,1),size(DoGPyramid,2),5);

% cat_zero=zeros(size(DoGPyramid,1),size(DoGPyramid,2));
% DoGPyramid=cat(3,cat_zero,DoGPyramid,cat_zero);
for i = 2:(L_dog-1)

    cella = cell(3);
    cellb = cell(3);
    cellc = cell(3);
    for x = -1:1:1
        for y = -1:1:1
            cella{x+2,y+2} = circshift(DoGPyramid(:,:,i),[x,y]);
            cellb{x+2,y+2} = circshift(DoGPyramid(:,:,i-1),[x,y]);
            cellc{x+2,y+2} = circshift(DoGPyramid(:,:,i+1),[x,y]);
            % shift value around keypoints for its 26 neighbors
        end
    end
    cata = cat(3,cella{5},cella{1},cella{2},cella{3},cella{4},cella{6},cella{7},cella{8},cella{9});
    catb = cat(3,cellb{1},cellb{2},cellb{3},cellb{4},cellb{5},cellb{6},cellb{7},cellb{8},cellb{9});
    catc = cat(3,cellc{1},cellc{2},cellc{3},cellc{4},cellc{5},cellc{6},cellc{7},cellc{8},cellc{9});
    catcell=cat(3,cata,catb,catc);
    % get a row*col*27 dimension matrix 
    % first dim is the layer in DoGPyramid
    % 26 dim after is the 26 neighbors of this keypoint 
    
    [~,indmax] = max(catcell,[],3);
    [~,indmin] = min(catcell,[],3);
    
    ind_extremax = find(indmax==1);
    % the first dimension has a local maximum 
    % local extrema in corresponding layer in DoGPyramid
    tmpmax = regmax(:,:,i);
    tmpmax(ind_extremax) = 1;
    regmax(:,:,i) = tmpmax;
    % logistic value in output matrix
    
    ind_extremin = find(indmin==1);
    % the first dimension has a local minimum
    % local extrema in corresponding layer in DoGPyramid
    tmpmin = regmin(:,:,i);
    tmpmin(ind_extremin) = 1;
    regmin(:,:,i) = tmpmin;
    % logistic value in output matrix
end


end