function [par] = Exercise1(K)
	load('Data.mat');
	[ cXPosBest, cYPosBest, cOriBest, p1, p2 ] = trainAll( Input, Output, K, 6);
	par = cell(1, 3);
	par{1} = cXPosBest;
	par{2} = cYPosBest;
	par{3} = cOriBest;
	save('params','par');
end