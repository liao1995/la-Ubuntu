% global threshold based on edge

f = im2double(rgb2gray(imread('lena.jpg')));

% 1. Obtain the edge of image using edge detector algorithm
e = edge(f, 'sobel');

% GRADIENT
% sx = fspecial('sobel');
% sy = sx';
% gx = imfilter(f, sx, 'replicate');
% gy = imfilter(f, sy, 'replicate');
% e = sqrt(gx.*gx + gy.*gy);
% e = e / max(e(:));

% LAPLACE
% w = [-1 -1 -1; -1 8 -1; -1 -1 -1];
% e = abs(imfilter(f, w, 'replicate'));
% e = e / max(e(:));

e = immultiply(f, logical(e));

% 2. Calculate a threshold using percentile 90%
h = imhist(f);
T = percentile2i(h, 0.9);

% 3. Segmentation of edge image using threshold
g = im2bw(e, T);

% 4. Using pixel (g == 1) calulate a threshold by Otsu method
g = immultiply(f, logical(g));
h = imhist(g);
h(1) = 0; % get rid of the influence of zeros
[T, SM] = otsuthresh(h);

% 5. Image Segmentation
result = im2bw(f, T);
