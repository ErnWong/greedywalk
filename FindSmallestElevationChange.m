function pos = FindSmallestElevationChange(currentElev, nextElevs)
% Project - FindSmallestElevationChange
%
% pos = FindSmallestElevationChange(currentElev, nextElevs)
%
% Given the current elevation and next elevations, picks
% the locations with the least absolute elevation difference.
%
% Example:
%     FindSmallestElevationChange(5, [3 4 6]);
%     % ans =    2   3
%
% Inputs: currentElev = starting elevation (real number)
%         nextElevs   = array of elevations of the next locations
%                       that can be reached from starting position
% Output: pos         = array of array indices that correspond
%                       to the elements of nextElevs that requires
%                       the least elevation change to move to.
%
% Author: Ernest Wong (ewon746)
% Date: 2017-09-03

	costs = abs(currentElev - nextElevs);
	pos = find(costs == min(costs));

end
