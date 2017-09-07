function [pathRow, pathCol, pathElev] = BestPathVectorized(Elevations)

	[actualRowCount, colCount] = size(Elevations);

	% Row count for the padded arrays (see below)
	rowCount = actualRowCount + 2;

	% Elevations data padded with 1 row of NaNs
	% above and below. Makes calculations streamlined
	% and easily vectorized.
	E(2:rowCount-1,:) = Elevations;
	E([1 rowCount],:) = NaN;

	% 2D array representing optimal cost to travel from
	% the given position to the eastern edge.
	% Note that this array is padded with 1 row of zeros
	% above and below the actual data
	Costs = zeros(rowCount, 2);

	% 2D array reprenting which east neighbour to go to next
	%  = 1, 2 or 3 representing r-1, r, r+1 respectively.
	Trail = zeros(actualRowCount, colCount - 1, 'int8');

	% Generate neighbour row nunmbers for each column.
	% OffsetIndices =
	%    1 2 3
	%    2 3 4
	%    3 4 5
	%    4 5 6
	%     etc.
	OffsetIndices = bsxfun(@plus, (1 : actualRowCount)', [0 1 2]);

	% Row numbers inside the Costs and E matrix that
	% represents actual rows.
	% rows = 2 3 4 5 ... etc
	rows = (1 : actualRowCount) + 1;

	% Compute from east to west starting from the second last column
	for c = (colCount - 1) : -1 : 1

		% Compute neighbour indices for current column
		NId = OffsetIndices + c * rowCount;
		NCId = OffsetIndices + (GetCol(c - 1) - 1) * rowCount;

		% Compute immediate elevation changes
		ElevChanges = abs(E(rows, c) - E(NId));

		% Find best neighbours for entire column
		[Costs(rows, GetCol(c)), Trail(:, c)] = ...
			min(Costs(NCId) + ElevChanges, [], 2);

	end

	% Finally, generate path information from trails...

	pathCol = 1 : colCount;
	pathRow = zeros(1, colCount);
	pathElev = zeros(1, colCount, 'int32');

	% Pick the best starting row
	[~, pathRow(1)] = min(Costs(rows,GetCol(1)));
	pathElev(1) = Elevations(pathRow(1), 1);

	% Follow trail
	for c = 2 : colCount
		% int8 -> int32 conversion needed to prevent overflow
		pathRow(c) = pathRow(c - 1) + int32(Trail(pathRow(c - 1), c - 1)) - 2;
		pathElev(c) = Elevations(pathRow(c), c);
	end

end

function costCol = GetCol(c)
	costCol = mod(c, 2) + 1;
end
