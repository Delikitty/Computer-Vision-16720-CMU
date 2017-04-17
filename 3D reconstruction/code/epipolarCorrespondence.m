function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup

%% % compute the scaled epipolar line
P1 = [x1;y1;1];
epline = F * P1;
epline = epline / norm(epline);
a = epline(1);
b = epline(2);
c = epline(3);


% zeroside = repmat(zeros(row,step),[1,1,3]);
% im1tmp = [zeroside,im1,zeroside];
% im2tmp = [zeroside,im2,zeroside];
% zerotop = repmat(zeros(step,col+2*step),[1,1,3]);
% im1 = [zerotop;im1tmp;zerotop];
% im2 = [zerotop;im2tmp;zerotop];

%% set up parameters' value
step = 10;
sigma = 5;
mindis = inf;
% set the initial value of didtance to be infinity

%% preparation 
Gfilter = fspecial('gaussian', [2 * step + 1,2 * step + 1],sigma);
x1 = round(x1);
y1 = round(y1);
patch1 = im1((y1 - step):(y1 + step),(x1 - step):(x1 + step));
% small patch in im1 centered at x1, y1

%% iterating along the epline to find matched x2, y2
for i = y1-sigma*step:y1+sigma*step
    % a roughly 'match' of y2

    x2_now = (-b * i - c) ./ a;
    % compute x2 with different y2: a*x2 + b*y2 + c = 0
    x2_now = round(x2_now);
    
    if x2_now-step > 0 && x2_now+step < size(im2,2) && i-step>0 && i+step<=size(im2,1)
        
        patch2 = im2(i-step:(i+step),x2_now-step:(x2_now+step));
        % small patch in im2 centered at x2, y2
        dis = double(patch1) - double(patch2);
        weightdis = Gfilter .* dis;
        err = sqrt(sum(weightdis(:).^2));
        
        if err < mindis
            mindis = err;
            x2 = x2_now;
            y2 = i;
            % keep x2 y2 with the smallest error
        end
        
    end

end
      
end