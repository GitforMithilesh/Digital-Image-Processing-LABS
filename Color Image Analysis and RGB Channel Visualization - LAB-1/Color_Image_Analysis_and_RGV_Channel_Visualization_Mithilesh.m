% Reading and Displaying Image with Multiple Grayscale Methods
% This code reads a color image and displays it in different forms:
% - Original and RGB components
% - Multiple grayscale conversion methods
% Owner: Mithilesh Walde

function main()
    % Initialize environment
    initializeEnvironment();
    
    % Read the image
    Ic = imread('image.jpg');
    
    % Display RGB components
    displayRGBComponents(Ic);
    
    % Display grayscale conversions
    displayGrayscaleConversions(Ic);
    
    % Display image properties
    displayImageProperties(Ic);
end

function initializeEnvironment()
    clc;
    clear all;
    close all;
end

function displayRGBComponents(Ic)
    % Create figure for RGB components
    figure('Name', 'RGB Components', 'Position', [100 100 800 600]);
    
    % Display original image
    subplot(2,3,1);
    imshow(Ic);
    title('Original Image');
    
    % Extract and display RGB components
    channels = {'Red', 'Green', 'Blue'};
    for i = 1:3
        I_component = zeros(size(Ic), 'uint8');
        I_component(:,:,i) = Ic(:,:,i);
        
        subplot(2,3,i+1);
        imshow(I_component);
        title([channels{i} ' Component']);
    end
    
    % Display red channel in grayscale
    subplot(2,3,5);
    imshow(Ic(:,:,1));
    title('Red Channel Grayscale');
    
    % Display pixel information
    subplot(2,3,6);
    displayPixelInfo(Ic);
end

function displayPixelInfo(Ic)
    pixel_value = Ic(1, 3, :);
    text(0.1, 0.5, sprintf('Pixel value at (1,3):\nR: %d\nG: %d\nB: %d', ...
        pixel_value(1), pixel_value(2), pixel_value(3)), 'FontSize', 10);
    axis off;
    title('Pixel Information');
end

function displayGrayscaleConversions(Ic)
    % Create figure for grayscale conversions
    figure('Name', 'Grayscale Conversions', 'Position', [150 150 800 600]);
    
    % Calculate different grayscale versions
    grayVersions = calculateGrayVersions(Ic);
    
    % Display each grayscale version
    titles = {'Average Method', 'Luminance Method', 'Built-in rgb2gray', ...
              'Maximum Method', 'Minimum Method'};
    
    for i = 1:length(grayVersions)
        subplot(2,3,i);
        imshow(grayVersions{i});
        title(titles{i});
    end
end

function grayVersions = calculateGrayVersions(Ic)
    % Method 1: Average method
    I_gray_avg = uint8(mean(Ic, 3));
    
    % Method 2: Weighted average (Luminance) method
    I_gray_weighted = calculateLuminance(Ic);
    
    % Method 3: MATLAB's built-in rgb2gray
    I_gray_builtin = rgb2gray(Ic);
    
    % Method 4: Maximum method
    I_gray_max = uint8(max(Ic, [], 3));
    
    % Method 5: Minimum method
    I_gray_min = uint8(min(Ic, [], 3));
    
    grayVersions = {I_gray_avg, I_gray_weighted, I_gray_builtin, ...
                    I_gray_max, I_gray_min};
end

function I_gray_weighted = calculateLuminance(Ic)
    % Convert to double for precise calculation
    Ic_double = double(Ic);
    I_gray_weighted = uint8(0.299 * Ic_double(:,:,1) + ...
                           0.587 * Ic_double(:,:,2) + ...
                           0.114 * Ic_double(:,:,3));
end

function displayImageProperties(Ic)
    fprintf('\nImage Properties:\n');
    fprintf('Size: %d x %d x %d\n', size(Ic));
    fprintf('Class: %s\n', class(Ic));
    
    % Calculate weighted grayscale for min/max values
    I_gray_weighted = calculateLuminance(Ic);
    fprintf('Maximum value in weighted grayscale: %d\n', max(I_gray_weighted(:)));
    fprintf('Minimum value in weighted grayscale: %d\n', min(I_gray_weighted(:)));
end

