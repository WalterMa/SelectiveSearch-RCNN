fprintf('Demo of how to run the code for:\n');
fprintf('Generate Slective Seach boxes used in RCNN and Fast RCNN\n');

%% Complie dependencies

cd SelectiveSearchCodeIJCV
% Compile anisotropic gaussian filter
if(~exist('anigauss'))
    fprintf('Compiling the anisotropic gauss filtering of:\n');
    fprintf('   J. Geusebroek, A. Smeulders, and J. van de Weijer\n');
    fprintf('   Fast anisotropic gauss filtering\n');
    fprintf('   IEEE Transactions on Image Processing, 2003\n');
    fprintf('Source code/Project page:\n');
    fprintf('   http://staff.science.uva.nl/~mark/downloads.html#anigauss\n\n');
    mex Dependencies/anigaussm/anigauss_mex.c Dependencies/anigaussm/anigauss.c -output anigauss
end

if(~exist('mexCountWordsIndex'))
    mex Dependencies/mexCountWordsIndex.cpp
end

% Compile the code of Felzenszwalb and Huttenlocher, IJCV 2004.
if(~exist('mexFelzenSegmentIndex'))
    fprintf('Compiling the segmentation algorithm of:\n');
    fprintf('   P. Felzenszwalb and D. Huttenlocher\n');
    fprintf('   Efficient Graph-Based Image Segmentation\n');
    fprintf('   International Journal of Computer Vision, 2004\n');
    fprintf('Source code/Project page:\n');
    fprintf('   http://www.cs.brown.edu/~pff/segment/\n');
    fprintf('Note: A small Matlab wrapper was made.\n'); 
    mex Dependencies/FelzenSegment/mexFelzenSegmentIndex.cpp -output mexFelzenSegmentIndex;
end

cd ..

%% Generate Slective Seach boxes

% Add the Selective Search IJCV code path
addpath(genpath('./SelectiveSearchCodeIJCV'));

fast_mode = true;
img = imread('./SelectiveSearchCodeIJCV/000015.jpg');


ss_boxes = selective_search_boxes(img, fast_mode);

% Draw boxes
imshow(img);
axis on;
hold on;
for n = 1: 10:length(ss_boxes)
    box = ss_boxes(n, :);
    % box co-ordinates: [ymin, xmin, ymax, xmax], 1-based index
    xmin = box(2);
    ymin = box(1);
    w = box(4) - box(2);
    h = box(3) - box(1);
    rectangle('Position', [xmin,ymin,w,h], 'EdgeColor','g','LineWidth',1)
end
