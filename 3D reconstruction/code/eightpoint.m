function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup


% load('../data/some_corresp.mat')
% I1 = imread('../data/im1.png');

%% % scaled the data to 0-1
N = size(pts1,1);
pts1 = pts1 ./ M;
pts2 = pts2 ./ M;
xp1 = pts1(:,1);
yp1 = pts1(:,2);
xp2 = pts2(:,1);
yp2 = pts2(:,2);

%% compute F
A = [xp1.*xp2,xp1.*yp2,xp1,yp1.*xp2,yp1.*yp2,yp1,xp2,yp2,ones(N,1)];
% where AF(:) = 0

[~,~,V] = svd(A);
F = V(:,end);
F = reshape(F,[3,3]);
F = F';
% [F11,F12,F13...F31,F32,F33]' = F(:), span null space of A

[u,s,v] = svd(F);
s(3,3) = 0;
% closest fundamental mareix: set sigma3 = 0   
F = u * s * v';
% enforce the singularity condition of the F before unscaling

F = refineF(F,pts1,pts2);
% refine F before doing unscaling

%% % unscaling F
t = 1 ./ M;
T = [t,0,0;0,t,0;0 0 1];
F = T' * F * T;


end

