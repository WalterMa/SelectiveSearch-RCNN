
% Modify these two variables to fit your dataset
idx_file = 'path/to/your/dataset/image_id.txt';
format_string = 'path/to/your/imagefolder/%s.jpg';

% Add the Selective Search IJCV code path
addpath(genpath('./SelectiveSearchCodeIJCV'));

% Read image set index file
fileID = fopen(idx_file);
img_list = textscan(fileID, '%s');
fclose(fileID);
img_list = img_list{:};

% Generating boxes
num_img = length(img_list);
boxes=cell(1,num_img);
fast_mode = true;
fprintf('Generating boxes...\n');  
parfor_progress(num_img);
parfor i = 1:num_img
    img_file = sprintf(format_string, string(img_list(i)));
    img = imread(img_file);
    ss_boxes = selective_search_boxes(img, fast_mode);
    boxes{1, i} = ss_boxes;
    parfor_progress;
end
parfor_progress(0);

% Save
fprintf('Save generated boxes to output.mat.\n'); 
save('output.mat', 'boxes')