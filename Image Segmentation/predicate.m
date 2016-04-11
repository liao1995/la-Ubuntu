function flag = predicate(region)
%PREDICATE Check whether the region divided or not
%   function FLAG = PREDICATE(REGION) It sets FLAG to TRUE if the
%   intensities of the pixels in REGION have a standard deviation that
%   exceeds 10, and their mean intensity is between 0 and 125. Otherwise
%   FLAG is set to false.

sd = std2(region);
m = mean2(region);
flag = (sd > 0.04) & (m > 0) & (m < 0.5);