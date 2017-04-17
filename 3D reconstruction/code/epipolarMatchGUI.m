function [coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, F)
coordsIM1 = [];
coordsIM2 = [];
[sy,sx]= size(I2);

figure(gcf), clf
h_axes1 = subplot(121);
imshow(I1,[]); hold on
xlabel({'Select a point in this image', '(Right-click when finished)'})


subplot 122
imshow(I2,[]);
xlabel({'Verify that the corresponding point', 'is on the epipolar line in this image'})


while 1

  subplot 121

  [x y button] = ginput(1);
  
if (button==3)
break;
end
  if(gca~=h_axes1)
      subplot 121
     title('Please click only in this image')
     continue;
  else
      subplot 121
      title('')
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

  plot(x,y, '*', 'MarkerSize', 10, 'LineWidth', 2);

  subplot 122

  line([xs xe],[ys ye], 'linewidth', 2);

subplot(1,2,2)
hold on;

[x2, y2] = epipolarCorrespondence(I1, I2, F, x, y)
plot(x2, y2, 'ro', 'MarkerSize', 8, 'LineWidth', 3);
coordsIM1 = [coordsIM1; x,y]
coordsIM2 = [coordsIM2; x2, y2]

end

subplot 121, hold off
