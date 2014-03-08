%% Rotate tif files
% Start with edge detection to create binary file
% then perform hough line detection
% http://www.mathworks.com/help/images/analyzing-images.html#f11-12512

clear all
close all

TEST_IMG = 'testPlanner.jpg';

testI = imread(TEST_IMG);
testI = imresize(testI, .125);
figure, imshow(testI);

% edge detection
BW = edge(testI,'canny'); % slightly better line detection results
figure, imshow(BW)

% hough line detection
soughtLines = 20;
[H,theta,rho] = hough(BW);
P = houghpeaks(H,soughtLines);
lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',30);
figure, imshow(testI), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');



