function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left
% both right coordinates), bases 
%% PRE-COMPUTED
% change in : SGD ang matrix H, others are the same
x1 = rect(1);
x2 = rect(3);
y1 = rect(2);
y2 = rect(4);
% coordinate of 4 corner
[xt,yt] = meshgrid(min(x1,x2):max(x1,x2),min(y1,y2):max(y1,y2));
% grid with respect to template T, xt,yt: 47*55 
It = im2double(It);
It1 = im2double(It1);
% I_t = interp2(It,xt,yt);
I_t = interp2(It,xt,yt);
% 47*55 double
[Itx,Ity] = gradient(I_t);
% evaluate gradient of template T
% Itx,Ity: 47*55

num_basis = size(bases,3);
% bases: 47*55*10
SD = [Itx(:),Ity(:)];
for i=1:num_basis
    bas = bases(:,:,i);
    % bas: 47*55
    tmp = bas(:)' * SD;
    tmp1 = tmp' * bas(:)';
    SD = SD - tmp1';
    
end

% compute the steepest descent images 

H = SD' * SD;
% compute the inverse Hessian matrix

%% First find the optimize p
% iterate until nrom of the vector deltap is below a threshold

p = [0 0]';
deltap = [1 1]';
tol = 0.01;
% initial value of p and deltap
while norm(deltap) > tol
    [xi,yi] = meshgrid(min(x1,x2)+p(1):max(x1,x2)+p(1),min(y1,y2)+p(2):max(y1,y2)+p(2));
    % [xi,yi] = meshgrid(min(x1,x2):max(x1,x2)+p(1),min(y1,y2):max(y1,y2)+p(2));
    % grid with respect to I,i.e,(x+u,y+v)

    I_t1 = interp2(It1,xi,yi);
    % warp I with W to compute I_warp
    
    err = I_t1 - I_t;
    % compute the error image I_warp - T
    b = SD' * err(:);
    % compute
    
    deltap = inv(H) * b;
    % norm(deltap)
    % compute deltap
    
    p = p - deltap;
    % update the warp
    
end

[xp,yp] = meshgrid(min(x1,x2)+p(1):max(x1,x2)+p(1),min(y1,y2)+p(2):max(y1,y2)+p(2));
I_t1p = interp2(It1,xp,yp);
% use the optimal p warp I

lamda = zeros(num_basis,1);
for j=1:num_basis
    bass = bases(:,:,j);
    tmp2 = bass .* (I_t1p - I_t);
    lamda(j) = sum(tmp2(:));
end

u = p(1);
v = p(2);
    

% output - movement vector, [u,v] in the x- and y-directions.
end