function displayPyramid(pyrmid)
%function displayPyramid(pyrmid)
% inputs: pyrmid - R x C x L; R x C is the size of the input image; L is the number of levels in the pyramid.

[nr, nc, nl]= size(pyrmid);
im2show= zeros(nr, nc*nl);

for il=1:nl
    im2show(1:end,1+(il-1)*nc  :  il*nc) = pyrmid(:,:,il);
end

imshow(im2show,[]);
title('Pyramid of image')


end