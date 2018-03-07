%%
% feature tracking algorithm
%% params
regionsize = 15;

%% Harris Corner Detection

%%% person_toy image loading
files = dir('person_toy/*.jpg');    
for i = 1:(length(files) - 1)
   filename1 = char(strcat(files(i).folder,'/',files(i).name));
   filename2 = char(strcat(files(i+1).folder,'/',files(i+1).name));
   im1 = imread(filename1);
   im2 = imread(filename2);
   [H, r, c] = harris_corner_detection(filename1);
   LK(im1, im2, regionsize, r, c);
end

% 
% %%% pingpong image loading
% files = dir('pingpong/*.jpeg');    
% for i = 1:(length(files) - 1)
%    filename1 = char(strcat(files(i).folder,'/',files(i).name));
%    filename2 = char(strcat(files(i+1).folder,'/',files(i+1).name));
%    im1 = imread(filename1);
%    im2 = imread(filename2);
%    [H, r, c] = harris_corner_detection(filename1);
%    LK(im1, im2, regionsize, r, c);
% end
