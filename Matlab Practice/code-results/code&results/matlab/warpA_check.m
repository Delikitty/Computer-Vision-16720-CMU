function warp_im=warpA_check(im, A, out_size)
% warp_im=warpA(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A producing
% (out_size(1),out_size(2)) output image warp_im
% with warped = A*input, warped spanning 1..out_size
% Remove last row (must be 0 0 1) and transpose because tform uses
% post-multiplication
%
% Args:
%     im (image, shape (w, h, 1)): Input image
%     A (matrix, shape (3, 3)): Warp matrix
%     out_size (array, length 2): Specified output image size.
%
% Returns:
%     warp_im (image, shape (out_size(1), out_size(2)))

A = A(1:2, :)';
tform = maketform( 'affine', A);
 % change 'nearest' to 'bilinear' to compare with 'warpAbilinear'
warp_im = imtransform( im, tform, 'nearest', ...
'XData', [1 out_size(2)], ...
'YData', [1 out_size(1)], 'Size', out_size );

end