function [error, optimalD, C] = Exercise2(dMax)
	%% Preprocessing
	imagesTrain = loadMNISTImages('train-images.idx3-ubyte');
	labelsTrain = loadMNISTLabels('train-labels.idx1-ubyte');
	imagesTrain = imagesTrain';
	labelsTrain(double(find(labelsTrain == 0))) = 10;
	imagesVal = loadMNISTImages('t10k-images.idx3-ubyte');
	labelsVal = loadMNISTLabels('t10k-labels.idx1-ubyte');
	imagesVal = imagesVal';
	labelsVal(double(find(labelsVal == 0))) = 10;

	%% Subtract Mean
	numSamples = size(imagesTrain, 1);
	meanTrainningSet = mean(imagesTrain);
	imagesTrainZeroMean = imagesTrain - ones(numSamples, 1) * meanTrainningSet;

	%% Execution
	error = ones(60,1);
	minErrorRate = inf;

	for d = 1:dMax

	%% PCA %%%%%%%%%%%%%%%%%%%%%
		[u, lambda] = eig(cov(imagesTrainZeroMean));
		basis = u(:, end - d + 1:end);
	%% Train %%%%%%%%%%%%%%%%
		numComponent = size(basis, 2);
		reducedImages = imagesTrainZeroMean * basis;
		mu = zeros(10, numComponent);
		covMatrix = zeros(numComponent, numComponent, 10);
		for i = 1 : 10
			list = double(find(labelsTrain == i));
			imagesClassI = reducedImages(list, :);
			mu(i,:) = mean(imagesClassI);
			covMatrix(:,:,i) = cov(imagesClassI);
		end

	%% Validation %%%%%%%%%%%%%%%%%%
		numSamples = size(imagesVal, 1);
		imagesValZeroMean = imagesVal - ones(numSamples, 1) * meanTrainningSet;
		reducedImages = imagesValZeroMean * basis;
		labelsPred = zeros(numSamples, 1);

		for i = 1 : numSamples
			pdf = 0;
			for j = 1 : 10      
				likeliRatio = mvnpdf(reducedImages(i, :)', mu(j, :)', covMatrix(:,:,j));
				if likeliRatio > pdf
					pdf = likeliRatio;
					labelsPred(i) = j; 
				end
			end
		end
		errorRate = sum(double(labelsPred ~= labelsVal)) / numSamples;
		error(d) = errorRate;
	%% Error Comparison
		if minErrorRate > errorRate
			minErrorRate = errorRate;
			optimalD = d;
			group1 = labelsPred';
			group2 = labelsVal;
        end
        fprintf('%d%%\n', d/dMax * 100);
	end
	plot(1:60, error);
	group1(double(find(group1 == 10))) = 0;
	group2(double(find(group2 == 10))) = 0;
	[C,order] = confusionmat(group2,group1);
end