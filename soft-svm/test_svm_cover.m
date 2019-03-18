function yValue = COVER3()
lambadaArray = [-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8]
lambadaArray2 = [-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
real_lambda = [];
error_Array_1000 = [];
error_Array_50 = [];
size_lambada = 19;
load('mnist all.mat'); 
[Xtrain,Ytrain,Xtest,Ytest] = gensmallm(train3, train5, test3, test5, 1000);
[Xtrain50,Ytrain50,Xtest50,Ytest50] = gensmallm(train3, train5, test3, test5, 50);
Ytrain( Ytrain==0 )=-1;
Ytest( Ytest==0 )=-1;
Ytrain50( Ytrain50==0 )=-1;




for num_lambda = 1:size_lambada
	lambadaArray(num_lambda);
	lambda=10^(lambadaArray(num_lambda));
	%eror_value_1000=question3(1000,lambda,Xtrain,Ytrain,Xtrain,Ytrain);
	eror_value_50=question3(50,lambda,Xtrain50,Ytrain50,Xtrain,Ytrain);
	%error_Array_1000 = [error_Array_1000; eror_value_1000];
	error_Array_50 = [error_Array_50; eror_value_50];	
	real_lambda = [real_lambda; lambda];
end



real_lambda_log = log(real_lambda)
plot(real_lambda_log,error_Array_50,'b'),xlabel('lambda'), ylabel('error'), title('soft svm error for different lambda values.blue m=50, red m=1000 '),grid on;


saveas(gcf,'3g','png') 



yValue =5;