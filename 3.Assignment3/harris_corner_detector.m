function [H, r, c] = harris_corner_detector(img_path)
% Function to perform Harris Corner Detection.
% Takes in path to image.
% Returns the cornerness matrix H and the coordinates of the cornerpoints

% Suppress error for memory pre-allocation
%#ok<*AGROW>
%% params
kernel_size = 5;
sigma = 1.7;
window_size = 10;
threshold = 2e-7;
% rotate image flag
rotate_img = false;
plot_flag = false;

%% image operations

% if no file path is given, use standard image
if nargin == 0
    img_path = 'person_toy/00000001.jpg';
end

% read image
imgin = imread(img_path);

% rotate if asked
if rotate_img
    angle = rand * 360;
    imgin = imrotate(imgin, angle);
end
img = rgb2gray(imgin);
img = im2double(img);


%% calculate Ix, A, B, C and H
G = fspecial('gaussian', kernel_size, sigma);
[Gx, Gy] = gradient(G);

% convolve f.o. gaussian derivatives with image along each direction
Ix = conv2(img, Gx, 'same');
Iy = conv2(img, Gy, 'same');

% convolve smoothed derivatives with gaussian
A = conv2(Ix.^2, G, 'same');
B = conv2(Ix.*Iy, G, 'same');
C = conv2(Iy.^2, G, 'same');
H = (A.*C - B.^2) - 0.04*(A+C).^2;

r = [];
c = [];

%% Corner Detection
for i = 1 + window_size: size(H,1) - window_size
    for j = 1 + window_size: size(H,2) - window_size
       window = H(i-window_size:i+window_size, j-window_size:j+window_size);
       if H(i,j) == max(window(:)) && H(i,j) > threshold
           r(end+1) = i; 
           c(end+1) = j;
       end
    end
end

%% Plots
close all;

% If all plots need to be done, plot I_x and I_y
if plot_flag
    figure('Name', 'Ix', 'NumberTitle', 'off')
    imshow(Ix, [min(Ix(:)), max(Ix(:))]); 
    figure('Name', 'Iy', 'NumberTitle', 'off')
    imshow(Iy, [min(Iy(:)), max(Iy(:))])
end
figure('Name', 'Harris Corners', 'NumberTitle', 'off')
imshow(imgin);
hold on;
scatter(c, r, 80, 'r', 'Marker', '.')

end