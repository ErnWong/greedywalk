function [testCount, okayCount] = TestFindPathElevationsAndCost()

	clear;

	fprintf('\n\n');

	disp('# .------------------------------------.');
	disp('# | Testing FindPathElevationsAndCost.m |');
	disp('# `------------------------------------`');

	testCount = 3;
	okayCount = 0;

	fprintf('\n');
	fprintf('1..%d\n', testCount);
	fprintf('\n');

	E = [3 6 3 7 2 5; 1 4 2 4 1 4; 7 9 5 6 9 2; 10 8 4 3 10 5];

	okayCount = okayCount + TestFunction(@FindPathElevationsAndCost, 1, {[3 4 3 2 1 2], [1 2 3 4 5 6], E}, {[7 8 5 4 2 4], 9});
	okayCount = okayCount + TestFunction(@FindPathElevationsAndCost, 2, {[3 2 2 1 2 1], [6 5 4 3 2 1], E}, {[2 1 4 3 4 3], 7});
	okayCount = okayCount + TestFunction(@FindPathElevationsAndCost, 3, {[1 2 1], [1 2 3], [1 2 3; 4 5 6]}, {[1 5 3], 6});

	fprintf('\n# TestFindPathElevationsAndCost - %d / %d tests passed\n', okayCount, testCount);
	disp('# TestFindPathElevationsAndCost - Done');
	fprintf('\n\n');

end
