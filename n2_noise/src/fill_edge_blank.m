% you can set the source image directory and target image directory in the following parameter
% bold on is a bool parameter about how much you can fill the hollow number in the edge detected image
% sobel_threshold is the threshold in the 'Sobel' edge detection. The exact values are in the "readme.txt"
source_dir_name = 'source image dir/';
target_dir_name = 'target image dir/';
bold_on = 0;
sobel_threshold = 0.04;

image_dir = dir(source_dir_name);
length3 = length(image_dir);
for i =1:1:length3
if length(image_dir(i).name) ==14
temp_image = edge(imread([source_dir_name, image_dir(i).name]), 'Sobel', sobel_threshold);
length1 = size(temp_image, 1);
width = size(temp_image, 2);
sum_ = sum(sum(temp_image));
osum_ = sum_;
while 1
for k = 1:1:length1
    for j = 1:1:width
        if j < width-2
            if temp_image(k, j) == 1 && temp_image(k, j+2) == 1 && sum(temp_image(1:k, j+1)) > 0 && sum(temp_image(k:length1, j+1)) > 0
                temp_image(k, j+1) = 1;
            end
            if bold_on
            if temp_image(k, j) == 1 && temp_image(k, j+3) == 1
                temp_image(k, j+1) = 1;
                temp_image(k, j+2) = 1;
            end
            end
        end
    end
end
for j = 1:1:width
    for k = 1:1:length1
        if k < length1-2
            if temp_image(k, j) == 1 && temp_image(k+2, j) == 1
                temp_image(k+1, j) = 1;
            end
            if bold_on
            if temp_image(k, j) == 1 && temp_image(k+3, j) == 1
                temp_image(k+1, j) = 1;
                temp_image(k+2, j) = 1;
            end     
            end
        end
    end
end
sum_ = sum(sum(temp_image));
if osum_ == sum_
    break
end
osum_ = sum_;
end


label1 = bwlabel(temp_image);
label2 = cell(30);
for l = 1:1:30
    label2{l} = 0;
end
for k = 1:1:length1
    for j = 1:1:width    
        label2{label1(k,j)+1} = label2{label1(k,j)+1} + 1;
    end
end

for k = 1:1:length1
    for j = 1:1:width    
        if label2{label1(k,j)+1} < 20
            temp_image(k,j) = 0;
        end
    end
end
imwrite(temp_image, [target_dir_name,image_dir(i).name]);
end
end
