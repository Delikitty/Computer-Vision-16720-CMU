function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid
L_dog = size(DoGPyramid,3);
PrincipalCurvature = zeros(size(DoGPyramid));
% predefine the size of output
for i = 1:L_dog
    level_i = DoGPyramid(:,:,i);
    [Dx,Dy] = gradient(level_i);
    % get gradient by different the pixels horizontally and vertically
    [Dxx,Dxy] = gradient(Dx);
    [Dyx,Dyy] = gradient(Dy);
    Tr = Dxx+Dyy;
    Det = Dxx.*Dyy-Dxy.*Dyx;
    PrincipalCurvature(:,:,i) = (Tr.*Tr)./ Det;
    % use the equation in ref 3, section 4.1
end