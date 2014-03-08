%% OCR Test
% Attempt to read text with OCR

clear all
close all

TEST_IMG = 'testEvaluation.jpg';

testI = imread(TEST_IMG);
testI = imresize(testI, .125);
testI = imrotate(testI, 180);
figure, imshow(testI);

% edge detection
BW = edge(testI,'canny'); % slightly better line detection results
figure, imshow(BW);

% OCR Test
% Convert to BW
threshold = graythresh(testI);
imagen =~im2bw(testI,threshold);
% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
figure, imshow(imagen);
pause
%Storage matrix word from image
word=[ ];
re=imagen;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
load templates
global templates
% Compute the number of letters in template file
nLetters = size(templates,2)
while 1
    %Fcn 'lines' separate lines in text
    [fl re]=lines(re);
    imgn=fl;
    %Uncomment line below to see lines one by one
    imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
        imshow(img_r);pause(0.5)
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        letter=read_letter(img_r,nLetters);
        % Letter concatenation
        word=[word letter];
    end
    %fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
    fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
end
fclose(fid);
