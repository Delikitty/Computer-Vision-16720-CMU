% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, p1, p2, R and P to q2_5.mat
clear
%% load data in and set input values
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
row = size(I1,1);
col = size(I1,2);
M = max(row,col);

load('../data/some_corresp.mat');
% load pts1 pts2
p1 = pts1;
p2 = pts2;

load('../data/intrinsics.mat');
% load K1 K2

%% creat matrices accordingly 
M1 = zeros(3,4);
M1(1,1) = 1;
M1(2,2) = 1;
M1(3,3) = 1;
% M1 = [I|0];
[ F ] = eightpoint( pts1, pts2, M );
% using F computed from the eight point algo
[ E ] = essentialMatrix( F, K1, K2 );
[M2s] = camera2(E);
C1 = K1 * M1;

pcell = cell(size(M2s,3),1);
err = zeros(size(M2s,3),1);
num_posz = zeros(size(M2s,3),1);
% all zero matrices for storing P & error value 
% & number of positive Zs in P for four M2s

%% iterate through four M2 and store the outputs
for i=1:size(M2s,3)
    
    C2 = K2 * M2s(:,:,i);
    [ P, error ] = triangulate( C1, p1, C2, p2 );
    pcell{i} = P;
    err(i) = error;
    ind = find(P(:,3)>0);
    % finding the index where Z is positive in P
    num_posz(i) = length(ind);
    
end

%% finding the correct M2 and corresponding P
correct = find(num_posz == size(P,1));
M2 = M2s(:,:,correct);
P = pcell{correct};
% find correct M2 that all z coordinates in P are positive

%% saving results
save q2_5.mat M2 P p1 p2;
