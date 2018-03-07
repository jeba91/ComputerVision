%%
% feature tracking algorithm
%% params
regionsize = 15;

%% Harris Corner Detection

%%% person_toy image loading
% files = dir('**/person_toy/*.jpg');
% tracking_video1 = VideoWriter('person_toy.avi');
% tracking_video1.FrameRate = 10;
% open(tracking_video1);
% for i = 1:(length(files) - 1)
%    filename1 = char(strcat(files(i).folder,'/',files(i).name));
%    filename2 = char(strcat(files(i+1).folder,'/',files(i+1).name));
%    im1 = imread(filename1);
%    im1 = rgb2gray(im1);
%    im2 = imread(filename2);
%    im2 = rgb2gray(im2);
%    [H, r, c] = harris_corner_detection(filename1);
%    V = LK(im1, im2, regionsize, r, c);
%    frame = getframe(gcf);
%    writeVideo(tracking_video1,frame)
% end

% close(tracking_video1);

%%% pingpong image loading
tracking_video2 = VideoWriter('pingpong.avi');
tracking_video2.FrameRate = 10;
open(tracking_video2);
files = dir('pingpong/*.jpeg');    
for i = 1:(length(files) - 1)
   filename1 = char(strcat(files(i).folder,'/',files(i).name));
   filename2 = char(strcat(files(i+1).folder,'/',files(i+1).name));
   im1 = imread(filename1);
   im1 = rgb2gray(im1);
   im2 = imread(filename2);
   im2 = rgb2gray(im2);
   [H, r, c] = harris_corner_detection(filename1);
   V = LK(im1, im2, regionsize, r, c);
   frame = getframe(gcf);
   writeVideo(tracking_video2,frame)
end

close(tracking_video2);
