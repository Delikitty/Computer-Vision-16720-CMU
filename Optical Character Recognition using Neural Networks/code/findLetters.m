function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.


%% get the binarized image of input
imgray = rgb2gray(im);
imbw = imbinarize(imgray);

% morphology processing to eliminate main noise & make letter clearer
open = bwareaopen(imbw,50);
se0 = strel('line',8,0);
se90 = strel('line',8,90);
final = imerode(open,se0);
final = imerode(final,se90);
se = strel('disk',1);
bw = imdilate(final,se);

% find the connnected regions : boudingbox and the centroid of boundingbox
S = regionprops(~bw,'BoundingBox','Centroid');
S = struct2cell(S);
num = size(S,2);

%% get the image output with boundingbox for each interested area

delete = cell(1);
for i=1:num
    
    pos = S{2,i}';
    % ignore the non-letter area
    if pos(3)<20
        delete{i} = i;
        continue
    end
  
end

% delete the non-letter area
deleteind = cell2mat(delete);
S(:,deleteind) = [];

%% get the number of lines
% projecting the letters in binary image horizontally
% compute the difference in the summed vector
% there should be a big difference between letters and empty areas
dif = gradient(sum(bw,2));
ind = find(dif~=0);
dif(ind) = 1;
pad = repmat(dif,[1,30]);
see = strel('disk',4);
pad = imdilate(pad,see);
pad = bwareaopen(pad,1000);
line = strel('line',1000,0);
pad = imerode(pad,line);
Dif = diff(pad);
indd = find(Dif(:,1)==1);
line_num = length(indd);

%% cluster the centroid of boundingbox

centroid = S(1,:);
centroid = cell2mat(centroid);
centroid = reshape(centroid,[2,length(centroid)./2]);
% cluster the centroid in line numbers
idx = kmeans(centroid(2,:)',line_num);
refer = [centroid(2,:)',idx];
cal = 1;
% sort it in ascending order
while cal <= line_num
    
    min_now = min(refer(:,1));
    locate = find(centroid(2,:)==min_now);
    indmin = idx(locate);
    samekind = find(idx==indmin);
    idx(samekind) = line_num+cal;
    % set the sorted kinds to infinity
    % so it won't count for minimum
    refer(samekind,1) = inf;
    cal = cal+1;
    
end

idx = idx - line_num;

%% form up lines cell

lines = cell(line_num,1);

for j = 1:line_num
    
    Li_ind = find(idx == j);
    Li = length(Li_ind);
    putmatrix = zeros(Li,4);
    for li = 1:Li
        box = S{2,Li_ind(li)};
        putmatrix(li,:) = [box(1),box(2),box(1) + box(3),box(2) + box(4)];     
    end
       
    lines{j} = putmatrix;
    
end

end
