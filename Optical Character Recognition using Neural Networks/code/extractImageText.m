function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the text contained in the image as a string.

im = imread(fname);
[lines, bw] = findLetters(im);
load('finetune36_Wb.mat');
% load('WB_76.mat');

letter = char(65:90);
num = '0123456789';
label = [letter,num];
text = cell(1);
cal = 1;
space = char(32);
enter = char(10);

for i = 1:length(lines)
    
    thisline = lines{i};
    allpos1 = thisline(:,1);
    diss = diff(allpos1);
    threshold = mean(diss);
    num = size(thisline,1);
    % the number of letter or number in ith row
    for j=1 : num
        
        pos = round(thisline(j,:));
        data = bw(pos(2):pos(4),pos(1):pos(3));
        %% resize text to 32*32 for classification
        % simply reshape may stretch or compress the text
        % I reshape the text along larger dimension to 32 first
        % pad another dimension with 1 (white)
        if size(data,1)==size(data,2)
            data = imresize(data,[32,32]);
        end
        
        if size(data,1)>size(data,2)
            
            data = imresize(data,[32,NaN]);
            col = size(data,2);
            if mod(32-col,2)==0
                data = padarray(data,[0,(32-col)./2],1);
            else
                data = padarray(data,[0,((32-col)-1)./2],1);
                data = [data,ones(32,1)];
            end
        elseif size(data,1)<size(data,2)
            
            data = imresize(data,[NaN,32]);
            row = size(data,1);
            if mod(32-row,2)==0
                data = padarray(data,[(32-row)./2,0],1);
            else
                data = padarray(data,[((32-row)-1)./2,0],1);
                data = [data;ones(1,32)];
            end            
          
        end
        
        % compute the prediction
        [outputs] = Classify(W, b, data(:)');
        [~,ind] = max(outputs);
        
        if j~=num
            pos_next = round(thisline(j+1,:));
            % if it's letter in words, find the label
            % else insert a space
            % the threshold is average distance among bounding boxes
            if abs(pos(1) - pos_next(1))< 1.35*threshold
                text{cal} = label(ind);
                cal = cal+1;
            else
                text{cal} = label(ind);
                cal = cal+1;
                text{cal} = space;
                cal = cal+1;
            end
            % insert enter in the end of a line 
        else
            text{cal} = label(ind);
            cal = cal+1;
            text{cal} = enter;
            cal = cal+1;           
        end
        
    end  
    
end


end
