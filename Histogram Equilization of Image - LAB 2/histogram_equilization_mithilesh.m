% Image Contrast Enhancement Using Histogram Equalization
% A grayscale image processing technique that improves contrast by normalizing the distribution of pixel intensities
% Written by Mithilesh Walde


clear all
close all
clc

% Read and convert image to grayscale
img = imread('image.jpg');
if size(img, 3) == 3
    gray_img = rgb2gray(img);
else
    gray_img = img;
end

% Calculate histogram
[counts, bins] = histcounts(gray_img(:), 256);

% Calculate CDF
cdf = cumsum(counts) / numel(gray_img);

% Manual histogram equalization
% Create lookup table
cdf_min = min(cdf(cdf > 0));  % Find first non-zero value
lookup_table = uint8(round((cdf - cdf_min) / (1 - cdf_min) * 255));

% Apply lookup table to create equalized image
equalized_img = lookup_table(gray_img + 1);  % +1 because MATLAB is 1-based indexed

% Create subplots for visualization
figure('Position', [100 100 1200 600]);

% Original image
subplot(2, 2, 1);
imshow(gray_img);
title('Original Grayscale Image');

% Original histogram
subplot(2, 2, 2);
bar(bins(1:end-1), counts);
title('Original Histogram');
xlabel('Intensity Value');
ylabel('Frequency');
grid on;

% Equalized image
subplot(2, 2, 3);
imshow(equalized_img);
title('Equalized Image');

% Equalized histogram
[eq_counts, eq_bins] = histcounts(equalized_img(:), 256);
subplot(2, 2, 4);
bar(eq_bins(1:end-1), eq_counts);
title('Equalized Histogram');
xlabel('Intensity Value');
ylabel('Frequency');
grid on;

% Adjust subplot spacing
sgtitle('Image Histogram Equalization Analysis');
