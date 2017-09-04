function [pathRows, pathCols] = GreedyWalk(startPos, direction, E)
% Project - GreedyWalk
%
% [pathRows, pathCols] = GreedyWalk(startPos, direction, E)
%
% Generates a path where each step is chosen greedily to
% minimise the immediate elevation change.
%
% Example:
%     [pathRows, pathCols] = GreedyWalk([2,1], 1, [1 3 2; 2 4 3]);
%     % pathRows =   2  1  2
%     % pathCols =   1  2  3
%
% Inputs: startPos  = array of two numbers: row and column
%                     representing the starting position.
%         direction = either +1 (heading east)
%                     or -1 (heading west).
%         E         = 2d array of elevation values
% Output: pathRows  = array of row numbers in each step of the walk.
%         pathCols  = array of col numbers in each step of the walk.
%
% Author: Ernest Wong (ewon746)
% Date: 2017-09-03

	% Cache useful numbers
	colCount = size(E, 2);

	% This calculates the length of the path starting
	% from startPos and ending at the appropriate edge.
	walkLength = mod(-startPos(2) * direction, colCount + 1);

	% Preallocate and initialize
	pathRows = [startPos(1), zeros(1, walkLength - 1)];
	pathCols = [startPos(2), zeros(1, walkLength - 1)];

	% Walk
	for i = 2 : walkLength
		previous = [pathRows(i - 1), pathCols(i - 1)];
		pos = GreedyPick(previous, direction, E);
		pathRows(i) = pos(1);
		pathCols(i) = pos(2);
	end

end
