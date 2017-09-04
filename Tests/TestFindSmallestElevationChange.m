function [testCount, okayCount] = TestFindSmallestElevationChange()

	clear;

	fprintf('\n\n');

	disp('# .---------------------------------------.');
	disp('# | Testing FindSmallestElevationChange.m |');
	disp('# `---------------------------------------`');

	testCount = 7;
	okayCount = 0;

	fprintf('\n');
	fprintf('1..%d\n', testCount);
	fprintf('\n');

	okayCount = okayCount + TestFunction(@FindSmallestElevationChange, 1, {7, [4 9 8]}, {3});
	okayCount = okayCount + TestFunction(@FindSmallestElevationChange, 2, {7, [3 7 8]}, {2});
	okayCount = okayCount + TestFunction(@FindSmallestElevationChange, 3, {3, [2 7 4 5]}, {[1 3]});
	okayCount = okayCount + TestFunction(@FindSmallestElevationChange, 4, {5, [10 4]}, {2});
	okayCount = okayCount + TestFunction(@FindSmallestElevationChange, 5, {5, []}, {[]});
	okayCount = okayCount + TestFunction(@FindSmallestElevationChange, 6, {5, [7]}, {[1]});
	okayCount = okayCount + TestFunction(@FindSmallestElevationChange, 7, {5, [3 4 6]}, {[2 3]});

	fprintf('\n# TestFindSmallestElevationChange - %d / %d tests passed\n', okayCount, testCount);
	disp('# TestFindSmallestElevationChange - Done');
	fprintf('\n\n');

end
