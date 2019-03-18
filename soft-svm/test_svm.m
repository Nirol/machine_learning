function errorValue = question3(m,lambda,train,Ytrain,Xtest,Ytest)
d=784;
Ytest_predict= [];
ntest = size(Xtest,1);


w=softsvm(lambda,m,d,Xtrain,Ytrain);
w=w(1:d);
normW = norm(w);
	
num_negative = 0;
for num_samples = 1:ntest
	label=(Ytest(num_samples)*(dot(w,Xtest(num_samples,:))))/normW;
	if label < 0
		num_negative=num_negative+1;
	end
		Ytest_predict = [Ytest_predict; label];
end;

errorValue =num_negative/ntest; 