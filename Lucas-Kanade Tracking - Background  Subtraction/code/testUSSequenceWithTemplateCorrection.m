clear
load('../data/usseq.mat');
% load frames
It0 = frames(:,:,1);
rect0 = [255, 105, 310, 170];

num_frame = size(frames,3);
rects = zeros(num_frame,4);
rects(1,:) = [255, 105, 310, 170];
threshold = 3;
% in turns of x1,y1,x2,y2

cell5 = cell(5,1);
cal = 1;



for i=1:num_frame-1
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    rect = rects(i,:);
    rect = floor(rect);
    [u1,v1] = LucasKanadeInverseCompositional(It, It1, rect);
    rects(i+1,:) = [rects(i,1)+u1,rects(i,2)+v1,rects(i,3)+u1,rects(i,4)+v1];
    
    p0 = rects(i+1,:) - rect0;
    p0 = [p0(1);p0(2)];
    
    [uu,vv] = LK_correct(It0, It1, rect0,p0);
    tmp =  [uu;vv]- p0;
    delta = tmp - [u1;v1];
    
    % norm(delta)
    if norm(delta) < threshold
        u = tmp(1);
        v = tmp(2);
    else
        u = u1;
        v = v1;
    end
    
    rects(i+1,:) = [rects(i,1)+u,rects(i,2)+v,rects(i,3)+u,rects(i,4)+v];
    

    if i==5 || i==25 || i==50 || i==75 || i==99
         
        x1 = rects(i,1);
        y1 = rects(i,2);
        x2 = rects(i,3);
        y2 = rects(i,4);
        
        imshow(frames(:,:,i));hold on;
        line([x1,x1],[y2,y1],'Color','g');
        line([x2,x2],[y2,y1],'Color','g');
        line([x1,x2],[y2,y2],'Color','g');
        line([x1,x2],[y1,y1],'Color','g');hold off;
        cell5{cal} = getframe(gca);
        cell5{cal} = cell5{cal}.cdata;
        cal = cal + 1;
    end
    % rects(i+1,:) = [rects(i,1),rects(i,2),rects(i,3),rects(i,4)];
    % update a new row in rect
    
end

% save('../results/usseqrects-wcrt.mat','rects');

% save the rects

save usseqrects-wcrt.mat rects