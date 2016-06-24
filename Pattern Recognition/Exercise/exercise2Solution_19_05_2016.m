% exercise 2
% In this exercise we want to find well a binary classifier works in 
% detecting above normal values from two interleaved normal distributions.
% 1. Plot the ROC curve for for the decision rule
% 2. Plot the Precision-Recall curve of the same data
% 3. Plot the cost curve for the provided
% 4. Find the optimal point of operation

% normal distribution classes
rng(0);
numOfObservations = 1000;
mean1 = 3;
std1 = 2;
mean2 = 7;
std2= 2;
normal = sort(normrnd(mean1, std1, [1 numOfObservations]), 'descend');
aboveNormal = sort(normrnd(mean2, std2, [1 numOfObservations]), 'descend');

% Calcualte and plot the ROC curve below
% 
% (code)
%

% Solution 1
% calculate fpr, tpr and plot roc

all = [normal aboveNormal];
labels = [zeros(size(normal)) ones(size(normal))];
xy = [all', labels'];
sorted = sortrows(xy);
labels = sorted(:, 2);

fpr = (numOfObservations - cumsum(1 - labels)) / numOfObservations;
tpr = (numOfObservations - cumsum(labels)) / numOfObservations;

% AUC calcution
fpr = [flip(fpr); 1];
tpr = [flip(tpr); 1];
h = diff(fpr);
auc = sum(h .* (tpr(2:end) + tpr(1:end-1))) / 2;

fig1 = figure;
plot(fpr, tpr);
title(sprintf('ROC curve with AUC = %f', auc));
xlabel('fpr = 1 - specificity = 1 - tn/(tn+fp)');
ylabel('tpr = sensitivity = tp/(tp+fn)');


% Calculate precision, recall and plot curve below
%
% (code)
%

% Solution 2
% calculate recall, precision and plot precision-recall curve

recall_new = tpr;
precision_new = (numOfObservations - cumsum(labels)) ./ (2 * numOfObservations - cumsum(ones(size(labels))));
precision_new = [flip(precision_new); 0];
fig2 = figure;
plot(recall_new, precision_new);
title('precision-recall curve');
xlabel('recall = sensitivity = tp/(tp+fn)');
ylabel('precision = tp/(tp+fp)');

% Given the follwoing costs, plot the cost function below
cfn = 1; % cost false negative
cfp = 1; % cost false positive

%
% (code)
%

% Solution 3
% tpr = sensitivity = tp/(tp+fn) => fn = (1-tpr)*tp/tpr
% fpr = 1 - specificity = 1 - tn/(tn+fp) => fp = fpr*tn/(1-fpr);

fnr = cumsum(labels) / numOfObservations;
fpr = 1 - cumsum(1 - labels) / numOfObservations;

cost_fp = cfp * fpr;
cost_fn = cfn * fnr;
cost_total = cost_fp + cost_fn;
fig3 = figure;
plot(sorted(:, 1), cost_total);


% Given the previous cost fuction, find the optimal threshold
%
% (code)
%

% Solution 4

[min_cost, index] = min(cost_total); % cTotal min index points at most the end of aboveNormal
figure(fig3);
hold on;
% plot([aboveNormal(index) aboveNormal(index)], [Min-50 max(cTotal)], 'r');
plot([sorted(index, 1) sorted(index, 1)], [min_cost - 0.1 max(cost_total)], 'r');
hold off;

figure(fig1);
hold on;
plot([fpr(index) fpr(index)], [min(tpr) max(tpr)], 'r'); % plot vertical line
plot([min(fpr) max(fpr)], [tpr(index) tpr(index)], 'r'); % plot horizontal line
hold off

