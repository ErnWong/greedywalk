function [pathRow, pathCol, pathElev] = BestPath(E)
% Project - BestPath
%
% [pathRow, pathCol, pathElev] = BestPath(E)
%
% Generates the path with minimal cost, where cost equates to
% the sum of all (absolute) elevation changes encountered in
% the path. This algorithm completes in O(n) time where n=R*C
% is the number of elements in the 2d array E.
%
% Implementation Sumary:
%
% This algorithm works by solving for the smallest subset
% of this problem, and repetitively reusing the sub-solutions
% to solve for it's immediate problem supersets until the solution
% for the entire problem is solved. In essence, this is dynamic programming,
% meaning that this is a complete search with memoization. This particular
% implementation is iterative rather than recursive, so that it solves
% breadth-first instead of depth-first, allowing smaller memory consumption.
%
% Proof of correctness:
%
%   We will prove that the algorithm's output path has a total cost value that
%   is minimal using proof by induction.
%
%   Definitions:
%     R = number of rows = row number of the last row
%     C = number of columns = column number of the last column
%     mincost(r,c) = the minimum total cost of all the possible paths starting
%                 from row r and column c, and ending in column C in any row.
%                 (NOTE: this does not assume that these subpaths are part of
%                        the overall optimal path of the main problem)
%     elevChange(r1,c1,r2,c2) = the absolute elevation change beetween the
%                 position at (r1,c1) to (r2,c2).
%   Note:
%     - A path is an ordered list of positions, each described
%       by a row and column (r,c).
%     - A path is only valid if the column numbers are sequentially increasing.
%
%
%   (1) BASE CASE
%   -------------
%
%
%   Consider any point with column number c = C, i.e. on the eastern-most edge.
%   As there are no more column numbers after c = C, the only valid path
%   would be the single point itself.
%
%               c=1                c=C
%            r=1.--------------------.
%               |                    |
%               |                   X|     position X = (r,C)
%               |                    |
%               |                    |
%               |                    |
%               |                    |
%               |                    |
%            r=R`--------------------`
%
%
%
%   Therefore, there will be no elevation change, meaning that:
%
%             .--------------------------------------------.
%             |   mincost(r,C) = 0 for all row numbers r   |
%             `--------------------------------------------`
%
%
%   (2) INDUCTIVE STEP
%   ------------------
%
%
%   Consider any point at row r and column c, and assume that mincost(r2,c+1)
%   is correct for any row r2.
%
%               c=1                c=C
%            r=1.--------------------.
%               |            .       |
%               |            .       |     position X = (r,c)
%               |            .       |
%               |           X.       |     dots (.) represent positions
%               |            .       |     at column c+1. Assume mincost is
%               |            .       |     correct at those positions.
%               |            .       |
%            r=R`--------------------`
%
%   Our aim of this step is to find the path starting from this point (r,c)
%   and ending in column C such that the cost of this path is minimised.
%
%               c=1                c=C
%            r=1.--------------------.
%               |                    |
%               |                    |
%               |      (r,c)         |
%               |           X------->|
%               |                    |
%               |                    |
%               |                    |
%            r=R`--------------------`
%
%   The first point of this path is the point (r,c) itself. There are 1, 2, or
%   3 possibilities for the second path: (r-1,c+1), (r,c+1), and (r+1,c+1)
%   depending on whether the current point (r,c) is on the row edge of the map.
%
%               c=1         c c+1  c=C
%            r=1.--------------------.
%               |                    |
%               |                    |
%            r-1|            .O      |  O = possible second point of
%            r  |           X-O      |      the path
%            r+1|            `O      |
%               |                    |
%               |                    |
%            r=R`--------------------`
%
%   Now consider that the optimal path uses (r2,c+1) as the second point.
%   The total cost of this path would equal to:
%
%      cost(r,c) = elevChange(r,c,r2,c+1) + the cost of the remaining path.
%
%               c=1         c      c=C
%            r=1.--------------------.
%               |                    |
%               |      remaining path|
%               |              <---->|
%               |                    |
%               |            .O----->|  O = assumed second point of
%            r  |           X        |      the path
%               |           <->      |
%               |            |       |
%               |      elevChange    |
%            r=R`--------------------`
%
%   For this given (r2,c+1) second point, note that the only parameter that
%   can be varied is the cost of the remaining path, meaning that to minimise
%   the cost of the entire path, we need to minimise the cost of the remaining
%   path:
%
%   mincost(r,c) = elevChange(r,c,r2,c+1) + min(the cost of the remaining path)
%   ^^^                                     ^^^^
%
%   Note that this is only valid for a GIVEN second point (r2,c+1).
%   ( To prove this argument, assume the opposite. Assume that for a given   )
%   ( second point (r2,c+1) that the cost of the remaining path is not       )
%   ( the minimum. This means that there exists another path                 )
%   ( starting from (r2,c+1) such that the cost is lower than the current    )
%   ( remaining path we're using. Since the remaining path has no influence  )
%   ( on elevChange, it follows that using this lower-costing path yields a  )
%   ( lower mincost value. This contradicts our assumption, so mincost       )
%   ( must be using the remaining path of minimal cost.                      )
%
%   The minimum cost of the remaining path is the same as
%   mincost(r2,c+1) by definition, so now the equation
%   simplifies to the following:
%
%             mincost(r,c) = elevChange(r,c,r2,c+1) + mincost(r2,c+1)
%                                                     ^^^^^^^^^^^^^^^
%
%   That is for a given second point. The next step is to figure out
%   which of the 1, 2, or 3 possible points is the second point.
%
%               c=1         c c+1  c=C
%            r=1.--------------------.
%               |                    |
%               |                    |
%            r-1|            .O      |  O = possible second points of
%            r  |           X-O      |      the path. Which one
%            r+1|            `O      |      is the optimal one?
%               |                    |
%               |                    |
%            r=R`--------------------`
%
%   We want the r2 value such that this cost value is minimised.
%   Remember that r2 could be (r-1), r or (r+1) for non-edge rows r.
%   Using the same argument as before, we arrive at the following relationship:
%
%    .-----------------------------------------------------------------------.
%    |                                                                       |
%    |                     /  elevChange(r,c,r-1,c+1) + mincost(r-1,c+1), \  |
%    |  mincost(r,c) = min |  elevChange(r,c,r  ,c+1) + mincost(r  ,c+1), |  |
%    |                     \  elevChange(r,c,r+1,c+1) + mincost(r+1,c+1)  /  |
%    |                                                                       |
%    `-----------------------------------------------------------------------`
%
%   Note that if the row r is a row edge, then the same relationship applies
%   except that one of the rows (r-1) or (r+1) is nonexistent and is excluded
%   from the relationship.
%
%
%   (3) THE SOLUTION TO THE OVERALL PROBLEM
%   ---------------------------------------
%
%   The above recursive relationship, we can correctly calculate mincost(r,1)
%   for all elements in the first column. This gives the minimum cost that
%   can be achieved when starting at row r.
%
%   The optimum path is therefore achieved by starting at the row with the
%   lowest mincost.
%
%   =====
%    QED
%   =====
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

	% Preallocation

	% Costs - the minimum cost to travel from the position to the east edge
	%       - Note: uses GetCol to alternate between current and previous costs
	Costs = zeros(rowCount, 2);

	% Prev - the optimal next position to travel to relative to current row
	%      - -1 for row (r-1), 0 for row (r), +1 for row (r+1)
	Prev = zeros(rowCount, colCount, 'int8');

	% Compute from east to west, going down rows first
	for c = (colCount - 1) : -1 : 1
		for r = 1 : rowCount
			[Costs(r, GetCol(c)), i] = min([
				GetCost(E, Costs, rowCount, r, c, -1),
				GetCost(E, Costs, rowCount, r, c, 0),
				GetCost(E, Costs, rowCount, r, c, +1)
			]);
			Prev(r, c) = i - 2;
		end
	end

	% Generate path information from trails.
	pathCol = 1 : colCount;
	pathRow = zeros(1, colCount);
	pathElev = zeros(1, colCount, 'int32');
	[bestCost, pathRow(1)] = min(Costs(:,GetCol(1)));
	pathElev(1) = E(pathRow(1), 1);
	for c = 2 : colCount
		pathRow(c) = pathRow(c - 1) + int32(Prev(pathRow(c - 1), c - 1));
		pathElev(c) = E(pathRow(c), c);
	end

end

function cost = GetCost(E, Costs, rowCount, r, c, offset)
% This helper local function computes the total cost
	r2 = r + offset;
	if 1 <= r2 && r2 <= rowCount
		cost = Costs(r2, GetCol(c + 1)) + abs(E(r, c) - E(r2, c + 1));
	else
		cost = inf;
	end
end

function costCol = GetCol(c)
	costCol = mod(c, 2) + 1;
end
