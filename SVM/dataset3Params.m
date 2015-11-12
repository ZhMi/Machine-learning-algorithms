function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

sigma = 0.3;    
table = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
for i = 1:8;
	for j = 1:8;
	%model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
	model = svmTrain(X, y, table(i), @(x1, x2) gaussianKernel(x1, x2, table(j)));
	predictions = svmPredict(model, Xval);
	error(i,j) = mean(double(predictions ~= yval));
	end
end
[error_min index] = min(error(:));%index�ǰ��м�����
sigma = table(1 + floor((index-1) / 8));
C = table(1 + mod(index-1, 8));





% =========================================================================

end