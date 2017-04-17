function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareX, compareY)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary



%im=rgb2gray(im);
%im=im2double(im);

row = size(im,1);
col = size(im,2);

patchWidth = 9;

halfpatch = floor(patchWidth./2);
locs = locsDoG(locsDoG(:,1)>halfpatch,:);
locs = locs(locs(:,1)<=(col-halfpatch),:);
locs = locs(locs(:,2)>halfpatch,:);
locs = locs(locs(:,2)<=(row-halfpatch),:);
% make points in locs able to lead to a full patch of width patchWidth
desc = zeros(size(locs,1),length(compareX));
for m = 1:size(locs,1)
    x = locs(m,1);
    y = locs(m,2);
    getpatch = im(y-4:y+4,x-4:x+4);
    % get 9*9 matris from im
    for n = 1:length(compareX)
        compx = compareX(n);
        compy = compareY(n);
        %% compute ? in matrix desc
        if getpatch(compx) < getpatch(compy)
            desc(m,n) = 1;
        else
            desc(m,n) = 0;
        end
    end
end

end
