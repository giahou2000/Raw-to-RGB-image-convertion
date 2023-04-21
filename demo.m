%% Import the necessary libraries
import readdng.*
import dng2rgb.*
import histograms.*

%% Import image
filename = 'RawImage.DNG'; % the file you will import
[rawim ,XYZ2Cam, wbcoeffs, meta_info] = readdng(filename); % import raw image and its metadata
% imshow(rawim); % just for testing

%% Raw to RGB convertion
bayertype = 'RGGB'; % the pattern of the sensor's pixels (BGGR, GBRG, GRBG, RGGB)
% method = 'nearest';
method = 'linear';
[M, N] = size(rawim); % N is width and M is height
[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, bayertype, method, M, N);

% imshow(Csrgb); % for testing purposes

%% Print images
print(Csrgb, Clinear, Cxyz, Ccam, method)

%% Histograms
histograms(Csrgb, Clinear, Cxyz, Ccam);