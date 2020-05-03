function img_out = Color_Seg(Image, threshold_values)

%Image = imread(img_in);
Image_hsv = rgb2hsv(Image);
[h, s, ~] = rgb2hsv(Image);
threshold = 0.001;

% Loop over the image in HSV color format
for i = 1:size(Image_hsv, 1)
    for j = 1:size(Image_hsv, 2)
        % Find the adjusted values for pixels in the input image
        adjusted_h = (round(h(i, j) * 100) + 1);
        adjusted_s = (round(s(i, j) * 100) + 1);
        if (threshold_values(adjusted_h, adjusted_s) < threshold) % If the adjusted value is < threshold value, black out pixel
            Image(i, j, 1) = 0;
            Image(i, j, 2) = 0;
            Image(i, j, 3) = 0;
        end
    end
end

img_out = Image;
end