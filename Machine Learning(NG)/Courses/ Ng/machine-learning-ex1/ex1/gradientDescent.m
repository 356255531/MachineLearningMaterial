function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
gradientTheta = zeros(2,1);
J_history = zeros(num_iters, 1);
pplot=[];
    for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
        gradientTheta(1,1) = (computeCost(X, y, theta + [0.001;0]) - computeCost(X, y, theta)) / 0.001;
        gradientTheta(2,1) = (computeCost(X, y, theta + [0;0.001]) - computeCost(X, y, theta)) / 0.001;
        r = -gradientTheta;
        theta = theta + alpha * r;


    % ============================================================

    % Save the cost J in every iteration    
        J_history(iter) = computeCost(X, y, theta);

    end

end
