clear; clc;
root_path = pwd;
if ~exist('sav_img_final_0910','dir')
    mkdir ('sav_img_final_0910')
end
sav_sel_dir = fullfile(root_path,'sav_img_0910' );
sav_img = fullfile(root_path,'sav_img_final_0910' );
fits_dir = fullfile(root_path,'select_fits_data' );
fileExt = '*.png';
fnames = dir(fullfile(sav_sel_dir,fileExt));
len = size(fnames,1);
% cd (sav_org_dir)
for i = 1:len
    sav_name = fnames(i,1).name;
    cd (fits_dir);
    fits_name = [sav_name(1:end-4), '.fits'];
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
    cd (sav_sel_dir)
    sav_org_data = imread(sav_name);
    sav_org_data(isnan(fits_data)) = 0;
    sav_img_sel_final = fullfile(sav_img, sav_name);
    imwrite(uint8(sav_org_data),sav_img_sel_final); 
    
end
cd (root_path)