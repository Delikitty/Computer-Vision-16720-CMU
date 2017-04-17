clear
load('../data/carseq.mat');
% load frames

num_frame = size(frames,3);
rects = zeros(num_frame,4);
rects(1,:) = [60, 117, 146, 152];

cell1 = cell(5,1);
cal = 1;
% in turns of x1,y1,x2,y2
for i=1:num_frame-1
    
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    rect = rects(i,:);
    rect = floor(rect);
    [u,v] = LucasKanadeInverseCompositional(It, It1, rect);
    rects(i+1,:) = [rects(i,1)+u,rects(i,2)+v,rects(i,3)+u,rects(i,4)+v];
    % update a new row in rect
    
    
    if i==2 || i==100 || i==200 || i==300 || i==400
       
        x1 = rects(i,1);
        y1 = rects(i,2);
        x2 = rects(i,3);
        y2 = rects(i,4);
        
        imshow(frames(:,:,i));hold on;
        line([x1,x1],[y2,y1],'Color','r');
        line([x2,x2],[y2,y1],'Color','r');
        line([x1,x2],[y2,y2],'Color','r');
        line([x1,x2],[y1,y1],'Color','r');
        title(['frame = ',num2str(i)]);hold off;


        cell1{cal} = getframe(gca);
        cell1{cal} = cell1{cal}.cdata;
        cal = cal + 1;
        
    end
    
end

% to visualize 5 images
% i.e, the first image: im1 = cell1{1}; imshow(im1);

% save('../results/carseqrects.mat','rects');
save carseqrects.mat rects
% save the rects
        
