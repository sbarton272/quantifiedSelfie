clear all
close all

ROOT = '..\weeklyPlanners\seperated\turkFiles\roles\';
SAVE_ROOT = 'C:\Users\Spencer\Dropbox\Public\turkFiles\roles\';

path = [ROOT, '*.jpg']
files = dir( path );

for f = files'
    f.name
    I = imread( [ROOT, f.name] );
    I = imresize( I, [1550 NaN] );
    imwrite(I, [SAVE_ROOT, f.name] );
end