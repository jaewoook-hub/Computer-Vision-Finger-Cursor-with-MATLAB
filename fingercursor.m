clear;
cam = webcam;
cam.Resolution = '640x480';
img_out1 = Histo_2D();

for idx = 1:300
    % Acquire a single image.
    rgbImage = snapshot(cam);
    % Convert RGB to grayscale and then to BW
    grayImage = rgb2gray(rgbImage);
    [rows, columns, numberOfColorBands] = size(grayImage);
    if numberOfColorBands > 1
        % It's not really gray scale like we expected - it's color.
        % Convert it to gray scale by taking only the green channel.
        grayImage = grayImage(:, :, 2); 
    end    
    bbox_in = Color_Seg(rgbImage, img_out1);
    Img1BW = imbinarize(rgb2gray(bbox_in), 'adaptive'); 

    imshow(rgbImage);
    %imshow(Img1BW);
    
    labeledImage = logical(Img1BW); 
    measurements = regionprops(labeledImage, 'BoundingBox', 'Area');
    areas = regionprops(labeledImage, 'Area');
    %s = regionprops(labeledImage, 'centroid');
    
    allAreas = [measurements.Area];
    [sortedAreas, sortingIndexes] = sort(allAreas, 'descend');
    
    hold on;
    for k = 1 : length(measurements)
        thisBB = measurements(k).BoundingBox;
        if(measurements(k).Area == sortedAreas(1))
            rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2 );
            %set(0,'PointerLocation',[2*s(1).Centroid(1)+400,2*s(2).Centroid(2)+333]);    
            set(0,'PointerLocation',[-3*thisBB(1)+1000, -3*thisBB(2)+1000]);            
        end 
    end    
    
    drawnow
    
end

clear('cam');
