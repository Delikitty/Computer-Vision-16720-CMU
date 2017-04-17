function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
%%Produces DoG Pyramid
% inputs
% Gaussian Pyramid - A matrix of grayscale images of size
%                    (size(im), numel(levels))
% levels      - the levels of the pyramid where the blur at each level is
%               outputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%               created by differencing the Gaussian Pyramid input
L = length(levels);
DoGPyramid = zeros(size(GaussianPyramid,1),size(GaussianPyramid,2),(L-1));
DoGLevels = zeros(1,(L-1));
% set original size of output
%% calculate DoGpyramid
for i = 1:(L-1)
    DoGPyramid(:,:,i) = GaussianPyramid(:,:,(i+1))-GaussianPyramid(:,:,i);
    % D_l=GP_l - GP_(l-1), get the difference of GuassianPyramid
    DoGLevels(i) = i-1;
end




end