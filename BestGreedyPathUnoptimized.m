function [pathRows, pathCols, elev] = BestGreedyPath(E)
% Project - BestGreedyPath
%
% [pathRows, pathCols, elev] = BestGreedyPath(E)
%
% Loops through every point on the 2d array and for each point,
% a path from the west to the east edge is created by joining the greedy
% walk heading west and heading east from the point. The best of these paths
% are returned. The points are checked first row first from left to right, then
% down the rows from top to down. For paths with the same cost, the first
% of which to be discovered is returned.
%
% Example:
%     E = [2 4 3; 5 3 1];
%     BestGreedyPath(E);
%     % pathRows = [1 2 1]
%     % pathCols = [1 2 3]
%     % elev = [2 3 3]
%
% Inputs: E        = 2d array of elevation numbers.
% Output: pathRows = array of row numbers of each point on the path.
%         pathCols = array of col numbers of each point on the path.
%         elev     = array of elevation numbers of each point on
%                    on the path.
%
% Author: Ernest Wong (ewon746)
% Date: 2017-09-03

	[rowCount, colCount] = size(E);
	bestCost = inf;

	% Iterate, changing cols first, rows second
	for r = 1 : rowCount
		for c = 1 : colCount

			% Generate partial paths from current position
			[currRowsWest, currColsWest] = GreedyWalk([r, c], -1, E);
			[currRowsEast, currColsEast] = GreedyWalk([r, c], +1, E);

			% Merge paths
			currRows = [currRowsWest(end:-1:2), currRowsEast];
			currCols = [currColsWest(end:-1:2), currColsEast];

			% Compute cost and elevation
			[currElev, currCost] = ...
				FindPathElevationsAndCost(currRows, currCols, E);

			% Update output variables only if
			% the current cost improves previous running best
			if currCost < bestCost
				pathRows = currRows;
				pathCols = currCols;
				elev = currElev;
				bestCost = currCost;
			end

		end
	end

end
