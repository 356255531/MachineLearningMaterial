function [centroids, data] = kMeans(dataSet, initialCenters)
	centroids = initialCenters;
	epsilon = 10e-6;
	numClusters = size(initialCenters, 1);
	numSamples = size(dataSet, 1);
	data = [dataSet, zeros(numSamples, 1)];
	error = inf;
	distortion = inf;
	c = 0;
	while abs(error) >= epsilon
		preDist = distortion;

		for i = 1 : numSamples
			eucDis = inf;
			for j = 1 : numClusters
				dis = norm(centroids(j, :) - data(i, 1 : 3));
				if dis < eucDis
					eucDis = dis;
					data(i, 4) = j;
				end
			end
		end

		for j = 1 : numClusters
			centroids(j, :) = mean(data(double(find(data(:, 4) == j)), 1:3));
		end

		distortion  = 0;

		for i = 1 : numSamples
			distortion = distortion + norm(data(i, 1:3) - centroids(data(i, 4), :));
		end

		error = preDist - distortion;
	end
end