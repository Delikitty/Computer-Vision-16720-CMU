function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, ...
                                                levels, th_contrast, th_r)
%%DoGdetector
%  Putting it all together
%
%   Inputs          Description
%--------------------------------------------------------------------------
%   im              Grayscale image with range [0,1].
%im=imread('/Users/peachie/Desktop/SEM1-16720-CV/HWs/HW2/hw2/data/model_chickenbroth.jpg');
%   sigma0          Scale of the 0th image pyramid.
sigma0 = 1;
%   k               Pyramid Factor.  Suggest sqrt(2).
k = sqrt(2);
%   levels          Levels of pyramid to construct. Suggest -1:4.
levels = [-1,0,1,2,3,4];
%   th_contrast     DoG contrast threshold.  Suggest 0.03.
th_contrast = 0.03;
%   th_r            Principal Ratio threshold.  Suggest 12.
th_r = 12;
%   Outputs         Description
%--------------------------------------------------------------------------
[GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r);
%   locsDoG         N x 3 matrix where the DoG pyramid achieves a local extrema
%                   in both scale and space, and satisfies the two thresholds.
%
%   GaussianPyramid A matrix of grayscale images of size (size(im),numel(levels))


end

