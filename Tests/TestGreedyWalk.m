function [testCount, okayCount] = TestGreedyWalk()

	clear;

	fprintf('\n\n');

	disp('# .----------------------.');
	disp('# | Testing GreedyWalk.m |');
	disp('# `----------------------`');

	testCount = 11;
	okayCount = 0;

	fprintf('\n');
	fprintf('1..%d\n', testCount);
	fprintf('\n');

	E = [3 6 3 7 2 5; 1 4 2 4 1 4; 7 9 5 6 9 2; 10 8 4 3 10 5];

	okayCount = okayCount + TestFunction(@GreedyWalk, 1, {[3 1], +1, E}, {[3 4 3 2 1 2], [1 2 3 4 5 6]});
	okayCount = okayCount + TestFunction(@GreedyWalk, 2, {[3 3], +1, E}, {[    3 2 1 2], [    3 4 5 6]});
	okayCount = okayCount + TestFunction(@GreedyWalk, 3, {[2 6], +1, E}, {[          2], [          6]});

	okayCount = okayCount + TestFunction(@GreedyWalk, 4, {[3 6], -1, E}, {[3 2 2 1 2 1], [6 5 4 3 2 1]});
	okayCount = okayCount + TestFunction(@GreedyWalk, 5, {[1 3], -1, E}, {[      1 2 1], [      3 2 1]});
	okayCount = okayCount + TestFunction(@GreedyWalk, 6, {[1 1], -1, E}, {[          1], [          1]});

	okayCount = okayCount + TestFunction(@GreedyWalk, 7, {[2 1], +1, [1 3 2; 2 4 3]}, {[2 1 2], [1 2 3]});
	okayCount = okayCount + TestFunction(@GreedyWalk, 8, {[1 2], +1, [1 3 2; 2 4 3]}, {[  1 2], [  2 3]});
	okayCount = okayCount + TestFunction(@GreedyWalk, 9, {[2 3], +1, [1 3 2; 2 4 3]}, {[    2], [    3]});

	okayCount = okayCount + TestFunction(@GreedyWalk, 10, {[1 1], +1, [1 2; 2 1]}, {[1 2], [1 2]});
	okayCount = okayCount + TestFunction(@GreedyWalk, 11, {[1 2], -1, [1 1; 2 1]}, {[1 1], [2 1]});

	fprintf('\n# TestGreedyWalk - %d / %d tests passed\n', okayCount, testCount);
	disp('# TestGreedyWalk - Done');
	fprintf('\n\n');

end
