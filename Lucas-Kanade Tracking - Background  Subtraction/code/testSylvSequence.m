clear
load('../data/sylvseq.mat');
% load frames
load('../data/sylvbases.mat');
% load bases


num_frame = size(frames,3);
rects = zeros(num_frame,4);
rects(1,:) = [102, 62, 156, 108];
% in turns of x1,y1,x2,y2

cell3 = cell(5,1);
cal = 1;

for i=1:num_frame-1
    
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    rect = rects(i,:);
    rect = floor(rect);
    [u,v] = LucasKanadeBasis(It, It1, rect,bases);
    rects(i+1,:) = [rects(i,1)+u,rects(i,2)+v,rects(i,3)+u,rects(i,4)+v];
    % update a new row in rect
    
     if i==2 || i==200 || i==300 || i==350 || i==400
         
        x1 = rects(i,1);
        y1 = rects(i,2);
        x2 = rects(i,3);
        y2 = rects(i,4);
        
        imshow(frames(:,:,i));hold on;
        line([x1,x1],[y2,y1],'Color','r');
        line([x2,x2],[y2,y1],'Color','r');
        line([x1,x2],[y2,y2],'Color','r');
        line([x1,x2],[y1,y1],'Color','r');hold off;
        cell3{cal} = getframe(gca);
        cell3{cal} = cell3{cal}.cdata;
        cal = cal + 1;
     end
            
    
end

% to visualize 5 images
% i.e, the first image: im1 = cell3{1}; imshow(im1);

% save('../results/sylvseqrects.mat','rects');
save sylvseqrects.mat rects

