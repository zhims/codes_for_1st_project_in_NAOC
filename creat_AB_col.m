clc; clear; 
dir_root = pwd;
name_mask = '2';
dir_fits = fullfile(dir_root, 'fits','fits_img',name_mask);
dir_sav = fullfile(dir_root, 'sav','sav_img_final',name_mask);

dir_dataset = fullfile(dir_root, 'dataset','col',name_mask);
if ~exist(dir_dataset,'dir')
    mkdir (dir_dataset)
end
fileExt = '*.png';
fnames = dir(fullfile(dir_fits,fileExt));
len = size(fnames,1);
for i=1:len
    a_name = fullfile(dir_fits, fnames(i).name);
    a = imread(a_name);
    b_name = fullfile(dir_sav, fnames(i).name);
    b = imread(b_name);
    dir_AB = fullfile(dir_dataset, fnames(i).name);
    imwrite(uint8([a;b]),dir_AB); 
end