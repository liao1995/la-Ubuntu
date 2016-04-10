function [T, SM] = otsuthresh(h)
%OTSUTHRESH Otsu's optimum threshold given a histogram.
%   [T, SM] = OTSUTHRESH(H) computes an optimum threshold, T, in the range
%   [0, 1] using Otsu's method for a given a histogram, H.

% Normalize the histogram to unit area. If h is already normalized, the
% following operation has no affect.
h = h/sum(h);
h = h(:); % h must be a column vector for processing below.

% All the possible intensities represented in the histogram (256 for 8 
% bits).
i = (1:numel(h))';

% Values of P1 for all values of k.
P1 = cumsum(h);

% Values of the mean for all values of k.
m = cumsum(i.*h);

% The image mean
mG = m(end);

% The between class variance.
sigSquard = ((mG*P1 - m).^2)./(P1.*(1-P1)+eps);

% Find the maximum of sigSquard.
maxSigsq = max(sigSquard);
T = mean(find(sigSquard == maxSigsq));

T = (T - 1)/(numel(h) - 1);

SM = maxSigsq / (sum(((i-mG).^2).*h) +eps);