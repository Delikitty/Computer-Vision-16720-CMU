function [u,v] = LK_correct(It0, It1, rect0,p0)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% rect is the 4-by-1 vector that represents a rectangle on the image frame It. 
% The four components of the rectangle are [x1, y1, x2, y2]
% where (x1, y1) is the top-left corner 
%       (x2, y2) is the bottom- right corner.

%% PRE-COMPUTED
% 
x1 = rect0(1);
x2 = rect0(3);
y1 = rect0(2);
y2 = rect0(4);
% coordinate of 4 corner
[xt,yt] = meshgrid(min(x1,x2):max(x1,x2),min(y1,y2):max(y1,y2));
% grid with respect to template T
It0 = im2double(It0);
It1 = im2double(It1);
% I_t = interp2(It,xt,yt);
I_t = interp2(It0,xt,yt);
% template T in frame I_t

[Itx,Ity] = gradient(I_t);
% evaluate gradient of template T

% evaluate the Jacobian dW/dp at (x,0): it's a constant

sd = [Itx(:),Ity(:)];
% compute the steepest descent images = Jacobian.gradient = gradient
H = sd' * sd;
% compute the inverse Hessian matrix


%% ITERATE
% iterate until nrom of the vector deltap is below a threshold

p = p0;
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
    b = sd' * err(:);
    % compute
    
    deltap = inv(H) * b;
    % norm(deltap)
    % compute deltap
    
    p = p - deltap;
    % update the warp
    
    
end

u = p(1);
v = p(2);

% output - movement vector, [u,v] in the x- and y-directions.
end


