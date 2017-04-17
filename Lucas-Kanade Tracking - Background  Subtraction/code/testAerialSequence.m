close all
clear
load('../data/aerialseq.mat');
% load frames

num_frame = size(frames,3);
cell6 = cell(4,1);
cal = 1;
for i = 1:num_frame-1
    
    image1 = frames(:,:,i);
    image2 = frames(:,:,i+1);
    mask = SubtractDominantMotion(image1, image2);
%    imshow(mask);
%    im = imfuse(image1,mask,'ColorChannels',[1 2 2]);
%    im = imfuse(mask,image1);
%    imshow(im);

    if i==30 || i==60 || i==90 || i==120
         
        imshow(image1);
        hold on;
        green = cat(3, 240/255*ones(size(image1)),145/255*ones(size(image1)), 153/255*ones(size(image1)));
        % color name is peach :)
        h = imshow(green); 
        set(h,'AlphaData',mask);
        hold off; pause(0.01);
        
        cell6{cal} = getframe(gca);
        cell6{cal} = cell6{cal}.cdata;
        cal = cal + 1;
   end
        
end

% to visualize 5 images
% i.e, the first image: im1 = cell6{1}; imshow(im1);
% implementation