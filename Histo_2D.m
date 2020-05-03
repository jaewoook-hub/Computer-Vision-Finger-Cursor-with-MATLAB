function img_out1 = Histo_2D()
% filepath to all training images
images = dir(fullfile('C:\Users\richa\OneDrive\Documents\MATLAB\jwo739_Final\samples','*.png'));

hist_sum = 0;
hsv_pairs = zeros(101, 101);

% This loop goes through each of the test files 
for file = 1:length(images)
    path = images(file).name;
    img_in = imread(path);
    img_in_hsv = rgb2hsv(img_in); % these two lines change the image to HSV color format
    [h, s, ~] = rgb2hsv(img_in);

    % Go through the HSV color formatted image
    for i = 1:size(img_in_hsv, 1)
        for j = 1:size(img_in_hsv, 2)
            hist_bin_h = (round(h(i, j) * 100) + 1); % Histogram bin value 'h'
            hist_bin_s = (round(s(i, j) * 100) + 1); % Histogram bin value 's'
            hsv_pairs(hist_bin_h, hist_bin_s) = hsv_pairs(hist_bin_h, hist_bin_s) + 1; % Create histogram matrix
            
            if (~(hist_bin_h == 1 && hist_bin_s == 1)) % Need to omit white pixels 
                hist_sum = hist_sum + 1;
            end
        end
    end
end

% normalize histogram by dividing it by the sum 
for i = 1:size(hsv_pairs, 1)
    for j = 1:size(hsv_pairs, 2)
        hsv_pairs(i, j) = hsv_pairs(i, j) / hist_sum;
    end
end

img_out1 = hsv_pairs;

end