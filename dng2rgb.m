function [Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, bayertype, method, M, N)
    
    % white balance correction
    mask = wbmask(M, N, wbcoeffs, bayertype);
    rawim = rawim .* mask;
    
    % demosaicing
    if method == "nearest"
        Ccam = demosaicNN(rawim);
    elseif method == "linear"
        Ccam = demosaicLinear(rawim);
    end
    
    % Camera to XYZ
    Cxyz = apply_cmatrix(Ccam, XYZ2Cam);
    
    % XYZ to linear
    XYZ2RGB = [];
    Clinear = apply_cmatrix(Cxyz, XYZ2RGB);
    
    % sRGB correction
    
    Csrgb = Clinear;
    
    
end