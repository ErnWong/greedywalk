function [pathRows, pathCols, elev] = BestGreedyPathHeadingEast(E)
% Project - BestGreedyPathHeadingEast
%
% [pathRows, pathCols, elev] = BestGreedyPathHeadingEast(E)
%
% Finds the lowest-costing path out of all possible greedy walks
% starting from the west edge and heading east.
%
% Example:
%     E = [1 3 4; 8 7 6];
%     [pathRows, pathCols, elev] = BestGreesyPathHeadingEast(E);
%     % pathRows =   2  2  2
%     % pathCols =   1  2  3
%     % elev =   8  7  6
%
% Inputs: E        = 2d array of elevation numbers.
% Output: pathRows = array of row numbers of each point on the path.
%         pathCols = array of col numbers of each point on the path.
%         elev     = array of elevation numbers of each point on
%                    on the path.
%
% Author: Ernest Wong (ewon746)
% Date: 2017-09-03

	rowCount = size(E,1);
	bestCost = inf;

	% Iterate over starting positions
	for r = 1 : rowCount
		[currRows, currCols] = GreedyWalk([r, 1], 1, E);
		[currElev, currCost] = FindPathElevationsAndCost(currRows, currCols, E);

		% Store results if cost is improved
		if currCost < bestCost
			pathRows = currRows;
			pathCols = currCols;
			elev = currElev;
			bestCost = currCost;
		end
	end

end
