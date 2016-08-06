%% WalkQLearning: Derive the policy using Q-Learning
function [outputs] = WalkQLearning(s)
%% Reinforcement Learning parameter predefine
    gamma = 0.7;
    epsilon = 0.1;
    learningRate = 0.1;
    stepThreashold = 5000;

%% Initilize
    Q = zeros(16, 4);
    startState = randi([1, 16]);

%% Q Learning
    state = startState;
    for i = 1 : stepThreashold
        action = GetActionEpsilonGreedy(state, Q, epsilon);
        [newstate, reward] = SimulateRobot(state, action);
        TDError = reward + gamma * max(Q(newstate, :)) - Q(state, action);
        Q(state, action) = Q(state, action) + ...
                            learningRate * TDError;
        state = newstate;
    end

%% Sequence generation and visualization
    sequence = zeros(1, 20);
    sequence(1) = s;
    for i = 2 : max(size(sequence))
        [~, action] = max(Q(sequence(i - 1), :));
        [sequence(i), ~] = SimulateRobot(sequence(i - 1), action); 
    end
    walkshow(sequence);
end

