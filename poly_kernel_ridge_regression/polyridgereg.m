function p = polyridgereg(lambda, n, m, X, Y)

%creating G

G= zeros(m,m);
for row = 1:m;
	for col = 1:m;
		value= Kernel(row,col,X,n);
		G(row,col) = value;
	end;
end;

G_t=transpose(G);
H=2*lambda*G + 2*G_t*G;
%f=-2*G*Y
f=-2*G_t*Y;



%SWITCH HERE QUADPROG OR pseudo inverse  LINEAR REGRESSION
%alpha = quadprog(H,f);
%alpha = pinv(lambda*G+G_t*G)*G*Y;
alpha = pinv(G*G_t)*G*Y;



X_mapped=zeros(m,n+1);
for i = 1:m;
	X_mapped(i,:)=Mapping(X(i),n);
end
X_mapped_T=transpose(X_mapped);




p=alpha_t*X_mapped;
end



function result = Kernel(row,col,X,n)
	to_power = 1+ (X(row,:)*X(col,:));
	
	result = to_power.^n;
end




function mapped_sample = Mapping(x,n);
	mapped_sample=zeros(1,n+1);
	for i = 1:n+1;
		mapped_sample(1,i)=nchoosek(n,i-1)*x.^(i-1);
	end
end
	