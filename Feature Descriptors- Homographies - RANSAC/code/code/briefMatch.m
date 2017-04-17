function [matches] = briefMatch(desc1, desc2, ratio)
%function [matches] = briefMatch(desc1, desc2, ratio)
% Performs the descriptor matching
% inputs  : desc1 , desc2 - m1 x n and m2 x n matrix. m1 and m2 are the number of keypoints in image 1 and 2.
%						    n is the number of bits in the brief
% outputs : matches - p x 2 matrix. where the first column are indices
%									into desc1 and the second column are indices into desc2

if nargin<3
    ratio = .8;
end

% compute the pairwise Hamming distance
[D,I] = pdist2(desc2,desc1,'hamming','Smallest',2);
ix = 1:size(desc1,1);

% suprress match between descriptors that are not distriminative.
r = D(1,:)./D(2,:); 
ix = ix(r < ratio | isnan(r)); 
I2 = I(1,r < ratio | isnan(r));
 
%output
matches = [ix' I2'];


end