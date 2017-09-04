function E = GenerateHills(n)
% E = GenerateHills(n)
%
% Generates a square 2d nxn surface by convoluting a normally
% distributed random surface with a gaussian filter.
%
% Inspired from David Bergström's rgene2D.m algorithm found here:
% www.mysimlabs.com/surface_generation.html

	x = linspace(-5, 5, n);
	y = linspace(-5, 5, n);
	[X, Y] = meshgrid(x, y);
	NoiseMap = randn(n);

	GaussianFilter = exp(-sqrt(X.^2 + Y.^2) / 1);
	E = 5 / n * ifft2(fft2(NoiseMap) .* fft2(GaussianFilter));

end
