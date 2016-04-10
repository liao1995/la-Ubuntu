function g = localthresh(f, nhood, a, b, meantypes)
%LOCALTHRESH Local thresholding.
%   G = LOCALTHRESH(F, NHOOD, A, B, MEANTYPES) thresholds image F by
%   computing a local threshold at the center (x, y), of every neighborhood
%   in F. The size of the neighborhood is defined by NHOOD, an array of
%   zeros and ones in which the nonzero elements specify the neighbors used
%   in the computation of the local mean and standard deviation. The size
%   of NHOOD must be odd in both dimensions.
%
%   The segmented image is given bt
%
%           1   if (F > A*SIG) AND (F > B*MEAN)
%       G =
%           0   otherwise
%
%   where SIG is an array of the same size as F containing the local
%   standard deviations. If MEANTYPE = 'local' (the default), then MEAN is
%   an array of local means. If MEANTYPE = 'global', then MEAN is the
%   global (image) mean, a scalar. Constants A and B are nonnegative
%   scalars.

% Intialize
f = tofloat(f);

% Compute the local standard deviation.
SIG = stdfilt(f, nhood);
% Compute MEAN.
if nargin == 5 && strcmp(meantypes, 'global')
    MEAN = mean2(f);
else
    MEAN = localmean(f, nhood); % This is a custom function.
end

% Obtain the segmented image.
g = (f > a*SIG) & (f > b*MEAN);