function [panoImg]=imageStitching_noClip(img1,img2,bestH)


width = 1200;
row = size(img2,1);
col = size(img2,2);
corner = [1, col, 1, col;
         1,   1, row, row;
         1,   1,  1,  1];
warp_corner = bestH * corner;
% get the coordinate of img2 in img1's reference flame
warp_corner = warp_corner./[warp_corner(3,:);warp_corner(3,:);warp_corner(3,:)];
warp_corner = ceil(warp_corner);

maxrow = max(size(img1,1),max(warp_corner(2,:)));
minrow = min(1,min(warp_corner(2,:)));
maxcol = max(size(img1,2),max(warp_corner(1,:)));
mincol = min(1,min(warp_corner(1,:)));
% get the new corner coordinate
scale = (maxcol - mincol)/(maxrow - minrow);

height = width/scale;
height = round(height);
% calculate height with input width
out_size = [height,width];

s = width/(maxcol - mincol);
% scale between input width and calculate fraction between height and width
scale_M = [s 0 0;0 s 0;0 0 1];

trans_M = [1 0 0;0 1 -minrow;0 0 1];
% translation matrix
M = scale_M * trans_M;

warp_im1 = warpH(img1, M, out_size);
warp_im2 = warpH(img2, M*bestH, out_size);
% warp img1 and img2 into a common reference frame
panoImg = max(warp_im1,warp_im2);
imwrite(panoImg,'../results/q6_2_pan.jpg');


end