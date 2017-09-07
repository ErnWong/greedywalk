function[testCount, okayCount] = TestBestGreedyPath()

	clear;

	fprintf('\n\n');

	disp('# .--------------------------.');
	disp('# | Testing BestGreedyPath.m |');
	disp('# `--------------------------`');

	testCount = 11;
	okayCount = 0;

	fprintf('\n');
	fprintf('1..%d\n', testCount);
	fprintf('\n');

	E1 = [
	   3 6 3 7  2 5;
	   1 4 2 4  1 4;
	   7 9 5 6  9 2;
	  10 8 4 3 10 5
	];
	okayCount = okayCount + TestFunction(@BestGreedyPath, 1, {E1}, {[1 2 1 2 1 2], [1 2 3 4 5 6], [3 4 3 4 2 4]});

	E2 = [
	  3 5 5 4 1 3 5 1
	];
	okayCount = okayCount + TestFunction(@BestGreedyPath, 2, {E2}, {[1 1 1 1 1 1 1 1], [1 2 3 4 5 6 7 8], [3 5 5 4 1 3 5 1]});

	E3 = [
	  1 3 4;
	  8 7 6
	];
	okayCount = okayCount + TestFunction(@BestGreedyPath, 3, {E3}, {[2 2 2], [1 2 3], [8 7 6]});

	E4 = [
	  1 2;
	  2 2
	];
	okayCount = okayCount + TestFunction(@BestGreedyPath, 4, {E4}, {[2 1], [1 2], [2 2]});

	E5 = [
	  1;
	  4;
	  3;
	  2
	];
	okayCount = okayCount + TestFunction(@BestGreedyPath, 5, {E5}, {[1], [1], [1]});

	E6 = [
	  2 4 3;
	  5 3 1;
	];
	okayCount = okayCount + TestFunction(@BestGreedyPath, 6, {E6}, {[1 2 1], [1 2 3], [2 3 3]});

	E7 = [
	  5 1 1;
	  5 2 5;
	  1 1 5
	];
	okayCount = okayCount + TestFunction(@BestGreedyPath, 7, {E7}, {[3 2 1], [1 2 3], [1 2 1]});

	for i = 1:4
		fprintf('# Performance Test %d\n', i);
		disp('# (1) Generating elevations');
		E = randi(1000, 100);
		disp('# (2) Running BestGreedyPath');
		tic;
		BestGreedyPath(E);
		t = toc;
		fprintf('# ==> BestGreedyPath took %f seconds\n', t);
		if t < 10
			okayCount = okayCount + 1;
			fprintf('ok %d\n', 7 + i);
		else
			fprintf('not ok %d\n', 7 + i);
		end
	end

	fprintf('\n# TestBestGreedyPath - %d / %d tests passed\n', okayCount, testCount);
	disp('# TestBestGreedyPath - Done');
	fprintf('\n\n');

end
