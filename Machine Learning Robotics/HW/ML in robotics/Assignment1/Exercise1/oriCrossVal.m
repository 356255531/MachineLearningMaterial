function errorVal = oriCrossVal(aTheta, valSet)
	numSample = size(valSet, 1);
	input = valSet(:, 1 : end - 1);
    input = [ones(numSample, 1), input];
	output = valSet(:, end);
	errorVal = sum(sqrt((input * aTheta - output) .^ 2)) / numSample;
end