%--------------------------------------------------------------------------
%                           Bilinear interpolation algorithm
%--------------------------------------------------------------------------
function mosim = demosaicLinear(im)
% mosim = demosaicBaseline(im);
% mosim = repmat(im, [1 1 3]);
%
[imageHeight, imageWidth]=size(im);

% creating masks for the bayer pattern (only for GRBG bayer pattern)
bayer_red = repmat([0 1; 0 0], ceil(imageHeight/2), ceil(imageWidth/2));
bayer_blue = repmat([0 0; 1 0], ceil(imageHeight/2), ceil(imageWidth/2));
bayer_green = repmat([1 0; 0 1], ceil(imageHeight/2), ceil(imageWidth/2));

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
    
% extracting the red, green and blue grids of the image using the mask
red_image = im.*bayer_red;
blue_image = im.*bayer_blue;
green_image = im.*bayer_green;

% computing the green pixels at missing points
green = green_image + imfilter(green_image, [0 1 0 ; 1 0 1 ; 0 1 0]/4);

% computing the red pixels at missing points
red_1 = imfilter(red_image, [1 0 1 ; 0 0 0 ; 1 0 1]/4);
red_2 = imfilter(red_image, [0 1 0 ; 1 0 1 ; 0 1 0]/2);
red = red_image + red_1 + red_2;

% computing the blue pixels at missing points
blue_1 = imfilter(blue_image, [1 0 1 ; 0 0 0 ; 1 0 1]/4);
blue_2 = imfilter(blue_image, [0 1 0 ; 1 0 1 ; 0 1 0]/2);
blue = blue_image + blue_1 + blue_2;

mosim(:,:,1) = red;
mosim(:,:,2) = green;
mosim(:,:,3) = blue;