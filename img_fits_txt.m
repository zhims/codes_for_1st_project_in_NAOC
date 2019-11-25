clear;
dir_root = pwd;
name_mask = '075';
dir_fits_img =fullfile(dir_root,'fits','fits_img',name_mask) ;
cd(dir_fits_img)
img_dir = dir('*.png');
num_img = size(img_dir,1);
txt_name = [name_mask '_2nd' '.txt'];
for i = 1:num_img
    fid = fopen(txt_name,'a+');
    newname = img_dir(i).name;
    no = newname;
    fprintf(fid,'%s \n',no);
    fclose(fid);
end
movefile(txt_name,dir_root);
cd (dir_root)
