dbstop if error
warning off all
clear; clc;
root_path = pwd;
name_mask = '075';
fits_dir = fullfile(root_path,'final_fits_orig',name_mask);
fits_img_dir = fullfile(root_path,'fits','fits_img', name_mask);
if ~exist(fits_img_dir,'dir')
    mkdir (fits_img_dir)
end
fileExt = '*.fits';
fnames = dir(fullfile(fits_dir,fileExt));
len = size(fnames,1);
cd (fits_dir)
for i = 1:len
    fits_name = fnames(i,1).name;
    fits_data = fitsread(fits_name);
    info = fitsinfo(fits_name);
    tem_info = info.PrimaryData.Keywords(:,1,:);
    [bool, index] = ismember('SOLAR_P',tem_info);
    sloar_p_num = cell2mat(info.PrimaryData.Keywords(index,2));
    sloar_p_num = round(sloar_p_num);
    if sloar_p_num == -180
        fits_data = rot90(fits_data,2);
    elseif sloar_p_num == 180
        fits_data = rot90(fits_data,2);
    end
    flag_fits_name = fits_name(end-13:end-10);
    flag_num = str2double(flag_fits_name);
    num_ac = flag_num + 727930;
    fits_date = datestr(num_ac);
    fits_date(fits_date=='-') = '_';
    fits_data(fits_data>=100) = 500;
    fits_data(fits_data<=-100) = -500;
    min_value = min(min(fits_data));
    max_value = max(max(fits_data));
    fits_data(isnan(fits_data)) = min_value;
    range = max_value - min_value;
    fits_data = 255/range*fits_data + 255 - 255*max_value/range;
    name_tmp = [fits_date,'.png'];
    fits_img_subdir = fullfile(fits_img_dir, name_tmp);
    imwrite(uint8(fits_data),fits_img_subdir); 
end
cd (root_path)