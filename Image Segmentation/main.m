f = imread('seg.jpg');

% Select ROI interactively
mask = roipoly(f);

% Get ROI
g = cat(3, immultiply(mask, f(:,:,1)), immultiply(mask, f(:,:,2)), ...
    immultiply(mask, f(:,:,3)));
% figure, imshow(g);

% Calculate mean and convariance
[M, N, K] = size(g);
I = reshape(g, M*N, K);
idx = find(mask);
I = double(I(idx, 1:3));
[C, m] = covmatrix(I);

% Estimate Threshold
% sd = sqrt(diag(C))';

% Apply to image
M25 = colorseg('mahalanobis', f, 25, m, C);
% figure, imshow(M25);

M25(:,:,2) = M25;
M25(:,:,3) = M25(:,:,1);

h = immultiply(logical(M25), f);
figure, imshow(h);