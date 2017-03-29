src(the same as n1 noise):

Every method has been first resized to 28 * 28 by the resize.m if its no noise version is also resized. For those whose no noise version is not resized, I just cut the edge pixels. The resized images are in the corresponding test set directory.

Then we preprocess the image to detect the edge in the image by 'Sobel' calculator  and then fill the blanks in the edge image to reproduce the original image with the "fill_edge_blank.m" file. The bold_on and sobel_thresholds are as follows
                   sobel_threshold    bold_on    threshold    need_zero
hjk_picture            0.02             0           0.95        True
Li Wanjin               -               -           0.77        True
number                 0.04             0           0.95        True

Because the thickness and color of digits in the hjk_picture and number dataset are not distinguished by threshold, we use edge preprocessing. 

Then they are input to the dbn.py. Because the edge image just contain 1 and 0, you can set the threshold to every number in (0,1).
For example, we set it 0.95 in the experiment. We set "need_zero" to True in this experiment. For Li Wanjin, since the digits have a very deep black color, we directly use threshold 0.77 to extract the digit from the image. Other information is in the "no_noise"'s "readme.txt".

other directories:

The corresponding n1 test set by which has been resized to 28 * 28.


Results:
hjk_picture one error: 3.2.png
number      one error: 3.2.png
Li Wanjin   no error