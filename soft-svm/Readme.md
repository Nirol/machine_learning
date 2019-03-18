
# Soft-SVM algorithm implementation as a quadratic programming

## Running the soft-svm implementation

`function w = softsvm(lambda, m, d, Xtrain, Ytrain)`

The input parameters are:

* lambda - the parameter λ of the soft SVM algorithm.
* m - the size of the training sample S = ((x1, y1), . . . ,(xm, ym)), an integer m ≥ 1.
* d - the number of features in each example in the training sample, and integer d ≥ 1.
* Xtrain - a 2-D matrix of size m × d. Row i in this matrix is a vector with d coordinates that describes example xi from the training sample.
* Ytrain - a column vector of length m. The i’s number in this
vector is the label yi from the training sample. You can assume that each label is either −1 or 1.

The function returns the variable w. This is the linear predictor w ∈ R^d, a column vector of length d.

## Testing of the soft-svm implementation

The algorithm was tested using MNIST handwritten digits dataset.
Two samples of sizes 50 and 1000 were generated from the dataset using the gnsmallm.m file, each sample was used with multiple λ values to build and test a soft-svm classifier.
The actual λ values that were used are 10^( the λ denoted on the x axis )

Test error as a function of λ is given for the two different sample sizes:

![soft-svm error for different λ values and sample sizes](/images/soft_svm_error_both.png)

## Picturization of a low error classifier

Heatmap drawing of a classifier as 28 x 28 pixels image, each pixel represent the value of the coordinate of the classifier w that matches the pixel.
In the heatmap each pixel with above average value was colored red and green otherwise.

Note:
    Each image in MNIST has 28 by 28 pixels, and each pixel has a value, indicating how dark it is. Each example is described by a vector listing the 28 · 28 = 784 pixel values.

Using only samples containing the digits 5 and 3 from the MNIST dataset, pictures of the digits 3 were labeled '-1' and pictures of the digit 5 were labeled '1'.

Pixels that are normally used to handwrite the digit 3 were lower than average value (green color ), while pixels that are normally used to handwrite the digit 5 had higher than average value (red color).
![soft-svm error for different λ values and sample sizes](/images/classifier.png)