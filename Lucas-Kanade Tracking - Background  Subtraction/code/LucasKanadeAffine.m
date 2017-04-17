function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 

p = zeros(6,1);

% initial values of p and M
% so initial M would be unit matrix
 
% It = im2double(It);
% It1 = im2double(It1);

[X,Y] = meshgrid(1:size(It,2),1:size(It,1));
It = interp2(It,X,Y);
[Itdx,Itdy] = gradient(It);
% get X ang Y coordinate in range with It 
% bith X ang Y are of length n

SD = [Itdx(:).*X(:),Itdy(:).*X(:),Itdx(:).*Y(:),Itdy(:).*Y(:),Itdx(:),Itdy(:)];
% a n*2 matrix mutiply a 2*6 matrix yield a n*6 matrix

XY1 = [X(:)';Y(:)';ones(1,length(It(:)))];
% a 3*n matrix corresponding to [x,y,1]' which could mutiplied to M

tol = 0.1;
deltap = ones(6,1);

% initial values of tolerance and deltap

while norm(deltap) > tol
    
    M = [1+p(1), p(3), p(5);
         p(2),1+p(4), p(6);
         0,    0,       1  ];
     
    I_warp = M * XY1;
    % I_warp: a 3*n matrix containing the warped coordinates
    
    warpx = I_warp(1,:);
    ind1 = (warpx >= 1);
    ind2 = (warpx <= size(It,2));
    indx = ind1 & ind2;
    
    warpy = I_warp(2,:);
    ind3 = (warpy >= 1);
    ind4 = (warpy <= size(It,1));
    indy = ind3 & ind4;
    
    ind = indx & indy;
    
    SDtmp = SD(ind,:);
    
    H = SDtmp' * SDtmp;
    % compute the Hessian matrix with updated SD
    
    I_t1 = interp2(It1,warpx(:),warpy(:));
    
    err = I_t1 - It(:);
    err = err(ind);

    % compute the error image I_warp - T
    
    b = SDtmp' * err;
    % compute
    
%     deltap = inv(H) * b;
    deltap = H \ b;
    % norm(deltap)
    % compute deltap
    
    p = p - deltap;
    % update the warp
     
    
end

    M = [1+p(1), p(3), p(5);
         p(2),1+p(4), p(6);
         0,    0,       1  ];

% output - M affine transformation matrix



end
