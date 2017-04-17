function [matches,locs1,locs2]=testMatch



im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');
% im1 = imread('/Users/peachie/Desktop/1.png');
% im2 = imread('/Users/peachie/Desktop/2.png');
if size(im1,3)==3
    im1=rgb2gray(im1);
end
if size(im2,3)==3
    im2=rgb2gray(im2);
end

im1 = im2double(im1);
im2 = im2double(im2);

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

[matches] = briefMatch(desc1, desc2);
plotMatches(im1, im2, matches, locs1, locs2);

end
