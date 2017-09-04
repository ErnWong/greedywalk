function isOkay = TestFunction(fn, testNum, inputs, expectedOutputs)
% Utility - TestFunction
%
% Evaluates given function with given inputs,
% and checks it towards the given expectedOutputs and
% displays the success/error in TAP format.
%
% Example:
%     TestFunction(@Reverse, 4, {[1 5 4 5 3]}, {[3 5 4 5 1]});
%
% Inputs: fn              = function handle to test,
%         testNum         = which test number this is (integer)
%         inputs          = a cell array of inputs
%         expectedOutputs = a cell array of outputs to expect
%
% Author: Ernest Wong (ewon746)
% Date: 2017-09-03

	isOkay = false;
	outputCount = size(expectedOutputs);
	outputs = cell(outputCount);
	[outputs{:}] = feval(fn, inputs{:});
	for i = 1 : outputCount
		if any(outputs{i} ~= expectedOutputs{i})
			fprintf('not ok %d - incorrect output %d\n', testNum, i);
			return
		end
	end
	isOkay = true;
	fprintf('ok %d\n', testNum);

end
