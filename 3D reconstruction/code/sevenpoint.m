function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

N = size(pts1,1);
pts1 = pts1 ./ M;
pts2 = pts2 ./ M;
xp1 = pts1(:,1);
yp1 = pts1(:,2);
xp2 = pts2(:,1);
yp2 = pts2(:,2);
% scaled the data to 0-1

A = [xp1.*xp2,xp1.*yp2,xp1,yp1.*xp2,yp1.*yp2,yp1,xp2,yp2,ones(N,1)];
% where AF(:) = 0

[~,~,V] = svd(A);
F1 = V(:,end);
F1 = reshape(F1,[3,3]);
F1 = F1';
F2 = V(:,end - 1);
F2 = reshape(F2,[3,3]);
F2 = F2';
% find two vectors (F1, F2) that span null space of A.

syms ALPHA;
eqn = det(ALPHA * F1 + (1 - ALPHA) * F2);
% tmp = solve(eqn==0);
eqn = sym2poly(eqn);
alpha = roots(eqn);
alpha = real(alpha);
% get the real part of alpha

F = cell(length(alpha),1);

t = 1 ./ M;
T = [t,0,0;0,t,0;0 0 1];
% using matrix T to unscale F

for i = 1:length(alpha)
    
    F{i} = alpha(i) * F1 + (1 - alpha(i)) * F2;
    F{i} = refineF(F{i},pts1,pts2);
    % refine before unscaling
    F{i} = T' * F{i} * T;
    % unscaling F
end


end

