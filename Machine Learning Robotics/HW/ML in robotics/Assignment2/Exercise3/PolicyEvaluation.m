%% PolicyEvaluation: function description
function [valueFunc] = PolicyEvaluation(policy, reward, delta, gamma)
    B = zeros(max(size(policy)), 1);
    for i = 1 : max(size(policy))
        B(i) = reward(i, policy(i));
    end
    A = eye(max(size(policy)));
    for i = 1 : max(size(policy))
        A(i, delta(i, policy(i))) = -gamma;
    end
    valueFunc = linsolve(A, B);
end
