function [compareX, compareY] = makeTestPattern(patchWidth, nbits) 
%%Creates Test Pattern for BRIEF
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and
% save the results in testPattern.mat.
%
% INPUTS
% patchWidth - the width of the image patch (usually 9)
% nbits      - the number of tests n in the BRIEF descriptor
%
% OUTPUTS
% compareA and compareB - LINEAR indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors. 
patchWidth = 9;
nbits = 256;

compareX = randi(patchWidth.*patchWidth,nbits,1);
compareY = randi(patchWidth.*patchWidth,nbits,1);

save('../results/testPattern.mat','compareX','compareY');
% sigma=9/5;
% compareX=sigma.*randn(nbits,1);
% compareY=sigma.*randn(nbits,1);
end