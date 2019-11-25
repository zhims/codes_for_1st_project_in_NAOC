warning off all
clear; clc;
root_path = pwd;
name_mask = '15';
sav_org_dir = fullfile(root_path,'final_sav_data',name_mask );
sav_img_dir = fullfile(root_path,'sav','sav_img',name_mask );
if ~exist(sav_img_dir,'dir')
    mkdir (sav_img_dir)
end
fileExt = '*.txt';
fnames = dir(fullfile(sav_org_dir,fileExt));
len = size(fnames,1);
cd (sav_org_dir)
for i = 1:len
    sav_name = fnames(i,1).name;
    sav_data =importdata(fnames(i,1).name);
    flag_sav_name = sav_name(end-8:end-4);
    flag_num = str2double(flag_sav_name);
    num_ac = flag_num + 684594;
    sav_date = datestr(num_ac);
    sav_date(sav_date=='-') = '_';
    sav_data(sav_data >= 150) = 150;
    sav_data(sav_data <= -150) = -150;
    min_value = min(min(sav_data));
    max_value = max(max(sav_data));
    range = max_value - min_value;
    sav_data = 255/range*sav_data + 255 - 255*max_value/range;
    sav_data = imresize(sav_data,[1024 1024]);
    name_tmp = [sav_date,'.png'];
    sav_img_subdir = fullfile(sav_img_dir, name_tmp);
    imwrite(uint8(sav_data),sav_img_subdir);   
end
cd (root_path)