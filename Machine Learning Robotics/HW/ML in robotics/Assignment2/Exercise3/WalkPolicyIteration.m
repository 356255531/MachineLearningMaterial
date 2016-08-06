%% WalkPolicyIteration: function description
function [outputs] = WalkPolicyIteration(s)
%% Assign discount factor
    gamma = 0.7;

%% Assign the reward matrix
    reward = [0, -10, 0, -10; ...
              0, 0,-10,-10; ...
              0, 0,-10,-10; ...
              0, -10,0,-10; ...
              -10,-10, 0, 0; ...
              0, 0, 0, 0; ...
              0, 0, 0, 0; ...
              -10,10, 0, 0; ...
              -10,-10, 0, 0; ...
              0, 0, 0, 0; ...
              0, 0, 0, 0; ...
              -10,10, 0, 0; ...
              0,-10, 0, -10; ...
              0, 0,-10,10; ...
              0, 0, -10,10; ...
              0, -10, 0, -10];
    disp('Reward');
    disp(reward);

%% Assign state transition matrix
    delta = [2, 4, 5, 13; ...
             1, 3, 6, 14; ...
             4, 2, 7, 15; ...
             3, 1, 8, 16; ...
             6, 8, 1, 9; ...
             5, 7, 2, 10; ...
             8, 6, 3, 11; ...
             7, 5, 4, 12; ...
             10,12,13, 5; ...
             9, 11,14, 6; ...
             12,10,15, 7; ...
             11, 9,16, 8; ...
             14,16, 9, 1; ...
             13,15,10, 2; ...
             16,14,11, 3; ...
             15,13,12, 4];

%% Policy iteration
    policy = randi([1 4], 16, 1);    % Random policy generation
    converged = false;
    while ~converged
        policyOld = policy;
        valueFunc = PolicyEvaluation(policy, reward, delta, gamma);
        policy = PolicyDerivation(valueFunc, delta, reward, policy, gamma);
        converged = isequal(policyOld, policy);
    end

%% Sequence generation and visualization
    sequence = zeros(1, 20);
    sequence(1) = s;
    for i = 2 : max(size(sequence))
        sequence(i) = delta(sequence(i - 1), policy(sequence(i - 1)));
    end
    walkshow(sequence);
end
