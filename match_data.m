clear; clc;
root_path = pwd;
dir_sav_resize = fullfile(root_path,'sav','sav_data_resize');
dir_fits_resize = fullfile(root_path,'fits','fits_data_resize');
dir_final_fits_data =  fullfile(root_path,'fits','15');
if ~exist(dir_final_fits_data,'dir')
    mkdir (dir_final_fits_data)
end
cd (dir_sav_resize);
dir_sav_folders = dir(dir_sav_resize);
dir_sav_folders = dir_sav_folders(~ismember({dir_sav_folders .name},{'.','..'}));
[num_folder_sav,~] = size(dir_sav_folders);  
for i = 1 : num_folder_sav
    tem1 = dir_sav_folders(i).name;
    sav_data_struct = load(tem1);
    sav_data = sav_data_struct.sav_resize_data;
    sav_no = tem1(end-8:end-4);
    sav_no_double = str2double(sav_no);
    nums_days_sav = sav_no_double + 684594;
    flag_subdir_fits = nums_days_sav - 727930;
    cd (dir_fits_resize);
    flag_subdir_fits = num2str(flag_subdir_fits);
    dir_subdir_fits = [dir_fits_resize,filesep,'fd_M_96m_01d.00',flag_subdir_fits];
    if exist(dir_subdir_fits,'dir')
       cd(dir_subdir_fits)
       sub_sub_fits_dir = dir;
       name_sub_sub = sub_sub_fits_dir(~ismember({sub_sub_fits_dir.name},{'.','..'}));
       len_sub_sub = length(name_sub_sub);
       tem_coef = -2* ones(1,len_sub_sub);
       for h = 1 : len_sub_sub
           tem2 = name_sub_sub(h).name;
           fits_data_struct = load(tem2);
           fits_data = fits_data_struct.fits_resize_data;
           fits_data_mask = fits_data;
           fits_data_mask(isnan(fits_data_mask)) = 0;
           fits_data_mask(fits_data_mask >= 500) = 500;
           fits_data_mask(fits_data_mask <= -500) = -500;
           corrcoef_matrix = corrcoef(sav_data,fits_data_mask);
           corrcoef_scalar = corrcoef_matrix(1,2);
           tem_coef(h) = corrcoef_scalar;
       end
       if max(tem_coef) > 0.15 & max(tem_coef) < 2
           ith = find(tem_coef == max(tem_coef));
           simlar_fits_name = name_sub_sub(ith).name;
           copyfile(simlar_fits_name,dir_final_fits_data ); 
       end
       
    end 
    cd (dir_sav_resize);
end
cd ..

