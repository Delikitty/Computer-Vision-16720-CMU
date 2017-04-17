clear 
close all
imcell = cell(6,1);
%% provided test images
im1 = imread('../images/01_list.jpg');
im2 = imread('../images/02_letters.jpg');
im3 = imread('../images/03_haiku.jpg');
im4 = imread('../images/04_deep.jpg');
% images I made for test
% image 5 is used to test rotation
% image 6 is used to test the connection between letters
im5 = imread('../images/star.jpg');
im6 = imread('../images/testcats.jpg');


imcell{1} = im1;
imcell{2} = im2;
imcell{3} = im3;
imcell{4} = im4;
imcell{5} = im5;
imcell{6} = im6;

%% find letters and put the boundingbox around each of them
for j=1:length(imcell)
    [~, bw] = findLetters(imcell{j});
    S = regionprops(~bw,'BoundingBox','Centroid');
    S = struct2cell(S);
    num = size(S,2);
    figure;
    imshow(imcell{j});hold on;
 
        for i=1:num
    
            pos = S{2,i}';
            % ignore the non-letter area
            if pos(3)<20
                continue
            end
    
            rectangle('Position',pos,'Edgecolor','r');
            hold on;
  
        end
    hold off;
end



