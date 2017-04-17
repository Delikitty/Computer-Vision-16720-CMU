clear
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
row = size(I1,1);
col = size(I1,2);
M = max(row,col);

%% test for eightpoint algo, load some_corresp.mat and call eightpoint
% load('../data/some_corresp.mat');
% [ F ] = eightpoint( pts1, pts2, M );
% displayEpipolarF(I1, I2, F);
% save q2_1.mat F M pts1 pts2;

%% test for sevenpoint algo, manually select the points use cpselect
% cpselect(I1,I2);
% manually select 7 points and output them to Workspace as pts1 & pts2
% pts1 = movingPoints1;
% pts2 = fixedPoints1;
% the points I selected were saved in q2_2.mat, along with F, M
% load q2_2.mat;
% [ F ] = sevenpoint( pts1, pts2, M );
% displayEpipolarF(I1, I2, F{1});
% save q2_2.mat F M pts1 pts2;

%% test for RANSAC
% load('../data/some_corresp_noisy.mat');
% % load pts1, pts2
% [ Fran ] = ransacF( pts1, pts2, M );
% displayEpipolarF(I1, I2, Fran);
% [ F8 ] = eightpoint( pts1, pts2, M );
% displayEpipolarF(I1, I2, F8);

%% test for essential mareix 
clear
load('../data/intrinsics.mat');
% load camera intrinsics matrices K1 and K2
load q2_1.mat;
% load F from eight point algo
[ E ] = essentialMatrix( F, K1, K2 )

%% test for correspondence
% load('../data/some_corresp.mat');
% [ F ] = eightpoint( pts1, pts2, M );
% [pts1, pts2] = epipolarMatchGUI(I1, I2, F);
% save q2_5.mat F pts1 pts2;