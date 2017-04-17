function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC

p1 = locs1(matches(:,1),:);
p1 = p1(:,1:2);
p2 = locs2(matches(:,2),:);
p2 = p2(:,1:2);

N=size(p1,1);

% inlier=zeros(1,nIter*4);

p13 = [p1(:,1)';p1(:,2)';ones(1,N)];
p23 = [p2(:,1)';p2(:,2)';ones(1,N)];
inlier = zeros(1,N);

for i = 1:nIter
    
    rand_ind = randperm(size(p1,1),4);
    p1_rand = p1(rand_ind,:);
    p2_rand = p2(rand_ind,:);
    % randomly pick 4 pairs of points to compute original H

    H0 = computeH(p1_rand',p2_rand');
    
 
    % A=H0(3,:)*p2_rand(:,j);
%     H0p23=H0*p23;
%     A=H0p23(3,:);
%     A=[A;A;A];
%     deter=A.*p13-H0*p23;
    p23_d = H0*p23;
    p23_d(1,:) = p23_d(1,:)./p23_d(3,:);
    p23_d(2,:) = p23_d(2,:)./p23_d(3,:);
    deter = p13-p23_d;
    deter = sqrt(sum(deter.^2));
    inlier_current = deter<tol;
    % logistic values and 1 means satisfied deter<tol
    if sum(inlier_current) > sum(inlier)
        inlier = inlier_current;
        % return the inlier with most inlier
    end
    
end

    
  % nonzero_ind=find(inlier~=0);
  % inlier=inlier(nonzero_ind);
  ind = find(inlier~=0);
  p1_inlier = p1(ind,:);
  p2_inlier = p2(ind,:);

  bestH = computeH(p1_inlier',p2_inlier');
  
  % bestH=bestH./bestH(3,3);


end