
# Soft-SVM algorithm using Gaussian rbf kernel implementation as a quadratic programming

## Running the soft-svm implementation

`function w = softsvmrbf(lambda, sigma, m, d, Xtrain, Ytrain)`

The input parameters are:

* lambda - the parameter λ of the soft SVM algorithm.
* sigma - the bandwidth parameter σ of the RBF kernel
* m - the size of the training sample S = ((x1, y1), . . . ,(xm, ym)), an integer m ≥ 1.
* d - the number of features in each example in the training sample, and integer d ≥ 1.
* Xtrain - a 2-D matrix of size m × d. Row i in this matrix is a vector with d coordinates that describes example xi from the training sample.
* Ytrain - a column vector of length m. The i’s number in this
vector is the label yi from the training sample. You can assume that each label is either −1 or 1.

The function returns the variable alpha. This is the vector of coefficients found by the algorithm, α ∈ R^m, a column vector of length m.

## Cross Validation Testing of the soft-svm kernel rbf implementation

The algorithm was tested using the "R2data.mat" file, containing 1000 training examples and 100 test points in of R^2 data points labeled  {−1, 1}.

10-fold cross-validation to tune λ and σ were preformed. 9 parameter pairs were tested: the values λ ∈ {0.01, .1, 1} and σ ∈ {0.05, 1, 2}.

![10-fold cross-validation with different λ and σ values](/images/CV-softsv-rbf.png)

## Illustration of the decision boundary in R^2

The region in which the training data resides was divided
into a fine grid. The grid points were colored red or green, depending on where they fall under the classifier’s prediction.

![soft-svm error for different λ values and sample sizes](/images/decision_boundary_colored_kernel_rbf_soft_svm.PNG)