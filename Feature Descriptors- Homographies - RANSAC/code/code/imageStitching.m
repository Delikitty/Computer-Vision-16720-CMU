function [panoImg] = imageStitching(img1, img2, bestH)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%

% img1 = imread('/Users/peachie/Desktop/SEM1-16720-CV/HWs/HW2/hw2/data/incline_L.png');
% img2 = imread('/Users/peachie/Desktop/SEM1-16720-CV/HWs/HW2/hw2/data/incline_R.png');

zero_width = zeros(size(img1,1),900);
zero_width = repmat(zero_width,1,1,3);
img1 = [img1 zero_width];
img1 = im2double(img1);

warp_im = warpH(img2,bestH,[size(img1,1),size(img1,2)]);
warp_im = im2double(warp_im);
% warp img2 into img1?s reference frame
panoImg = max(img1,warp_im);
% imshow(warp_im);

imwrite(warp_im,'../results/q6_1.jpg');
save('../results/q6_1.mat','bestH');
end

% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image