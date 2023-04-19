% import the necessary libraries
import readdng.*
import dng2rgb.*

filename = 'RawImage.DNG'; % the file you will import
[rawim ,XYZ2Cam, wbcoeffs, meta_info] = readdng(filename); % import raw image and its metadata


bayertype = 'GRBG'; % the pattern of the sensor's pixels
[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, bayertype, method, M, N);