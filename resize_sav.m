clear; clc;
root_path = pwd;
sav_dir = fullfile(root_path,'sav_orig' );
sav_resize_dir = fullfile(root_path,'sav','sav_data_resize' );
if ~exist(sav_resize_dir,'dir')
    mkdir (sav_resize_dir)
end
fileExt = '*.txt';
fnames = dir(fullfile(sav_dir,fileExt));
len = size(fnames,1);
cd (sav_dir)
for i = 1:len
    sav_data=importdata(fnames(i,1).name);
    tem_name = fnames(i,1).name;
    tem_name = tem_name(1:end-4);
    new_name = strcat(tem_name,'.mat');
    sav_resize_data = imresize(sav_data,[1024 1024]);
    sav_save_path_name = fullfile(sav_resize_dir,new_name);
    save(sav_save_path_name,'sav_resize_data')
end
cd ..