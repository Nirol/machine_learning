function Ytest_predict = nn(k, m, d, ntest, Xtrain, Ytrain, Xtest)

Ytest_predict= [];
% size of the test matrix, for iteration purposes  
[rows, columns] = size(Xtest);



% matrix to hold distances between all test samples to train samples vectors.

fprintf('ntest = %d m = %d \n',ntest,m)
dist_matrix = zeros(ntest,m);



% dist_matrix(x,y) = The Euclidean distance between  the x number test sample vector to the y number train sample vector. 
for num_rows = 1:ntest
	for train_row = 1:m
		dist_matrix(num_rows,train_row)=norm(Xtest(num_rows,:)-Xtrain(train_row,:));
	end;
end;


for num_rows = 1:ntest
	num_zero = 0;
	num_ones = 0;
	[Bsort Bidx] = getKElements(dist_matrix(num_rows,:), k);
	for train_index = 1:k
		if Ytrain(Bidx(train_index)) == 0
			num_zero = num_zero +1;
		else 
			num_ones = num_ones +1;
		end
	end
	if num_zero > num_ones
		Ytest_predict = [Ytest_predict; 0];
	else
		Ytest_predict = [Ytest_predict; 1];
	end
end

end



function [smallestNElements smallestNIdx] = getKElements(A, n)
     [ASorted AIdx] = sort(A);
     smallestNElements = ASorted(1:n);
     smallestNIdx = AIdx(1:n);
end


