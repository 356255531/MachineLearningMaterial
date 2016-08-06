%% GetActionEpsilonGreedy: get action from Q function using epsilon greedy
function [action] = GetActionEpsilonGreedy(state, Q, epsilon)
    if rand > epsilon && range(Q(state, :)) ~= 0
        [~, action] = max(Q(state, :));
    else
        action = randi([1, 4]);
    end
end