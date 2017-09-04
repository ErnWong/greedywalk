function newPos = GreedyPick(currPos, direction, E)
% Project - GreedyPick
%
% newPos = GreedyPick(currPos, direction, E)
%
% Picks the new position to go to [row, col]
% with the least elevation change, given the
% current position [row, col], the direction
% to travel to (delta col) and elevation info.
%
% If multiple new positions require the same
% elevation changes, the northernmost position
% is chosen.
%
% Example:
%    GreedyPick([2,2], 1, [1 5 2; 3 1 4; 2 2 1]);
%    % ans =   3   3
%
% Inputs: currPos   = array of two numbers: row and column
%                     representing the current position
%         direction = either +1 for heading east
%                     or -1 for heading west
%         E         = 2d array of elevation values
% Output: newPos    = array of two numbers: row and column
%                     representing the next position to take
%
% Author: Ernest Wong (ewon746)
% Date: 2017-09-03

	% Cache some useful information
	ESize = size(E);
	nextCol = currPos(2) + direction;

	% midIndex is the array linear index of the middle neighbour.
	midIndex = sub2ind(ESize, currPos(1), nextCol);

	% Construct array of possible neighbours
	% Non-existent neighbours will have NaN value
	% which the min function ignores.
	nextElevs = [NaN, E(midIndex), NaN];
	if currPos(1) > 1
		nextElevs(1) = E(midIndex - 1);
	end
	if currPos(1) < ESize(1)
		nextElevs(3) = E(midIndex + 1);
	end

	% Search and compute the minimal-cost position
	% Note: not using FindSmalllestElevationChange because
	% that function unnecessarily discards desired id.
	[~, id] = min(abs(E(currPos(1), currPos(2)) - nextElevs));
	newPos = [currPos(1) + id - 2, nextCol];

end
