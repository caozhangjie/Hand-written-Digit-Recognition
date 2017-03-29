src:

Every method has been first resized to 28 * 28 by the resize.m if its no noise version is also resized. For those whose no noise version is not resized, I just cut the edge pixels. The resized images are in the corresponding test set directory.

Then we preprocess the image to detect the edge in the image by 'Sobel' calculator  and then fill the blanks in the edge image to reproduce the original image with the "fill_edge_blank.m" file. The bold_on and sobel_thresholds are as follows
                   sobel_threshold    bold_on
hjk_picture_slim       0.04             0
hjk_picture_bold       0.11             1
Li Wanjin              0.11             1
number                 0.11             1
digits                 0.11             1

Because the thickness of digits in the hjk_picture dataset have a relative high variance. Bold images are "1.*.png" and "2.0.png" while slim images are "2.*.png" except "2.0.png". We need to distinguish the bold one and the slim one. For the slim ones, we just fill one pixel empty hole between full pixels. For the slim others, we can fill two pixel empty hole between full pixels. The filled edge images are in the corresponding "test set directory/edge/" directory.

Then they are input to the dbn.py. Because the edge image just contain 1 and 0, you can set the threshold to every number in (0,1).
For example, we set it 0.95 in the experiment. We set "need_zero" to True in this experiment. Other information is in the "no_noise"'s "readme.txt".

other directories:

The corresponding n1 test set by which has been resized to 28 * 28.


Results:
hjk_picture b no error
            s no error
number      one error: 2-9.png
Li Wanjin   one error: 2-1.png
digits      no error