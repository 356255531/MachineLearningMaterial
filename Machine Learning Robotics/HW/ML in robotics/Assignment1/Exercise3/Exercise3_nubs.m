function  Exercise3_nubs(gesture_l, gesture_o, gesture_x, K)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

	if nargin < 4
		load('gesture_dataset.mat');
	end

	if ~exist('K','var')
		K = 7;
	end

	dataL = reshape(gesture_l, 600, 3);
	dataO = reshape(gesture_o, 600, 3);
	dataX = reshape(gesture_x, 600, 3);

	v = [0.08, 0.05, 0.02]';
		
	[centroidsLN, dataLN] = nubs(dataL, K, v);
	[centroidsON, dataON] = nubs(dataO, K, v);
	[centroidsXN, dataXN] = nubs(dataX, K, v);

	list = ['b', 'k', 'r', 'g', 'm', 'y', 'c'];

	subplot(1, 3, 1);
	for j = 1 : 7
		plotData = dataLN(double(find(dataLN(:, 4) == j)), 1:3);
		plot(plotData(:, 1), plotData(:, 2), 'MarkerEdgecolor', list(j));
		title('Plot clusters in gesture_l with NUBS');
		hold on;
	end

	subplot(1, 3, 2);
	for j = 1 : 7
		plotData = dataON(double(find(dataON(:, 4) == j)), 1:3);
		plot(plotData(:, 1), plotData(:, 2), 'MarkerEdgecolor', list(j));
		title('Plot clusters in gesture_o with NUBS');
		hold on;
	end

	subplot(1, 3, 3);
	for j = 1 : 7
		plotData = dataXN(double(find(dataXN(:, 4) == j)), 1:3);
		plot(plotData(:, 1), plotData(:, 2), 'MarkerEdgecolor', list(j));
		title('Plot clusters in gesture_x with NUBS');
		hold on;
	end

end

