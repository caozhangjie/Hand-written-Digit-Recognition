% you can set the source image directory and target image directory in the following parameter
% bold on is a bool parameter about how much you can fill the hollow number in the edge detected image
% canny_threshold is the threshold in the 'Canny' edge detection. The exact values are in the "readme.txt"
source_dir_name = 'source image dir/';
target_dir_name = 'target image dir/';
canny_threshold = 0.5

image_dir = dir(source_dir_name);
length3 = length(image_dir);

for i =1:1:length3
    % this condition statement just to filter none image file, you can set the concrete condition as you like.
    if length(image_dir(i).name) ==14
file_name = [source_dir_name, image_dir(i).name];
temp_image = imread(file_name);
edge_image = edge(temp_image, 'Canny', canny_threshold);
filled_image = imfill(edge_image, 'holes');
siz1 = size(edge_image, 1);
siz2 = size(edge_image, 2);

if sum(sum(filled_image - edge_image)) > 6
    hole_area = filled_image - edge_image;
else
    osum_ = sum(sum(filled_image));
    start = 4;
    end1 = siz1;
    end2 = siz2;
    while start < end1 && start < end2
    for q = start:1:end1
        for w = start:1:end2
            if (edge_image(q-(start-1), w) == 1 && edge_image(q, w) == 1)
                for temptemp = q-(start-1):q
                    filled_image(temptemp,w) = 1;
                end
            end
            if (edge_image(q, w-(start-1)) == 1 && edge_image(q, w) == 1)
                for temptemp = w-(start-1):w
                    filled_image(q, temptemp) = 1;
                end
            end
        end
        sum_ = sum(sum(filled_image));
        if sum_ ~= osum_
            break
        end
        osum_ = sum_;
    end
    start = start + 1;

    end
    
    imwrite(imfill(filled_image, 'holes'), ['n2edgeli/',image_dir(i).name]);
    continue;
end
label1 = bwconncomp(hole_area, 4);
length1 = length(label1.PixelIdxList);
largest_pixel = 0;
li = 0;
smallest_pixel = 785;
for m = 1:1:length1
    if length(label1.PixelIdxList{m})> 0
        if largest_pixel <= label1.PixelIdxList{m}(end) && smallest_pixel >= label1.PixelIdxList{m}(1)
            li = m;
            largest_pixel = label1.PixelIdxList{m}(end);
            smallest_pixel = label1.PixelIdxList{m}(1);
        end
    end
end

t_length = length(label1.PixelIdxList{1,li});
hole_area(label1.PixelIdxList{1,li}) = 0;
imwrite(filled_image - hole_area, [target_dir_name,image_dir(i).name]);
    end
end