clc; clear;
name_mask = '15';
txt_name = [name_mask '.txt'];
fid = fopen(txt_name);
allText = textscan(fid,'%s','delimiter','\n');
numberOfLines = length(allText{1});
fclose(fid);
line = numberOfLines;
dir_root = pwd;

filein =fullfile(dir_root,'fits_orig');
fileout =fullfile(dir_root,'final_fits_orig',name_mask);
if ~exist(fileout,'dir')
    mkdir (fileout)
end
fidin=fopen(filein,'r');
fidout=fopen(fileout,'w');
for i=1:line  
    fits_name_patt1 = allText{1,1}{i,1}(1:end-10);
    fits_name_patt2 = '00';
    fits_name_patt3 = allText{1,1}{i,1}(end-9:end-6);
    fits_name = [fits_name_patt1,fits_name_patt2,fits_name_patt3];
    fits_sub_name = [allText{1,1}{i,1}(1:end-1), '.fits'];
    fits_sub_dir = fullfile(filein, fits_name,fits_sub_name);  
    copyfile( fits_sub_dir,fileout);
end