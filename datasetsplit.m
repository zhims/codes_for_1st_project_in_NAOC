clc; clear;
dir_root = pwd;
name_mask = '2';
dir_dataset = fullfile(dir_root,'dataset',name_mask);
dir_train = fullfile(dir_dataset,'train');
if ~exist(dir_train,'dir')
    mkdir (dir_train)
end
dir_test = fullfile(dir_dataset,'test');
if ~exist(dir_test,'dir')
    mkdir (dir_test)
end
dir_val = fullfile(dir_dataset,'val');
if ~exist(dir_val,'dir')
    mkdir (dir_val)
end
fileExt = '*.png';
fnames = dir(fullfile(dir_dataset,fileExt));
len = size(fnames,1);
train_num = round(0.6*len);
val_num = round(0.2*len);
mark = randperm(len);
train_mark = mark(1:train_num);
val_mark = mark(train_num+1:train_num+val_num);
for i = 1:len
    file_name = fnames(i,1).name;
    if (ismember(i,train_mark))
        file_dir = fullfile(dir_dataset,file_name);
        copyfile(file_dir,dir_train);
    elseif(ismember(i,val_mark))
        file_dir = fullfile(dir_dataset,file_name);
        copyfile(file_dir,dir_val);
    else
        file_dir = fullfile(dir_dataset,file_name);
        copyfile(file_dir,dir_test);
    end
    
end

