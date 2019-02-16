function J = CostFunctionLogistic( X,y,theta )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
L=length(theta);
m=length(y);
h = 1 ./ (1 + exp(-(X*theta)));

J = (1 / m) * sum(- (y .* log(h)) - ((1 - y) .* log(1 - h)) )+((0.00000001/(2*m)* sum((theta(2:L,1)).^2)));
end

