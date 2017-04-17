function [ P, error ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%
N = size(p1,1);
P = zeros(N,3);

%% interate throught 1 to N & compute each row of P
for i=1:N
    
    A = [p1(i,1) .* C1(3,:) - C1(1,:);
         p1(i,2) .* C1(3,:) - C1(2,:);
         p2(i,1) .* C2(3,:) - C2(1,:);
         p2(i,2) .* C2(3,:) - C2(2,:)];
    % A is a 4*4 matrix and AP = 0 
    [~,~,v] = svd(A);
    tmp = v(:,end)';
    tmp = tmp ./ tmp(4);
    % solve points in P up to scale
    P(i,:) = tmp(1,1:3);   
    
end

%% compute the reprojection error
Ptmp = [P';ones(1,N)];
% Ptmp is a 4*N matrix corresponding to the 3D points in P
p_1 = C1 * Ptmp;
tmp1 = [p_1(3,:);p_1(3,:)];
p_1 = p_1(1:2,:) ./ tmp1;
p_2 = C2 * Ptmp;
tmp2 = [p_2(3,:);p_2(3,:)];
p_2 = p_2(1:2,:) ./ tmp2;
% p_1 and p_2 are coordinates of points in images (up to scale)

error = sum(sum((p1' - p_1).^2 + (p2' - p_2).^2));


end

