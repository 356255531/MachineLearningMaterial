function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 0.1;
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
error = 10000;
for i = 1:8
    for j = 1:8
        Cn = 0.003 * 3 ^ i + 10 ^ (0.5 * i - 3.5) * mod(i,2);
        sigman = 0.003 * 3 ^ j + 10 ^ (0.5 * j - 3.5) * mod(j,2);
        model= svmTrain(X, y, Cn, @(x1, x2) gaussianKernel(x1, x2, sigman));
        predictions = svmPredict(model, Xval);
        if error > mean(double(yval ~= predictions))
            C = Cn;
            sigma = sigman;
            error = mean(double(yval ~= predictions));
        end
    end
end






% =========================================================================

end