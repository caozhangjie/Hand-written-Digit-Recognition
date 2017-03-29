src:

Every method has been first resized to 28 * 28 by the resize.m if it has a area larger than 64 ((32/4)*(32/4)). For those whose area is smaller than 64, I just cut the edge pixels.

Set1 needs preprocess by fill_large_hole.m in src to make some hole that is too large smaller.
Other methods don't need extra preprocessing and they are input to the dbn.py

You can set the 'train' parameter to select train or predict. If you set it True, just run the dbn.py and you can train the model. If you want to predict, you can set 'threshold' and 'need_zero' paramater in the dbn.py. The parameters for each dataset are as follows:
               threshold      need_zero
hjk_picture       1.0           False
Li Wanjin         0.8           True
number            0.8           True
digits            0.9           False
set1              0.8           True

The train set are in the src directory. I preprocess the original mnist training set to move all the digits to the center of the corresponding images. Because dbn is suffered from the position of the digit for I just concat every line if the image to produce the image feature. And we binarize the training data for the test data are also binarized.

Model is the trained model you use in the predicting phase.



other directories:

The corresponding test set by which has been resized to 28 * 28.


Results:
set1 one error: 8-3.png
number one error: 2-9.png
Li Wanjin one error: 1-2.jpg
hjk_picture no error
digits two errors: 8-3.png 9-3.png