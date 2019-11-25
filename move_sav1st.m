clc; clear;
name_mask = '15';
txt_name = [name_mask '.txt'];
fid = fopen(txt_name);
allText = textscan(fid,'%s','delimiter','n');
numberOfLines = length(allText{1});
fclose(fid);
line = numberOfLines;
dir_root = pwd;
filein =fullfile(dir_root,'sav_orig');
fileout =fullfile(dir_root,'final_sav_data',name_mask);
if ~exist(fileout,'dir')
    mkdir (fileout)
end
fidin=fopen(filein,'r');
fidout=fopen(fileout,'w');
for i=1:line  
    fits_no_str = allText{1,1}{i,1}(end-9:end-6);
    fits_no = str2double( fits_no_str);
    num_days_ac = fits_no + 727930;
    sav_no = num_days_ac - 684594;
    sav_no_str = num2str(sav_no);
    sav_name = ['Magnetogram.prjt.',sav_no_str,'.txt'];
    sav_name_dir = fullfile(filein,sav_name);  
    copyfile(sav_name_dir,fileout);
end