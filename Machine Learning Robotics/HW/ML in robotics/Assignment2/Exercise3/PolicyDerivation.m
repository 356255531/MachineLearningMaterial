%% PolicyDerivation: derive the policy with giving value function and state-action transition matrix
function [policy] = PolicyDerivation(valueFunc, delta, reward, policy, gamma)
    for i = 1 : max(size(policy))
        nextValueFunc = (reward(i, :))' + gamma * valueFunc(delta(i, :));
        if range(nextValueFunc) ~= 0
            [~, policy(i)] = max(nextValueFunc);
        end
    end
end