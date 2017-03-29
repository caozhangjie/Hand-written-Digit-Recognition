close all;
file_dir = 'image_dir/';
new_file_dir = 'image_dir/';
all_images = dir(['/Users/apple/Documents/MATLAB/pattern_project/', file_dir]);
length1 = size(all_images)-3;
for i = 1:1:length1
    image = imread(['/Users/apple/Documents/MATLAB/pattern_project/', file_dir,all_images(i+3).name]);
    if sum(sum((255 - image)> 0)) > 64
        new_image = imresize(image, [28,28]);
    else
        new_image = image(3:26, 3:26);
    end
    imwrite(new_image, ['/Users/apple/Documents/MATLAB/pattern_project/',new_file_dir, all_images(i+3).name]);
end
