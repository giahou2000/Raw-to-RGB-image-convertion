%--------------------------------------------------------------------------
%                           Nearest neighbour algorithm
%--------------------------------------------------------------------------
function mosim = demosaicNN(im)
% mosim = demosaicBaseline(im);

[imageHeight, imageWidth] = size(im);
% fprintf("imageWidth: %i and imageHeight: %i", imageWidth, imageHeight);

% creating masks for the bayer pattern (only for RGGB bayer pattern)
bayer_red = repmat([1 0 ; 0 0], ceil(imageHeight/2), ceil(imageWidth/2));
bayer_blue = repmat([0 0 ; 0 1], ceil(imageHeight/2), ceil(imageWidth/2));
bayer_green = repmat([0 1 ; 1 0], ceil(imageHeight/2), ceil(imageWidth/2));

% truncating the extra pixels at the edges (not necessary for the resolution of the image of the project)
if(mod(imageWidth,2))==1
   bayer_red(size(bayer_red,1),:)=[];
   bayer_blue(size(bayer_blue,1),:)=[];
   bayer_green(size(bayer_green,1),:)=[];
end
if(mod(imageHeight,2)==1)
   bayer_red(:,size(bayer_red,2))=[];
   bayer_blue(:,size(bayer_blue,2))=[];
   bayer_green(:,size(bayer_green,2))=[];
end
    
% extracting the red, green and blue grids of the image using the masks
red_image = im.*bayer_red;
blue_image = im.*bayer_blue;
green_image = im.*bayer_green;

% computing the green pixels at missing points
% the pixel's left neighbor gives the color
green = green_image + imfilter(green_image, [0 1]);

% computing the red pixels at missing points
redValue = im(1:2:imageHeight, 1:2:imageWidth);
meanRed = mean(mean(redValue));
% red@blue
% Input array values outside the bounds of the array are assigned the value meanRed.
% When no padding option is specified, the default is 0.
red_1 = imfilter(red_image, [0 0;0 1], meanRed);
% red@green
% Input array values outside the bounds of the array are assigned the value meanRed.
% When no padding option is specified, the default is 0.
red_2 = imfilter(red_image, [0 1;1 0], meanRed);
% combine
red = red_image + red_1 + red_2;

% computing the blue pixels at missing points
blueValue = im(1:2:imageHeight, 1:2:imageWidth);
meanBlue = mean(mean(blueValue));
% blue@red
% Input array values outside the bounds of the array are assigned the value meanBlue.
% When no padding option is specified, the default is 0.
blue_1 = imfilter(blue_image, [0 0;0 1], meanBlue);
% blue@green
% Input array values outside the bounds of the array are assigned the value meanBlue.
% When no padding option is specified, the default is 0.
blue_2 = imfilter(blue_image, [0 1;1 0], meanBlue);
% combine
blue = blue_image + blue_1 + blue_2;

mosim(:,:,1) = red;
mosim(:,:,2) = green;
mosim(:,:,3) = blue;