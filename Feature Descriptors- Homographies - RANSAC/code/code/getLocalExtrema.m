function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.
L_dog=size(DoGPyramid,3);
%% get the position of wanted point
satis_threshold = (abs(DoGPyramid) > th_contrast) & (PrincipalCurvature < th_r);

% logical matrix of index satified two threshold together

% regmax = imregionalmax(DoGPyramid);
% regmin = imregionalmin(DoGPyramid);
[regmax,regmin]=regionalextrema(DoGPyramid);

ind_extrema = satis_threshold & (regmax | regmin);
% extrema is both maximum and minimum
%% get output matrix locsDoG
l_cell = cell(L_dog,1);
% Index of local extrema
for i = 1:L_dog
    ind = find(ind_extrema(:,:,i) == 1);
    N = length(ind);
    % number of emtrema points in this level
    l = ones(N,1);
    l = (i-1)*l;
    [y,x] = ind2sub([size(DoGPyramid,1),size(DoGPyramid,2)],ind);
    % locate the (x,y) of local extrema, y->row, x->col 
    l_cell{i} = [x,y,l];
end
locsDoG = cell2mat(l_cell);
end