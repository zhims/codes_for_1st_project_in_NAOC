clear;clc;
root_path = pwd;
name_mask = '075';
dir_fits = fullfile(root_path,'fits',name_mask);
fext = '*.mat';
filearray = dir([dir_fits filesep fext]);  
NumImages = size(filearray,1); % get the number of images
root_path = pwd;
if NumImages < 0
    error('No files in the directory');
end
txt_name = [name_mask '.txt'];
for i=1:NumImages
    fid = fopen(txt_name,'a+');
    newname = filearray(i).name;
    no = newname(1:end-4);
    fprintf(fid,'%s \n',no);
    fclose(fid);
end
