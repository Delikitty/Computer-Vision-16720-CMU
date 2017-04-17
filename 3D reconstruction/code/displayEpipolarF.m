function displayEpipolarF(I1, I2, F)
%
% displayEpipolarF(I1, I2, F)
%
% Displays the epipolar lines interactively. I1 and I2
% are the two input images. 
% F is the essential matrix transforming from I1 to I2.
% That is: if m1 is a point in I1 and m2 is a point in
% I2, then the epipolar line has equation:
%              T
%            m2 Fm1
% The program asks to select a point in I1 and displays the
% corresponding line in I2.
%
% Modified 2003, Andrew Stein (Altered display -- one figure instead of 
%  two -- and added directions.  The math is all the same.)
%

[e1 e2] = epipoles(F);

% f1 = figure;
% f2 = figure;

[sy,sx]= size(I2);

%figure(f1);
figure(gcf), clf
h_axes1 = subplot(121);
imshow(I1,[]); hold on
xlabel({'Select a point in this image', '(Right-click when finished)'})


%figure(f2);
subplot 122
imshow(I2,[]);
xlabel({'Verify that the corresponding point', 'is on the epipolar line in this image'})


while 1

  %figure(f1);
  subplot 121

  legend('show');
  [x y button] = ginput(1);
  if(gca~=h_axes1)
      subplot 121
      title('Please click only in this image')
      continue;
  else
      subplot 121
      title('')
  end

  if button == 3
    %figure(f1);
    subplot 121
    if e1(3) ~= 0
      e1 = e1 / e1(3);
      x = e1(1);
      y = e1(2);
      if(x>1 & x<size(I1,2) & y>1 & y<size(I1,1))
          patch([x-5 x-5 x+5 x+5]', [y-5 y+5 y+5 y-5]', 'r');
          title('Epipole position for this image show in red')
      else
          title('Epipole is outside image boundary')
      end
    end
    %figure(f2);
    subplot 122
    if e2(3) ~= 0
      e2 = e2 / e2(3);
      x = e2(1);
      y = e2(2);
      if(x>1 & x<size(I2,2) & y>1 & y<size(I2,1))
          patch([x-5 x-5 x+5 x+5]', [y-5 y+5 y+5 y-5]', 'r');
          title('Epipole position for this image show in red')
      else
          title('Epipole is outside image boundary')
      end
    end
    break;
  end

  xc = x;
  yc = y;

  v(1) = xc;
  v(2) = yc;
  v(3) = 1;

  l = F * v';

  s = sqrt(l(1)^2+l(2)^2);

  if s==0
    error('Zero line vector in displayEpipolar');
  end

  l = l/s;

  if l(1) ~= 0
    ye = sy;
    ys = 1;
    xe = -(l(2) * ye + l(3))/l(1);
    xs = -(l(2) * ys + l(3))/l(1);
  else
    xe = sx;
    xs = 1;
    ye = -(l(1) * xe + l(3))/l(2);
    ys = -(l(1) * xs + l(3))/l(2);
  end

%   line([x x],[y-5 y+5]);
%   line([x-5 x+5], [y, y]);
  plot(x,y, '*', 'MarkerSize', 6, 'LineWidth', 2);

  %figure(f2);
  subplot 122

  % line([ys ye],[xs xe]);
  line([xs xe],[ys ye]);
end


subplot 121, hold off

%
% function [e1,e2] = epipoles(E)
% Returns the epipoles of the matrix E
% in e1 and e2 (in homogeneous/projective coordinates.)
%

function [e1,e2] = epipoles(E)

[U S V] = svd(E);

e1 = (V*[0 0 1]');

[U S V] = svd(E');

e2 = (V*[0 0 1]');
