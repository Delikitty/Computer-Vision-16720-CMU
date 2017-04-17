function [ E ] = essentialMatrix( F, K1, K2 )
% essentialMatrix:
%    F - Fundamental Matrix
%    K1 - Camera Matrix 1
%    K2 - Camera Matrix 2

% Q2.3 - Todo:
%       Compute the essential matrix 
%
%       Write the computed essential matrix in your writeup
E = K2' * F * K1;
% [u,s,v] = svd(E);
% s(3,3) = 0;
% sigma = 0.5 * (s(1,1) + s(2,2));
% s(1,1) = sigma;
% s(2,2) = sigma;
% 
% E = u * s * v';

end

