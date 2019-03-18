function gimel()
load('R2data.mat'); 
d=2

[X,Y] = meshgrid(-4:5,-5:5)
counter=0;
for row = 1:21;
	for col = 1:10;
		counter=counter+1;
		Ytrain_new(counter,1)=X(row,col);
		Ytrain_new(counter,2)=Y(row,col);		
	end
end


whos Ytrain_new


mTrain_falwed=size(Xtrain);
mTrain=mTrain_falwed(1);

mTest=210;

Ytest_predict= [];


G=create_g(0.05,mTrain,mTest,Ytrain_new,Xtrain);
alpha = softsvmrbf(0.1, 0.05, mTrain, d, Xtrain, Ytrain);
alpha_good=alpha(1:mTrain);





pic=zeros(21,10);
for i = 1:mTest;
	%Ytest_predict(i,1)=sign(G(i,:)*alpha_good);
	Ytest_predict(i,1)=G(i,:)*alpha_good;
end


counter=0;
Z=zeros(21,10);
for row = 1:21;
	for col = 1:10;
		counter=counter+1;
		%Ytrain_new_Y=Ytest_predict(counter,1);
		Z(row,col)=Ytest_predict(counter,1);
	end
end


hHM = HeatMap(Z);

hFig = plot(hHM);
saveas(hFig,'try2_Z','png'); 






end



%creating G (A)
function G = create_g(sigma,mTrain,mTest,Xtest,Xtrain)

G= zeros(mTest,mTrain);
%G= zeros(m,m);
for row = 1:mTest;
	for col = 1:mTrain;
		G(row,col) = Kernel(row,col,Xtest,Xtrain,sigma);
	end;
end;
end







function result = Kernel(row,col,Xtest,Xtrain,sigma)
	to_exp = -1*((norm(Xtest(row,:)-Xtrain(col,:)).^2)/2*sigma);
	result = exp(to_exp);
end
