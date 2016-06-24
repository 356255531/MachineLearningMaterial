function [centroids, data] = nubs(dataSet, K, vRan)
	numDim = size(dataSet, 2);
	numSamples = size(dataSet, 1);
	data = [dataSet, ones(numSamples, 1)];
	centroids = ones(K, numDim);
	distortion  = zeros(K, 1);

	centroids(1, :) = mean(data(:, 1:3));
	data(:, 4) = ones(numSamples, 1);

	for i = 2 : K
		for j = 1 : i - 1
			dataTemp = data(double(find(data(:, 4) == j)), 1:3);
			diffData = dataTemp - ones(size(dataTemp, 1), 1) * centroids(j, :);
			distortion(j) = sum(sqrt(sum((diffData .^ 2)')));
		end

		largestDist = 0;
		for j = 1 : i - 1
			if largestDist < distortion(j)
				splitClass = j;
				largestDist = distortion(j);
			end
		end

		temp = centroids(splitClass, :);
		centroids(splitClass, :) = temp + vRan';
		centroids(i, :) = temp - vRan';

		list = double(find(data(:,4) == splitClass));
		for j = 1 : length(list)
			dist1 = norm(data(list(j) , 1:3) - centroids(splitClass, :));
			dist2 = norm(data(list(j) , 1:3) - centroids(i, :));
			if dist1 > dist2
				data(list(j) , 4) = i;
			else
				data(list(j) , 4) = splitClass;
			end
		end

		centroids(splitClass, :) = mean(data(double(find(data(:, 4) == splitClass)), 1:3));
		centroids(i, :) = mean(data(double(find(data(:, 4) == i)), 1:3));

	end
end