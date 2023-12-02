file_path = 'C:\Users\KANAK\OneDrive\Desktop\week10';

if exist(file_path, "file") == 2
    data = csvread(file_path);
    disp('file loaded successfully.');
else
    disp('Error: File not found or path is incorrect.');
end

%disp(data);
