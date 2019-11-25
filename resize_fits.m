clear;clc;
%filesep;
root_path = pwd;
dir_fits_resize = fullfile(root_path,'fits','fits_data_resize');
if ~exist(dir_fits_resize,'dir')
    mkdir (dir_fits_resize)
end
dir_fits_folders = fullfile(root_path,'fits_orig');
cd (dir_fits_folders);
dir_folders = dir(dir_fits_folders);
dir_folders = dir_folders(~ismember({dir_folders.name},{'.','..'}));
[num_folder_fits,~] = size(dir_folders);
cd (dir_fits_resize);
for k = 1:num_folder_fits
    sub_folders_name = dir_folders(k).name;
    if ~exist(sub_folders_name,'dir')
    mkdir (sub_folders_name)
    end
end
cd (dir_fits_folders);
for  i = 1:num_folder_fits
    cd (dir_folders(i).name)
    fileExt = '*.fits';
    fnames = dir(fullfile(pwd,fileExt));
    len = size(fnames,1);
    for j = 1:len
        fits_name = fnames(j,1).name;
        len_name = length(fits_name);
        mark_end_name = fits_name(end-12:end);
        if strcmp(mark_end_name ,'overview.fits')==0
            fits_data = fitsread(fnames(j,1).name);
            info = fitsinfo(fnames(j,1).name);
            tem_info = info.PrimaryData.Keywords(:,1,:);
            [bool, index] = ismember('SOLAR_P',tem_info);
            sloar_p_num = cell2mat(info.PrimaryData.Keywords(index,2));
            sloar_p_num = round(sloar_p_num);
            if sloar_p_num == -180
                fits_data = rot90(fits_data,2);
            elseif sloar_p_num == 180
                fits_data = rot90(fits_data,2);
            end
            fits_resize_data = imresize(fits_data,[1024 1024]);
            sub_folders_name = dir_folders(i).name;
            file_name = [fnames(j,1).name(1:end-5),'.mat'];
            save_path = fullfile(dir_fits_resize,sub_folders_name,file_name);
            save(save_path,'fits_resize_data')
        end
    end
    cd ..
end
cd ..