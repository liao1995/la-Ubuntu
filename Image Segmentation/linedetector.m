f = im2double(rgb2gray(imread('ali.jpg')));

% Filter mask - | / \
R1 = [-1 -1 -1; 2 2 2; -1 -1 -1];
R2 = [-1 2 -1; -1 2 -1; -1 2 -1];
R3 = [-1 -1 2; -1 2 -1; 2 -1 -1];
R4 = [2 -1 -1; -1 2 -1; -1 -1 2];

% Choose maximum response
g1 = imfilter(f, R1, 'replicate');
g2 = imfilter(f, R2, 'replicate');
g3 = imfilter(f, R3, 'replicate');
g4 = imfilter(f, R4, 'replicate');

g = max(g1, g2);
g = max(g, g3);
g = max(g, g4);

figure, imshow(g);