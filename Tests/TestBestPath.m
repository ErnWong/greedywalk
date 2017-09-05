function [testCount, okayCount] = TestBestPath()

	clear;

	fprintf('\n\n');

	disp('# .--------------------.');
	disp('# | Testing BestPath.m |');
	disp('# `--------------------`');

	testCount = 9;
	okayCount = 0;
	fprintf('\n');
	fprintf('1..%d\n', testCount);
	fprintf('\n');

	if true
	  disp('# Beginning brute force test');
	  tic;
	  hasErrored = false;
	  k = 3;
	  for e9 = 1:k
		for e8 = 1:k
		  for e7 = 1:k
			for e6 = 1:k
			  for e5 = 1:k
				for e4 = 1:k
				  for e3 = 1:k
					for e2 = 1:k
					  for e1 = 1:k
						E = [e1 e2 e3; e4 e5 e6; e7 e8 e9];
						testNum = e1 + e2*k + e3*k^2  + e4*k^3+ e5*k^4 + e6*k^5 + e7*k^6 + e8*k^7 + e9*k^8;
						bestCost = inf;
						for r1 = 1:3
						  for r2 = 1:3
							if abs(r2 - r1) > 1
							  continue;
							end
							cost1 = abs(E(r2,2) - E(r1,1));
							for r3 = 1 : 3
							  if abs(r3 - r2) > 1
								continue;
							  end
							  cost2 = abs(E(r3,3) - E(r2,2)) + cost1;
							  if (cost2 < bestCost)
								bestCost = cost2;
							  end
							end
						  end
						end
						[pathRows, ~, elev] = BestPath(E);
						daCost = abs(elev(3) - elev(2)) + abs(elev(2) - elev(1));
						if bestCost == daCost
						  % fprintf('ok %d', testNum);
						else
						  hasErrored = true;
						  fprintf('# not okay 1.%d - E = [%d %d %d; %d %d %d; %d %d %d]\n', testNum, e1, e2, e3, e4, e5, e6, e7, e8, e9);
						  fprintf('# The brute force best cost was %d\n', bestCost);
						  fprintf('# The resulting best cost was %d\n', daCost);
						  fprintf('# pathRows: %d %d %d\n', pathRows(1), pathRows(2), pathRows(3));
						  fprintf('# elev    : %d %d %d\n', elev(1), elev(2), elev(3));
						end
					  end
					end
				  end
				end
			  end
			end
		  end
		end
	  end
	  toc;
	  if ~hasErrored
		fprintf('# Brute force tested %d inputs\n', k^9);
		fprintf('ok 1 - Brute force test completed without error!\n');
		okayCount = okayCount + 1;
	  else
		fprintf('not ok 1 - See messages above\n');
	  end
	end

	E2 = [
	  3 5 5 4 1 3 5 1
	];
	okayCount = okayCount + TestFunction(@BestPath, 2, {E2}, {[1 1 1 1 1 1 1 1], [1 2 3 4 5 6 7 8], [3 5 5 4 1 3 5 1]});

	E3 = [
	  1 3 4;
	  8 7 6
	];
	okayCount = okayCount + TestFunction(@BestPath, 3, {E3}, {[2 2 2], [1 2 3], [8 7 6]});

	E4 = [
	  1 2;
	  2 2
	];
	okayCount = okayCount + TestFunction(@BestPath, 4, {E4}, {[2 1], [1 2], [2 2]});

	E5 = [
	  1;
	  4;
	  3;
	  2
	];
	okayCount = okayCount + TestFunction(@BestPath, 5, {E5}, {[1], [1], [1]});

	E6 = [
	  2 4 3;
	  5 3 1;
	];
	okayCount = okayCount + TestFunction(@BestPath, 6, {E6}, {[1 2 1], [1 2 3], [2 3 3]});

	E7 = [
	  5 1 1;
	  5 2 5;
	  1 1 5
	];
	okayCount = okayCount + TestFunction(@BestPath, 7, {E7}, {[3 2 1], [1 2 3], [1 2 1]});

	E8 = [
	  5 0 5 0;
	  1 1 1 10;
	  7 0 7 0;
	  8 0 8 0;
	  3 3 3 100;
	  0 9 3 3;
	  100 9 9 9;
	  9 9 9 100
	];
	okayCount = okayCount + TestFunction(@BestPath, 8, {E8}, {[5 5 5 6], [1 2 3 4], [3 3 3 3]});

	E9 = [
	  1 0 1 5;
	  5 1 1 5;
	  5 1 0 5;
	  5 0 2 2
	];
	okayCount = okayCount + TestFunction(@BestPath, 9, {E9}, {[1 2 3 4], [1 2 3 4], [1 1 0 2]});


	disp('# Generating Visual Test');
	s = 1000;
	fprintf('# Map size: %d * %d = %d\n', s, s, s^2);
	disp('# Generating Map');
	E = GenerateHills(s);
	disp('# Computing Path');
	tic;
	[pathRow, pathCol, pathElev] = BestPath(E);
	toc;
	disp('# Adding path to surface color data');
	C = E;
	for c = pathCol
		C(pathRow(c), c) = 1.5;
	end
	disp('# Plotting');
	figure(1);
	s = surf(E, C, 'EdgeColor', 'none');
	s.FaceLighting = 'gouraud';
	camlight left;
	lighting phong;
	xlabel('Columns');
	ylabel('Rows');
	figure(2);
	contourf(E, 30);
	hold on;
	plot(pathCol, pathRow, 'r');
	xlabel('Columns');
	ylabel('Rows');
	hold off;
	disp('# Visual test generated. Please take a look.');


	fprintf('\n# TestBestPath - %d / %d tests passed\n', okayCount, testCount);
	disp('# TestBestPath - Done');
	fprintf('\n\n');

end
