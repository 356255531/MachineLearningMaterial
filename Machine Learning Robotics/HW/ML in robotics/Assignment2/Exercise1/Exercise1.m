function Exercise1(k)
%% Load the data and do k-means clustering
    if ~exist('k','var') || isempty(k)
        k = 4;
    end
    dataGMM = load('dataGMM.mat');
    Data = (dataGMM.Data)';
    [idx,C] = kmeans(Data, k);
%% Initialize GMM parameters
    numVariables = size(Data, 2);
    field1 = 'means';
    value1 = zeros(k, numVariables);
    field2 = 'covMatrixes';
    value2 = zeros(numVariables, numVariables, k);
    theta = struct(field1, value1, field2, value2);
    for i = 1 : k
        dataIClass = Data(find(idx == i), :);
        theta.means(i, :) = mean(dataIClass);
        theta.covMatrixes(:, :, i) = cov(dataIClass);
    end
%% Perform EM algorithm
    