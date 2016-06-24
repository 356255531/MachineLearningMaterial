function [trainSetPosX, trainSetPosY, trainSetOri, valSetPos, valSetOri] = setPartition(inputSet, outputSet, k, iOfK, iOfP)
	numSample = size(inputSet, 1);
	unitSetLen = fix(numSample / k);

	valSetVW = inputSet((iOfK - 1) * unitSetLen + 1: iOfK * unitSetLen, :);
	valSetVW = [valSetVW, valSetVW(:, 1) .* valSetVW(:, 2)];
	if iOfP > 1
        temp = valSetVW;
		for i = 2 : iOfP
			valSetVW = [valSetVW, temp .^ i];
		end
	end

	valSetPos = [valSetVW, outputSet((iOfK - 1) * unitSetLen + 1: iOfK * unitSetLen, 1:2)];
	valSetOri = [valSetVW, outputSet((iOfK - 1) * unitSetLen + 1: iOfK * unitSetLen, 3)];

	deletedInputSet = removerows(inputSet, 'ind', [(iOfK - 1) * unitSetLen + 1: iOfK * unitSetLen]);
	deletedOutputSet = removerows(outputSet, 'ind', [(iOfK - 1) * unitSetLen + 1: iOfK * unitSetLen]);

	trainSetVW = [deletedInputSet, deletedInputSet(:, 1) .* deletedInputSet(:, 2)];
	if iOfP > 1
        temp = trainSetVW;
		for i = 2 : iOfP
			trainSetVW = [trainSetVW, temp .^ i];
		end
    end
	trainSetPosX = [trainSetVW, deletedOutputSet(:, 1)];
	trainSetPosY = [trainSetVW, deletedOutputSet(:, 2)];
	trainSetOri = [trainSetVW, deletedOutputSet(:, 3)];

end