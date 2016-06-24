function  Exercise3_kmeans(gesture_l, gesture_o, gesture_x, ...
							init_cluster_l, init_cluster_o, init_cluster_x, K)
	if nargin < 8
		load('gesture_dataset.mat');
	end
	dataL = reshape(gesture_l, 600, 3);
	dataO = reshape(gesture_o, 600, 3);
	dataX = reshape(gesture_x, 600, 3);

	[centroidsLK, dataLK] = kMeans(dataL, init_cluster_l);
	[centroidsOK, dataOK] = kMeans(dataO, init_cluster_o);
	[centroidsXK, dataXK] = kMeans(dataX, init_cluster_x);

	list = ['b', 'k', 'r', 'g', 'm', 'y', 'c'];
	subplot(1, 3, 1);
	for j = 1 : 7
		plotData = dataLK(double(find(dataLK(:, 4) == j)), 1:3);
		plot(plotData(:, 1), plotData(:, 2), 'MarkerEdgecolor', list(j));
		title('Plot clusters in gesture_l with K-means');
		hold on;
	end


	subplot(1, 3, 2);
	for j = 1 : 7
		plotData = dataOK(double(find(dataOK(:, 4) == j)), 1:3);
		plot(plotData(:, 1), plotData(:, 2), 'MarkerEdgecolor', list(j));
		title('Plot clusters in gesture_o with K-means');
		hold on;
	end

	subplot(1, 3, 3);
	for j = 1 : 7
		plotData = dataXK(double(find(dataXK(:, 4) == j)), 1:3);
		plot(plotData(:, 1), plotData(:, 2), 'MarkerEdgecolor', list(j));
		title('Plot clusters in gesture_x with K-means');
		hold on;
	end
end