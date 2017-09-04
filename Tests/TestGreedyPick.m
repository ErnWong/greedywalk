function [testCount, okayCount] = TestGreedyPick()

	clear;

	fprintf('\n\n');

	disp('# .----------------------.');
	disp('# | Testing GreedyPick.m |');
	disp('# `----------------------`');

	testCount = 14;
	okayCount = 0;

	fprintf('\n');
	disp('1..14');
	fprintf('\n');

	E = [3 6 3 7 2 5; 1 4 2 4 1 4; 7 9 5 6 9 2; 10 8 4 3 10 5];

	okayCount = okayCount + TestFunction(@GreedyPick, 1, {[3 1], 1, E}, {[4 2]});
	okayCount = okayCount + TestFunction(@GreedyPick, 2, {[4 2], 1, E}, {[3 3]});
	okayCount = okayCount + TestFunction(@GreedyPick, 3, {[3 3], 1, E}, {[2 4]});
	okayCount = okayCount + TestFunction(@GreedyPick, 4, {[2 4], 1, E}, {[1 5]});
	okayCount = okayCount + TestFunction(@GreedyPick, 5, {[1 5], 1, E}, {[2 6]});

	okayCount = okayCount + TestFunction(@GreedyPick,  6, {[3 6], -1, E}, {[2 5]});
	okayCount = okayCount + TestFunction(@GreedyPick,  7, {[2 5], -1, E}, {[2 4]});
	okayCount = okayCount + TestFunction(@GreedyPick,  8, {[2 4], -1, E}, {[1 3]});
	okayCount = okayCount + TestFunction(@GreedyPick,  9, {[1 3], -1, E}, {[2 2]});
	okayCount = okayCount + TestFunction(@GreedyPick, 10, {[2 2], -1, E}, {[1 1]});

	okayCount = okayCount + TestFunction(@GreedyPick, 11, {[2 2], 1, [1 5 2; 3 1 4; 2 2 1]}, {[3 3]});
	okayCount = okayCount + TestFunction(@GreedyPick, 12, {[2 1], 1, [1 2; 2 1]}, {[1 2]});
	okayCount = okayCount + TestFunction(@GreedyPick, 13, {[2 1], 1, [1 1; 1 1; 1 1]}, {[1 2]});
	okayCount = okayCount + TestFunction(@GreedyPick, 14, {[2 2], -1, [1 1; 1 1; 1 1]}, {[1 1]});

	fprintf('\n# TestGreedyPick - %d / %d tests passed\n', okayCount, testCount);
	disp('# TestGreedyPick - Done');
	fprintf('\n\n');

end
