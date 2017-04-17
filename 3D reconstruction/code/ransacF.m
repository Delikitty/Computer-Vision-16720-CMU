function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using sevenpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made

N = size(pts1,1);
inlier = zeros(1,N);
iter = 50;
tol = 1;
deter = zeros(1,N);

% x1tmp = [pts1(:,1)';pts1(:,2)';ones(1,N)];
% x2tmp = [pts2(:,1)';pts2(:,2)';ones(1,N)];

for i =1:iter
    
    rand_ind = randperm(N,7);
    pts1rand = pts1(rand_ind,:);
    pts2rand = pts2(rand_ind,:);
    
    [ F7 ] = sevenpoint( pts1rand, pts2rand, M );
    % compute F with randomly chosed points
    
    for j = 1:length(F7)
        
    
%     detertmp = zeros(1,length(F));
    
%     for j=1:length(F)
%         detertmp(j) = norm(x2tmp' * F{j} * x1tmp);
%     end
%     
%     [~,indmin] = min(detertmp);

      % deter = x2tmp' * F7{j} * x1tmp;
      for num=1:N
          tmp1 = [pts1(num,1);pts1(num,2);1];
          epline = F7{j} * tmp1;
          epline = epline / norm(epline(1:2,:));
          a = epline(1);
          b = epline(2);
          c = epline(3);
          % tmp2 = [pts2(num,1);pts2(num,2);1];
          deter(num) = a*pts2(num,1)+b*pts2(num,2)+c;
      end
      
%       deter = F7{j} * x1tmp;
%       deter = deter ./ norm(deter);
%       deter = x2tmp .* deter;
      
      deter = abs(deter);
      inlier_now = deter < tol;
      if sum(inlier_now) > sum(inlier)
          inlier = inlier_now;
          sum(inlier)
          % report the num of current num of inliers
          F = F7{j};
      end
    end
    
end

% ind = find(inlier ~= 0);
% 
% pts1inlier = pts1(ind,:);
% pts2inlier = pts2(ind,:);
% length(pts1inlier)
% [ F ] = sevenpoint( pts1inlier, pts2inlier, M );
    
end