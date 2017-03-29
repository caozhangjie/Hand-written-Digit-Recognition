src:

Every method has been first resized to 28 * 28 by the resize.m if its no noise version is also resized. For those whose no noise version is not resized, I just cut the edge pixels. The resized images are in the corresponding test set directory.

Then we preprocess the image to detect the edge in the image by 'Sobel' calculator or by 'Canny' calculator and then fill the blanks in the edge image to reproduce the original image with the "fill_edge_blank.m" file and the "n2edge_process.m" file. The reason to select these two detectors are introduced in the document. The bold_on and sobel_thresholds and detecting method are as follows
                   edge_method   threshold    bold_on   need_zero
hjk_picture_slim      sobel        0.04             0     False
hjk_picture_bold      canny        0.5              -     True
Li Wanjin             none          -               -     False
number_shallow        sobel        0.18             0     True
number_deep           canny        0.5              -     True
digits                sobel        0.2              0     False

Because the thickness of digits in the hjk_picture and number datasets have a relative high variance for the "n2" noise. Bold images are "1.*.png" and "2.0.png" while slim images are "2.*.png" except "2.0.png" for hjk_picture. Deep images are "1.*.png" and while shallow images are "2.*.png" for number. We need to distinguish the bold one and the slim one. For the slim ones, we use canny. For the slim others, we use sobel. The filled edge images are in the corresponding "test set directory/edge/" directory.

Then they are input to the dbn.py. Because the edge image just contain 1 and 0, you can set the threshold to every number in (0,1).
For example, we set it 0.95 in the experiment. We set "need_zero" as above corresponding to the thichness of the line. For Li Wanjin, since the digits have a very deep black color, we directly use threshold 0.35 to extract the digit from the image. And you should modify the "dbn.py" file line 591 from "data2 = centeralize(data)" to "data2 = centeralize(1-data)". Other information are the same as "no_noise".

other directories:

The corresponding n1 test set by which has been resized to 28 * 28.


Results:
hjk_picture b no error
hjk_picture s no error
number s one error: 2-9.png
number b no error    
Li Wanjin   one error: 2-1.png
digits      no error