function [pathRows, pathCols, elev] = BestGreedyPath(Elevations)

	[dataRowCount, colCount] = size(Elevations);

	% Number of rows for padded 2d array
	rowCount = dataRowCount + 2;

	% Rows which refer to actual elevation data
	dataRows = 2 : rowCount - 1;

	% Elevations array padded with 1 row of NaNs
	% above and below array.
	E([1,rowCount],1:colCount) = NaN;
	E(dataRows,:) = Elevations;

	% [-1 0 1] in the z dimension for refering to neighbours
	ZOffsets = permute([-1 0 1], [1 3 2]);

	% Linear indices for each position
	% Indices2D =
	%    2    rowCount+2   2*rowCount+2
	%    3    rowCount+3   2*rowCount+3  etc
	%    4    rowCount+4   2*rowCount+4
	%    etc   etc              etc
	Indices2D = bsxfun(@plus, dataRows', (0:colCount-1)*rowCount);

	% The number in the (a,b,c) location refers to
	% the c'th neighbour of row a in the data grid
	% For East, 'b' refers to column (b+1) neighbours of column b.
	% For West, 'b' refers to column b neighbours of column (b+1).
	EastNeighbours3D = bsxfun(@plus, ZOffsets, Indices2D(:,2:end));
	WestNeighbours3D = bsxfun(@plus, ZOffsets, Indices2D(:,1:end-1));

	% 3D array related to Neighbours3D, where the number in
	% the (a,b,c) location refers to the absolute elvation change
	% associated with climbing from row a (data grid) to the
	% c'th neighbour.
	% For East, 'b' refers to column b climbing into column (b+1).
	% For West, 'b' refers to column (b+1) climbing into column b.
	EastNeighboursCosts = ...
		abs(bsxfun(@minus, E(dataRows,1:end-1), E(EastNeighbours3D)));
	WestNeighboursCosts = ...
		abs(bsxfun(@minus, E(dataRows,2:end),   E(WestNeighbours3D)));

	% ImmediateCosts:
	%   2D array where the number in the (r,c) location refers to the
	%   elevation change resulted by the greedy pick at row r
	% NextNums:
	%   2D array where the number in the (r,c) location refers to the
	%   nth neighbour which was picked.
	%   Note: n = 1 or 2 or 3 refers to rows r-1, r, and r+1 respectively
	% For East, 'c' refers to column c climbing into column (c+1).
	% For West, 'c' refers to column (c+1) climbing into column c.
	[EastImmediateCosts, EastNextNums] = min(EastNeighboursCosts, [], 3);
	[WestImmediateCosts, WestNextNums] = min(WestNeighboursCosts, [], 3);

	% Resolves NextNums [nth neighbours] --> [row numbers]
	% The column 'c' of these arrays refers to the following.
	% For East, 'c' refers to column c climbing into column (c+1).
	% For West, 'c' refers to column (c+1) climbing into column c.
	EastNextRows = bsxfun(@plus, EastNextNums, (-1:dataRowCount-2)');
	WestNextRows = bsxfun(@plus, WestNextNums, (-1:dataRowCount-2)');

	% 2D array where the number in the (r,c) location refers to the
	% cost needed to start from that location and greedily walk
	% to the associated edge of the map.
	EastTotalCosts = zeros(dataRowCount, colCount);
	WestTotalCosts = zeros(dataRowCount, colCount);

	% EastTotalCosts = total cost associated with the next neighbour
	%                  of the current position + the immediate
	%                  elevation change of going into that neighbour.
	% The column 'c' used to index NextRows and ImmediateCosts refer
	% to the current column.
	for c = colCount-1 : -1 : 1
		EastTotalCosts(:,c) = ...
			EastTotalCosts(EastNextRows(:,c),c+1) + EastImmediateCosts(:,c);
	end

	% WestTotalCosts = total cost associated with the next neighbour
	%                  of the current position + the immediate
	%                  elevation change of going into that neighbour.
	% The column 'c-1' used to index NextRows and ImmediateCosts refer
	% to the current column.
	for c = 2 : colCount
		WestTotalCosts(:,c) = ...
			WestTotalCosts(WestNextRows(:,c-1),c-1) + WestImmediateCosts(:,c-1);
	end

	% The cost of starting at position (r,c)
	% This represents the cost of the path created by joining
	% the greedy path heading east and greedy path heading west starting from
	% that location.
	TotalCosts = EastTotalCosts + WestTotalCosts;

	% Finding the best greedy path row first, then columns
	% (1) startColsGivenRow and bestCostsGivenRow are column vectors,
	%     with each row refering to the best of each row.
	% (2) startRow refers to the best of the column vector of costs.
	[bestCostsGivenRow, startColsGivenRow] = min(TotalCosts, [], 2);
	[~, startRow] = min(bestCostsGivenRow, [], 1);
	startCol = startColsGivenRow(startRow);

	% Preallocating and initializing output path info
	pathRows = zeros(1, colCount);
	pathCols = 1 : colCount;
	elev = zeros(1, colCount);

	% Set starting point info
	pathRows(startCol) = startRow;
	elev(startCol) = Elevations(startRow, startCol);

	% Follow the path east and west to rebuild the entire path
	for c = startCol - 1 : -1 : 1
		pathRows(c) = WestNextRows(pathRows(c+1),c);
		elev(c) = Elevations(pathRows(c), c);
	end
	for c = startCol + 1 : colCount
		pathRows(c) = EastNextRows(pathRows(c-1),c-1);
		elev(c) = Elevations(pathRows(c), c);
	end

end
