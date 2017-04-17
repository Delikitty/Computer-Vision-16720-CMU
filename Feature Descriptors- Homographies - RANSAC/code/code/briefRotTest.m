function briefRotTest
im1 = imread('../data/model_chickenbroth.jpg');
num_match = zeros(1,37);

if size(im1,3) == 3
    im1 = rgb2gray(im1);
end
im1 = im2double(im1);
[locs1, desc1] = briefLite(im1);

for i = 0:36
    im2 = imrotate(im1,i*10);
    H_rot = [cos(pi*i/360),  sin(pi*i/360), 0;
             -sin(pi*i/360), cos(pi*i/360), 0; 
             0,              0,             1];
    % rotation homography
    [locs2, desc2] = briefLite(im2);
    [matches] = briefMatch(desc1, desc2);
    locs1 = locs1(:,1:2);
    locs2 = locs2(:,1:2);
    
    locs1_match = locs1(matches(:,1),:);
    locs2_match = locs2(matches(:,2),:);
    
    locs1_match = [locs1_match(:,1)';locs1_match(:,2)';ones(1,size(locs1_match,1))];
    locs1_rot = H_rot * locs1_match;
    % rotated location of original image
    locs1_rot = [locs1_rot(1,:)',locs1_rot(2,:)'];
    
    dis = locs1_rot - locs2_match;
    dis = dis.^2;
    err = sum(dis,2);
    err = err < 25;
    % if the error less than certain value
    % count as a correct match
    num_match(1,i+1) = sum(err);
    % calculate the number of matches for each rotation
end
bar(0:10:360,num_match);
xlim([0,360]);
% bar(num_match,0.5);
xlabel('(Rotate degree)');
ylabel('Matches number');

end

% Script to test BRIEF under rotations