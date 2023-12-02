% Read an RGB image (replace 'input_image.jpg' with your image file)
I = imread('output_image.png');

% Convert the RGB image to grayscale
gray_image = rgb2gray(I);

% Set the threshold value (adjust as needed)
threshold = 140;

% Apply binary thresholding
binary_image = gray_image > threshold;

% Display the original RGB image and the binary thresholded image
subplot(1, 2, 1);
imshow(I);
title('Original RGB Image');

subplot(1, 2, 2);
imshow(binary_image);
title('Binary Thresholded Image');

% Save the binary thresholded image (replace 'binary_image.png' with the desired filename)
imwrite(binary_image, 'binary_image2.png');

% Perform median filtering on the image
medianImg = medfilt2(binary_image);

rotated_img = imrotate(medianImg, 90, 'bilinear', 'crop');

% Display the median filtered image
subplot(1, 3, 2);
imshow(medianImg);

