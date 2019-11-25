dbstop if error
clc; clear;
name_mask = '075';
txt_name = [name_mask '_2nd' '.txt'];
fid = fopen(txt_name);
allText = textscan(fid,'%s','delimiter','\n');
numberOfLines = length(allText{1});
fclose(fid);
line = numberOfLines;
dir_root = pwd;
filein =fullfile(dir_root,'sav','sav_img',name_mask);
fileout =fullfile(dir_root,'sav','sav_img_final',name_mask);
if ~exist(fileout,'dir')
    mkdir (fileout)
end
fidin=fopen(filein,'r');
fidout=fopen(fileout,'w');
for i=1:line  
    sav_name = allText{1,1}{i,1}(1:end-1);
    sav_sub_dir = fullfile(filein, sav_name);
    copyfile( sav_sub_dir,fileout);
end