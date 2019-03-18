function w = softsvm(lambda, m, d, Xtrain, Ytrain)
% initialize quadprog params
u = zeros(d+m, 1);
for i=d+1:d+m
    u(i) = 1/m;
end

v = zeros(2*m, 1);
for i=1:m
    v(i, 1) = 1;
end

H = zeros(d+m, d+m);
for i=1:d
    H(i,i)=2*lambda;
end

A = zeros(2*m, (d+m));
for i=1:m
    for j=1:d
        A(i,j) = Ytrain(i)*Xtrain(i,j);
    end
    A(i,i+d) = 1;
end
for i=1:m
    A(m+i,d+i) = 1;
end

A = -A;
w = quadprog(H,u,A,v);
