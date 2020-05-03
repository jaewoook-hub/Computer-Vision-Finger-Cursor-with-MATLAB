
rgbimage = imread('rgb_hand1.jpg');
grayImage = rgb2gray(rgbimage);
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
    % It's not really gray scale like we expected - it's color.
    % Convert it to gray scale by taking only the green channel.
    grayImage = grayImage(:, :, 2); 
end    
bwImage = imbinarize(grayImage, 'adaptive');


figure;
imshow('bw_hand1.png');

labeledImage = logical(Img1BW); %not needed, image should be already in logical
measurements = regionprops(labeledImage, 'BoundingBox');
areas = regionprops(labeledImage, 'Area');
hold on
for k = 1 : length(measurements)
    thisBB = measurements(k).BoundingBox;
    if(areas(k).Area > 50)
        rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2 );
    end 
end
hold off