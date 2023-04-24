%% This code converts a DNG (RAW) image to an RGB one.
% Digital image processing course | Department of Electrical Engineering and Computer Science | AUTH
% April 2023
% Giachoudis Christos

%% Import image
filename = 'RawImage.DNG'; % the name of the file you will import (place the file at the same folder with the files of this code)
[rawim ,XYZ2Cam, wbcoeffs] = readdng(filename); % import raw image and its metadata
% imshow(rawim); % just for testing

%% Raw to RGB convertion
bayertype = 'RGGB'; % the pattern of the sensor's grid of pixel filters (BGGR, GBRG, GRBG, RGGB)
method = 'nearest'; % demosaicing method
% method = 'linear'; % demosaicing method
[M, N] = size(rawim); % N is width and M is height
[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, bayertype, method, M, N); % convert the image from RAW to RGB

% imshow(Csrgb); % for testing purposes

%% Print images
print(Csrgb, Clinear, Cxyz, Ccam, method)

%% Histograms
histograms(Csrgb, Clinear, Cxyz, Ccam);