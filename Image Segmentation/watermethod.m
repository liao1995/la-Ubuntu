f = rgb2gray(imread('lena.jpg'));

% %----------------------------------------------------------
% % 1.Obtain 2-value image
% g = im2bw(f, graythresh(f));
% 
% % 2.Watershed transform
% gc = ~g;
% D = bwdist(gc);
% L = watershed(-D);
% w = L == 0;
% 
% % 3.Segmentation
% g2 = g & ~w;
% %----------------------------------------------------------



% %------------------------------------------------------------------------
% % Gradient transform
% h = fspecial('sobel');
% g = sqrt(imfilter(f, h, 'replicate').^2 + ... 
% imfilter(f, h', 'replicate').^2);
% g2 = imclose(imopen(g, ones(5,5)), ones(5,5));
% L = watershed(g2);
% wr = L == 0;
% f2 = f;
% f2(wr) = 255;
% imshow(wr);
% %------------------------------------------------------------------------



% Gradient transform
h = fspecial('sobel');
fd = tofloat(f);
g = sqrt(imfilter(fd, h, 'replicate').^2 + ... 
    imfilter(fd, h', 'replicate').^2);
% L = watershed(g);
% wr = L == 0;
rm = imregionalmin(g);
im = imextendedmin(f, 10);
Lim = watershed(bwdist(im));
em = Lim == 0;
g2 = imimposemin(g, im | em);
L2 = watershed(g2);
f2 = f;
f2(L2 == 0) = 255;
figure, imshow(f2);