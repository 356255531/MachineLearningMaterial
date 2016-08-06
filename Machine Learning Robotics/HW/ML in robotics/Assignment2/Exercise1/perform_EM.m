function theta = perform_EM(theta, Data, idx, k)
    numSamples = size(Data, 1);
    a = zeros(k, 1);
    for i = 1 : k
        a(i) = sum(double(idx == i)) / numSamples;
    end
    while ~converged
        thetaOld = theta;
        gamma = perform_expectation(theta, Data, a);
        [theta, a] = perform_maximalization(theta.means, Data, gamma)
        if norm(theta.means - thetaOld.means) + norm(theta.covMatrixes - thetaOld.covMatrixes) < epsilon
            converged = true;
        end
    end
end
function gamma = perform_expectation(theta, Data, a)
end
function [theta, a] = perform_maximalization(means, Data, gamma)
end