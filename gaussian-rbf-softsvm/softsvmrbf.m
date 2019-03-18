function alpha = softsvmrbf(lambda, sigma, m, d, Xtrain, Ytrain)

%creating v (b)
v = zeros(1,2*m);
v(1:m)=-1;
v = transpose(v);
sparse_v = sparse(v);
%creating u (f)
u = zeros(1,2*m);
u(m+1:m+m)=1/m;
u = transpose(u);
sparse_u = sparse(u);

%creating G (A)

Gstart= zeros(2*m,2*m);
Gstart_forH= zeros(2*m,2*m);
%G= zeros(m,m);
for row = 1:m;
	for col = 1:m;
		value= Kernel(row,col,Xtrain,sigma);
		Gstart(row,col) = value*Ytrain(row,1);
		Gstart_forH(row,col) = value;
	end;
end;
toadd =  eye(m);
G=Gstart;
G(1:m,m+1:m+m)=toadd;
G(m+1:2*m,m+1:m+m)=toadd;
G=-1*G;
sparse_G = sparse(G);


%creating H (H)
epsi=0.001;
H = 2*lambda*Gstart_forH;
to_add_H = eye(2*m)*epsi;
H = H + to_add_H;
sparse_H = sparse(H);



alpha = quadprog(sparse_H,sparse_u,sparse_G ,sparse_v);



end



function result = Kernel(row,col,Xtrain,sigma)
	to_exp = -1*((norm(Xtrain(row,:)-Xtrain(col,:)).^2)/2*sigma);
	result = exp(to_exp);
end
	