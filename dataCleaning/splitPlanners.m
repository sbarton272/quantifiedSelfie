%% Rotate tif files
% Start with edge detection to create binary file
% then perform hough line detection 
% to find lines to split on
% go through files and press s to save split and space to tag as not split
% any other key quits
% http://www.mathworks.com/help/images/analyzing-images.html#f11-12512

clear all
close all

ROOT = '..\weeklyPlanners\seperated\front\';
ROOT_SPLIT = '..\weeklyPlanners\seperated\sections\';

% files = dir( [ROOT, '*.jpg'] );

% extract all incomplete split files
fid = fopen('incompleteSplit.txt');
tline = fgetl(fid);
files = {};
while ischar(tline)
    files{end+1} = tline;
    tline = fgetl(fid);
end
fclose(fid);

% iterate through files and split on key press
incompleteFD = fopen('incompleteSplit2.txt', 'w');

for k=1:length(files)
    close all
    fileName = files{k} %file.name(3:end)
    testI = imread( [ROOT, fileName] );
    %figure, imshow(testI);

    % edge detection
    BW = edge(testI, 'sobel', [], 'vertical');
    figure, imshow(BW)

    % hough line detection
    soughtLines = 10;
    [H,theta,rho] = hough(BW);
    P = houghpeaks(H,soughtLines);
    lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',25);

    % extend verticle lines to seperate image
    yMin = 0;
    yMax = size(BW, 2);
    splitLocs = [];
    lineEpsilon = 30;
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        dif = xy(2,:) - xy(1,:);
        dir = dif / norm(dif); % unit vect

        % remake lines for testing purposes
        x = xy(1,1);
        lines(k).point1 = [x, yMin];
        lines(k).point2 = [x, yMax];

        % store unique x locations for splitting
        if ~any( abs(x-splitLocs) < lineEpsilon )
            splitLocs = [splitLocs, x];
        end
    end

    % extract split locations
    splitLocs = sort(splitLocs);
    buffer = 10;
    minRolesWidth = 150;
    startRoles = splitLocs(1) - buffer;
    if splitLocs(2) > (startRoles + minRolesWidth)
        endRoles = splitLocs(2);
        endGoals = splitLocs(3);
    else
        endRoles  = splitLocs(3);
        endGoals = splitLocs(4);
    end
    startGoals = endRoles - buffer;
    endRoles = endRoles + buffer;
    endGoals = endGoals + buffer;
   
    % final pass - try hard coded
    startRoles = 90 - buffer;
    startGoals = 440 - buffer;
    endRoles = 460 + buffer;
    endGoals = 685 + buffer;
    
    % disp lines
    figure, imshow( testI, 'InitialMagnification', 33 ), hold on
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

    end
    
    plot( [startRoles, startRoles] , [yMin, yMax] ,'LineWidth',2,'Color','red');
    plot( [endRoles, endRoles] ,  [yMin, yMax] ,'LineWidth',2,'Color','red');
    plot( [startGoals, startGoals] ,  [yMin, yMax] ,'LineWidth',2,'Color','blue');
    plot( [endGoals, endGoals] ,  [yMin, yMax] ,'LineWidth',2,'Color','blue');
    hold off;

    % split image
    rolesI = imcrop( testI, [startRoles, yMin, endRoles - startRoles, yMax - yMin]);
    goalsI = imcrop( testI, [startGoals, yMin, endGoals - startGoals, yMax - yMin]);
    figure, subplot(1,2,1), imshow(rolesI);
    subplot(1,2,2), imshow(goalsI);
    k = getkey();
    
    if k == 32 
        % press space if don't want to save split
        fprintf(incompleteFD, '%s, ', fileName);
        disp('not saved');
    elseif k == 115
        % press 's' to save split
        rolesName = [ROOT_SPLIT, fileName(1:end-6), '-roles.jpg']
        goalsName = [ROOT_SPLIT, fileName(1:end-6), '-goals.jpg']
        imwrite( rolesI, rolesName );
        imwrite( goalsI, goalsName );
    else
        % otherwise exit
        error('quitting') 
    end
    
    
end

fclose(incompleteFD);