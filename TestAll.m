clc;
clf;
disp('# Clearing workspace and caches');
clear all;

addpath('Tests');
addpath('Tests/Lib');

testCount = [];
okayCount = [];

[testCount(1), okayCount(1)] = TestReverse;
[testCount(2), okayCount(2)] = TestFindSmallestElevationChange;
[testCount(3), okayCount(3)] = TestGreedyPick;
[testCount(4), okayCount(4)] = TestGreedyWalk;
[testCount(5), okayCount(5)] = TestFindPathElevationsAndCost;
[testCount(6), okayCount(6)] = TestBestGreedyPathHeadingEast;
[testCount(7), okayCount(7)] = TestBestGreedyPathUnoptimized;
[testCount(8), okayCount(8)] = TestBestGreedyPath;
[testCount(9), okayCount(9)] = TestBestPath;

fprintf('\n\n# SUMMARY: %d / %d tests passed\n', sum(okayCount), sum(testCount));

rmpath('Tests/Lib');
rmpath('Tests');
