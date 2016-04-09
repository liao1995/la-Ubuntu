f = im2double(rgb2gray(imread('test.jpg')));
% f = im2double(imread('test.jpg'));

% Initialize threshold mean of intensity
T = mean2(f); % T = mean(f(:));
delta_T = 0.001;
T0 = -2;
count = 0;

while abs(T-T0) > delta_T 
    % Update T
    m1 = mean(f(f < T));
    m2 = mean(f(f >= T));
    T0 = T;
    T = (m1 + m2) / 2;
    count = count + 1;
end

% Segmentation
g = im2bw(f, T);
figure, imshow(g);
    