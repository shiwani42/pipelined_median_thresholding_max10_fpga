imageData = csvread('text_image_1.csv');
% Load data from the CSV file


% Plot the data
plot(imageData); % You may need to adjust the plotting code based on your data format

% Save the plot as a PNG image
saveas(gcf, 'plot_image.png');

