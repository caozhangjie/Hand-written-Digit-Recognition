all_images = dir('image_dir/');
length3 = length(all_images) - 3;
up_bound = 130;
lower_bound = 50;
for o =1:1:length3
   
file_name = ['image_dir/', all_images(o+3).name]
image1 = 1- imread(file_name);
[filled_image, ~] = imfill(image1, 'holes');
label1 = bwlabel(filled_image - image1);
siz = size(label1);
length1 = siz(1);
width = siz(2);
object1 = {};
for i = 1:1:10
    object1{i} = {};
    object1{i}{1} = 0;
    object1{i}{2} = [];
    object1{i}{3} = 0;
    object1{i}{4} = 0;
    for j =1:1:length1
        for k =1:1:width
            if label1(j, k) == i
                object1{i}{1} = object1{i}{1} + 1;
                object1{i}{2} = [object1{i}{2}; [j,k]];
                object1{i}{3} = object1{i}{3} + j;
                object1{i}{4} = object1{i}{4} + k;
            end
        end
    end
    length2 = size(object1{i}{2}, 1);
    new_data = zeros(length1, width);
    if length2 > 0
    for j = 1:1:length2
        new_data(object1{i}{2}(j, 1), object1{i}{2}(j, 2)) = 1;
    end
    end
    object1{i}{2} = new_data;
    object1{i}{3} = object1{i}{3} / length2;
    object1{i}{4} = object1{i}{4} / length2;
end
for i = 1:1:10
    while object1{i}{1} > 60
        new_data = object1{i}{2};
        new_data2 = object1{i}{2};
        line_first = [];
        line_last = [];
        column_first = [];
        column_last = [];
        for q = 1:1:length1
            for t = 1:1:width
                if filled_image(q,t) == 1
                    line_first = [line_first, t];
                    break
                end  
                if t == width
                    line_first = [line_first, 0];
                end
            end
            for t = 1:1:width
                if filled_image(q,width-t+1) == 1
                    line_last = [line_last, width-t+1];
                    break
                end    
                if t == width
                    line_last = [line_last, 0];
                end
            end
        end
        for t = 1:1:width
            for q = 1:1:length1
                if filled_image(q,t) == 1
                    column_first = [column_first, q];
                    break
                end  
                if q == length1
                    column_first = [column_first, 0];
                end
            end
            for q = 1:1:length1
                if filled_image(length1-q+1, t) == 1
                    column_last = [column_last, length1-q+1];
                    break
                end   
                if q == length1
                    column_last = [column_last, 0];
                end                
            end
        end
        for q = 1:1:length1
            if (line_first(q) - object1{i}{4})^2 + (q - object1{i}{3})^2 <= up_bound ...
                    && (line_first(q) - object1{i}{4})^2 + (q - object1{i}{3})^2 >= lower_bound
                filled_image(q, line_first(q)) = 0;
            end
            if (line_last(q) - object1{i}{4})^2 + (q - object1{i}{3})^2 <= up_bound ...
                    && (line_last(q) - object1{i}{4})^2 + (q - object1{i}{3})^2 >= lower_bound
                filled_image(q, line_last(q)) = 0;
            end
        end
        for t = 1:1:width
            if (column_first(t) - object1{i}{3})^2 + (t - object1{i}{4})^2 <= up_bound ...
                    && (column_first(t) - object1{i}{3})^2 + (t - object1{i}{4})^2 >= lower_bound
                filled_image(column_first(t), t) = 0;
            end
            if (column_last(t) - object1{i}{3})^2 + (t - object1{i}{4})^2 <= up_bound ...
                    && (column_last(t) - object1{i}{3})^2 + (t - object1{i}{4})^2 >= lower_bound
                filled_image(column_last(t), t) = 0;
            end
        end
        for l = 1:1:length1
            for j =1:1:width
                if 1 < l && l <= length1 &&  1 < j && j <= width
                    if new_data(l-1, j) == 0 && new_data(l, j) == 1
                        new_data2(l,j) = 0;
                    end
                    if new_data(l-1, j) == 1 && new_data(l, j) == 0
                        new_data2(l-1,j) = 0;
                    end
                    
                    if new_data(l, j-1) == 0 && new_data(l, j) == 1
                        new_data2(l,j) = 0;
                    end
                    if new_data(l, j-1) == 1 && new_data(l, j) == 0
                        new_data2(l,j-1) = 0;
                    end                    
                end
            end
        end
        object1{i}{1} = sum(sum(new_data2));
        object1{i}{2} = new_data2;
    end
end 
for i = 1:1:10
    filled_image = filled_image - object1{i}{2};
end
for i = 1:1:length1
            for j =1:1:width
                if 1 < i && i <= length1 - 1 &&  1 < j && j <= width - 1
                    if sum(sum(filled_image((i-1):(i+1), (j-1):(j+1)))) == 4
                        if sum(sum(filled_image((i-1):(i), (j-1):(j))))  == 4 ...
                            || sum(sum(filled_image((i):(i+1), (j-1):(j))))  == 4 ...
                            || sum(sum(filled_image((i-1):(i), (j):(j+1))))  == 4 ...
                            || sum(sum(filled_image((i):(i+1), (j):(j+1))))  == 4
                            filled_image(i,j) = 0;
                        end
                    end
                end
            end
end
imwrite((1- filled_image), ['image1/',all_images(o+3).name]);
end