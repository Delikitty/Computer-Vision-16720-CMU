% Q2.7 - Todo:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3
clear

%% % read in images and compute M
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
row = size(I1,1);
col = size(I1,2);
M = max(row,col);

%% load the necessary files from data
load('../data/some_corresp.mat');
% load pts1 pts2 for computing F
load('../data/intrinsics.mat');
% load K1 K2 for computing E
load('../data/templeCoords.mat');
% load x1 y1 for computing P

%% preparation for computing 3D points

[ F ] = eightpoint( pts1, pts2, M );
% using F computed from the eight point algo
x2 = zeros(length(x1),1);
y2 = zeros(length(x1),1);

 for num = 1:length(x1)
     
     [ tmpx2, tmpy2 ] = epipolarCorrespondence( I1, I2, F, x1(num), y1(num) );
     x2(num) = tmpx2;
     y2(num) = tmpy2;
     
 end

p1 = [x1 y1];
p2 = [x2 y2];
% p1 p2 are two 288*2 matrices with 2D points in I1 I2

M1 = zeros(3,4);
M1(1,1) = 1;
M1(2,2) = 1;
M1(3,3) = 1;
% M1 = [I|0];

[ E ] = essentialMatrix( F, K1, K2 );
[M2s] = camera2(E);
C1 = K1 * M1;

pcell = cell(size(M2s,3),1);
% err = zeros(size(M2s,3),1);
num_posz = zeros(size(M2s,3),1);
% all zero matrices for storing P & error value 
% & number of positive Zs in P for four M2s

%% iterate through four M2 and store the outputs
for i=1:size(M2s,3)
    
    C2 = K2 * M2s(:,:,i);
    [ P, error ] = triangulate( C1, p1, C2, p2 );
    pcell{i} = P;
    % err(i) = error;
    ind = find(P(:,3)>0);
    % finding the index where Z is positive in P
    num_posz(i) = length(ind);
    
end

%% finding the correct M2 and corresponding P
correct = find(num_posz == size(P,1));
M2 = M2s(:,:,correct);
P = pcell{correct};
PX = P(:,1);
PY = P(:,2);
PZ = P(:,3);

scatter3(PX(:),PY(:),PZ(:),25,'filled');

% save q2_7.mat F M1 M2