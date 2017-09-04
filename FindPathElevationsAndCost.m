function [elev, cost] = FindPathElevationsAndCost(pathRows, pathCols, E)
% Project - FindPathElevationsAndCost
%
% [elev, cost] = FindPathElevationsAndCost(pathRows, pathCols, E)
%
% Extracts the elevation numbers for a path and calculates
% the total cost of the path (the sum of each elevation change
% needed to achieve this path).
%
% Example:
%     E = [1 2 3; 4 5 6];
%     pathRows = [1 2 1];
%     pathCols = [1 2 3];
%     [elev, cost] = FindPathElevationsAndCost(pathRows, pathCols, E);
%     % elev =   1   5   3
%     % cost = 6
%
% Inputs: pathRows = array of row numbers at each point of a path
%         pathCols = array of col numbers at each point of a path
%         E        = 2d array of elevation numbers
% Output: elev     = array of elevation at each path
%         cost     = total cost of the path
%
% Author: Ernest Wong (ewon746)
% Date: 2017-09-03

	% Using linear indices to extract numbers from matrix E.
	elev = E(sub2ind(size(E), pathRows, pathCols));

	cost = sum(abs(elev(2:end) - elev(1:end-1)));

end
