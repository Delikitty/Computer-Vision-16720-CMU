function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair

image1 = im2double(image1);
image2 = im2double(image2);

M = LucasKanadeAffine(image1, image2);
% image1 is of time t and image2 is of time t+1
% compute the affine matrix
[X,Y] = meshgrid(1:size(image1,2),1:size(image1,1));
XY1 = [X(:)'; Y(:)'; ones(1,length(X(:)))];

im_warp = M * XY1;
Xwarp = im_warp(1,:);
Ywarp = im_warp(2,:);

% ind = sub2ind(size(image1),Ywarp,Xwarp);
% im1 = image1(ind);

im2 = interp2(image2,Xwarp,Ywarp);
image_2 = reshape(im2,size(image2));


subb = image_2 - image1;
subb = abs(subb);
% got the 'changed' part between two frames
ind1 = find(subb>0.05);
subb(ind1) = 1;
indnan = isnan(subb);
subb(indnan) = 0;
indother = find(subb<=0.05);
subb(indother) = 0;



mask = subb;
% mask = imclearborder(subb);
% se = strel('square',2);
% se = strel('disk',1);
% mask = imerode(mask,se);

mask = bwareaopen(mask,35);

ser = strel('disk',5);
mask = imdilate(mask,ser);

se = strel('disk',1);
% mask = imerode(mask,se);

mask = bwareaopen(mask,60);




% output - mask is a binary image of the same size


end

