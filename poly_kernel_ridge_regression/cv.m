function cv()
load('data.mat');
Xtrain=fix_Xtrain(X);
Ytrain=fix_Ytrain(Y);
%Xtrain=X;
%Ytrain=Y;

clf('reset')

lambda=[0];
n=[0;1;2;3;4;5;6;7;8;9;10];



%the next code is running n=5 on the test! (last 50 on the given data )
Xtrain_new=Xtrain(1:950,1);
Ytrain_new=Ytrain(1:950,1);
p=polyridgereg(0, 5, 950, Xtrain_new, Ytrain_new);
p

p_lr=fliplr(p);
%ploting the poli;
plot(X,polyval(p(end:-1:1),X),'.',X,Y,'.');
saveas(gcf,'perfect5','png') 
clf('reset')
		
		
		
% next is the code for the whole cv algorithem	
Ytest_predict2= [];
Ytest_predict3= [];
sum3=0;

for LL = 951:1000;
	Ytest_predict3(LL-950,1) =polyval(p_lr,Xtrain(LL));
	sum3=sum3+(Ytest_predict3(LL-950,1)-Ytrain(LL)).^2;			
end
errorValue3=sum3/50;
errorValue3


%next is simply the CV algorithem.
for i = 5:6;
	sumError3=0;
	sumError4=0;
	n(i)
	for k = 1:10
		Xtrain_k=Xtrain(k*100-100+1:k*100,1);		
		Ytrain_k=Ytrain(k*100-100+1:k*100,1);		
		if k == 1
			Xtrain_new=Xtrain(101:1000,1);
			Ytrain_new=Ytrain(101:1000,1);				
		elseif k==10
			Xtrain_new=Xtrain(1:900,1);
			Ytrain_new=Ytrain(1:900,1);
		else					
			%Xtrain_new=horzcat(Xtrain_new1,Xtrain_new2);
			Xtrain_new(1:k*100-100,1)=Xtrain(1:k*100-100,1);	
			Xtrain_new(k*100-100+1:900,1)=Xtrain(k*100+1:1000,1);				
			Ytrain_new(1:k*100-100)=Ytrain(1:k*100-100,1);	
			Ytrain_new(k*100-100+1:900)=Xtrain(k*100+1:1000,1);				
		end	
		p=polyridgereg(0, n(i), 900, Xtrain_new, Ytrain_new);
		%p=polyridgereg2(0, n(i), 1000, Xtrain, Ytrain);	
		p;
		p_lr=fliplr(p);
		sum3=0;
		%plot(X,polyval(p(end:-1:1),X),'.',X,Y,'.');
		%saveas(gcf,'try123','png') 
		%clf('reset')
		%plot(X,polyval(valid_lr(end:-1:1),X),'.',X,Y,'.');
		%saveas(gcf,'valid','png') 
		
		
		
		for LL = 1:50;
			Ytest_predict3(LL,1) =polyval(p_lr,Xtrain_k(LL));
			sum3=sum3+(Ytest_predict3(LL,1)-Ytrain_k(LL)).^2;	
			
		end
		%Ytest_predict = transpose(Ytest_predict);
		%Ytest = transpose(Ytest);	
		%few obsveration for us to check how good the labeling

		errorValue3=sum3/50;		
		errorValue3;

		sumError3=sumError3+errorValue3;
	
	end
n(i);
final_error3=sumError3/k;
final_error3

end








end


function tag = compute_tag(G,Xtrain_k,LL,p)
tag=0;
for i=1:900
	tag=tag+polyval(p,G(LL,i));
end


end

function ans = find_y(x,p,n)
ans=0;
for k=1:n+1;
	ans=ans+p(k)*(x.^(k-1));
end



end





function new_Xtrain = fix_Xtrain(Xtrain)
for k=1:500;
	c=k*2;
	new_Xtrain(c-1,1)=Xtrain(k,1);
	new_Xtrain(c,1)=Xtrain(1000-k+1,1);
end
end

function new_Ytrain = fix_Ytrain(Ytrain)
for k=1:500;
	c=k*2;
	new_Ytrain(c-1,1)=Ytrain(k,1);
	new_Ytrain(c,1)=Ytrain(1000-k+1,1);
end
end



%creating G (A)
function G = create_g(n,mTrain,mTest,Xtest,Xtrain)

G= zeros(mTest,mTrain);
%G= zeros(m,m);
for row = 1:mTest;
	for col = 1:mTrain;
		G(row,col) = Kernel(row,col,Xtest,Xtrain,n);
	end;
end;
end


%function result = Kernel(row,col,X,n)
%	to_power = 1+ (X(row,:)*X(col,:));
%	
%	result = to_power.^n;
%end




function result = Kernel(row,col,Xtest,Xtrain,n)
	to_power = 1+ (Xtest(row,:)*Xtrain(col,:));
	result = to_power.^n;
end
