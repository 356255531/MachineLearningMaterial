function errorVal = posCrossVal(aX, aY, valSet)
	numSample = size(valSet, 1);
	input = valSet(:, 1 : end - 2);
    input = [ones(numSample, 1), input];
	outputX = valSet(:, end - 1);
	outputY = valSet(:, end);
	errorVal = sum(sqrt((input * aX - outputX) .^ 2 ...
                + (input * aY - outputY) .^ 2)) / numSample;
end