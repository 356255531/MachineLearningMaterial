function [c] = trainModel(trainSet)
% inputSet = num_sample * num_feature
% outputSet = num_sample * num_output

%%%%%%%%%%%%%% Initialize %%%%%%%%%%%%%%%%
	numSample = size(trainSet, 1);
	numFeature = size(trainSet, 2) - 1;
	realInput = [ones(numSample, 1), trainSet(:, 1:end - 1)];
	function [f,g] = costFun(x)
		% Calculate objective f
		f = (realInput * x - trainSet(:, end))' ...
	        * (realInput * x - trainSet(:, end)) / (2 * numSample);


		if nargout > 1 % gradient required
		    g = realInput' * (realInput * x - trainSet(:, end)) / (2 * numSample);
		end
	end

%%%%%%%%%%%%%%%%%%%%%%% Training %%%%%%%%%%%%%%%%%%%
	options = optimoptions('fminunc','Algorithm','trust-region','SpecifyObjectiveGradient',true);
	a = zeros(numFeature + 1, 1); % a = numOutput * numFeature + 1
	fun = @costFun;
	c = fminunc(fun,a,options);

end