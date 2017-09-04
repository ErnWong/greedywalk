function [testCount, okayCount] = TestReverse()

	clear;

	fprintf('\n\n');

	disp('# .-------------------.');
	disp('# | Testing Reverse.m |');
	disp('# `-------------------`');

	testCount = 7;
	okayCount = 0;

	fprintf('\n');
	fprintf('1..%d\n', testCount);
	fprintf('\n');

	okayCount = okayCount + TestFunction(@Reverse, 1, {[1 2 3 4 5]}, {[5 4 3 2 1]});
	okayCount = okayCount + TestFunction(@Reverse, 2, {[]}, {[]});
	okayCount = okayCount + TestFunction(@Reverse, 3, {[1]}, {[1]});
	okayCount = okayCount + TestFunction(@Reverse, 4, {[1 5 4 5 3]}, {[3 5 4 5 1]});
	okayCount = okayCount + TestFunction(@Reverse, 5, {[1 2 3]}, {[3 2 1]});
	okayCount = okayCount + TestFunction(@Reverse, 6, {[5 3 2 4 1]}, {[1 4 2 3 5]});
	okayCount = okayCount + TestFunction(@Reverse, 7, {[1 3 2 2 5]}, {[5 2 2 3 1]});

	fprintf('\n# TestReverse - %d / %d tests passed\n', okayCount, testCount);
	disp('# TestReverse - Done');
	fprintf('\n\n');

end
