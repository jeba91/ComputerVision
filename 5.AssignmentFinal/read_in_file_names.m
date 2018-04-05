function [images] = read_in_file_names(text_file)

length_file = count_lines(text_file);

fid = fopen(text_file);
tline = fgetl(fid);
images = cell(length_file,1);

for i = 1:size(images,1)
    tline = strcat(char(tline), '.jpg');
    images(i,1) = {tline};
    tline = fgetl(fid);
end


end

function [n] = count_lines(text_file)

fid = fopen(text_file);
tline = fgetl(fid);
n = 0;

while ischar(tline)
  tline = fgetl(fid);
  n = n+1;
end

end