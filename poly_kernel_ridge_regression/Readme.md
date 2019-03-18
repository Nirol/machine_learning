
# Kernel ridge regression algorithm using polynomial kernel implementation as a quadratic programming

## Running the regression implementation

`function p = polyridgereg(lambda, n, m, X, Y)`

The input parameters are:

* lambda - the parameter λ of the  kernel ridge regression algorithm.
* n - the order n ∈ {0, 1, 2, . . .} of the polynomial kernel.
* m - the size of the training sample S = ((x1, y1), . . . ,(xm, ym)), an integer m ≥ 1.
* X - a column vector of length m (that is, a matrix of size m × 1). (note: the function supports only 1-dimensional data.)
* Y - a column vector of length m (that is, a matrix of size m × 1).

The function returns the variable p. This is the vector of polynomial coefficients found by the algorithm, p ∈ R^n+1, a column vector. The vector p = (p0, p1, . . . , pn) corresponds to the polynomial f : R → R defined by

![ Returned polynomial](/images/return_poly.PNG)

## Cross Validation Testing 

The algorithm was tested using the given "data.mat" file, containing 1000 data points xi ∈ R and labels yi ∈ R.

λ was set to 0 and cross validation was performed to find the best polynomial rank n, the values n ∈ 0, 1, . . . , 10 were tested.

![10-fold cross-validation for Polynomial rank](/images/cv_poly_reg_regression.PNG)

The classifier returned for n=5:
![classifier n=5](/images/classifier_w_reg.PNG)

Plot of the n=5-degree polynomial received, overlaid on top of the data:
![classifier n=5](/images/poly5_reg.PNG)