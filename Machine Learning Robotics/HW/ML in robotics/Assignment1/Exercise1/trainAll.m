function [ cXPosBest, cYPosBest, cOriBest, p1, p2 ] = trainAll( inputSetOriginal, outputSetOriginal, k, pRange)
%TRAIN Summary of this function goes here
%   Detailed explanation goes here
	inputSet = inputSetOriginal';
	outputSet = outputSetOriginal';
	errorPosMin = inf;
	errorOriMin = inf;
	p1 = 0;
	p2 = 0;

	for i = 1:pRange
		for j = 1:k
			[trainSetPosX, trainSetPosY, trainSetOri, valSetPos, valSetOri] = setPartition(inputSet, outputSet, k, j, i);

			cXPos = trainModel(trainSetPosX);
            cYPos = trainModel(trainSetPosY);
			cOri = trainModel(trainSetOri);

			errorPosVal = posCrossVal(cXPos, cYPos, valSetPos);
			errorOriVal = oriCrossVal(cOri, valSetOri);

			if errorPosVal < errorPosMin
				p1 = i;
				errorPosMin = errorPosVal;
				cXPosBest = cXPos;
                cYPosBest = cYPos;
			end

			if errorOriVal < errorOriMin
				p2 = i;
				errorOriMin = errorOriVal;
				cOriBest = cOri;
			end
		end
	end
end