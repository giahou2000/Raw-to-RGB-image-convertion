function [Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, bayertype, method, M, N)
    %% White balance correction
    mask = wbmask(M, N, wbcoeffs, bayertype); % mask creation
    rawim = rawim .* mask; % wb correction
    % imshow(rawim); % just for testing
    
    %% Demosaicing
    if method == "nearest"
        Ccam = demosaicNN(rawim);
    elseif method == "linear"
        Ccam = demosaicLinear(rawim);
    end
    % imshow(Ccam);
    % fprintf("%i\n", size(Ccam));
    
    %% Transformations
    % Camera to XYZ
    Cam2XYZ = XYZ2Cam^-1; % transformation matrix
    Cxyz = apply_cmatrix(Ccam, Cam2XYZ); % transformation
    % imshow(Cxyz);
    % fprintf("%i\n", size(Cxyz));
    
    % XYZ to linear
    RGB2XYZ = [0.4124564 0.3575761 0.1804375 ; 0.2126729 0.7151522 0.0721750 ; 0.0193339 0.1191920 0.9503041];
    RGB2Cam = XYZ2Cam * RGB2XYZ;
    RGB2Cam = RGB2Cam ./ repmat(sum(RGB2Cam, 2), 1, 3); % Normalize rows to 1
    Cam2RGB = RGB2Cam^-1; % transformation matrix
    Clinear = apply_cmatrix(Ccam, Cam2RGB); % transformation
    Clinear = max(0, min(Clinear, 1)); % Always keep image clipped b/w 0-1
    % imshow(Clinear);
    % fprintf("%i\n", size(Clinear));
    
    %% sRGB correction
    % brightness correction
    grayim = rgb2gray(Clinear);
    grayscale = 0.25/mean(grayim(:));
    bright_srgb = min(1, Clinear*grayscale);
    
    % gamma correction
    Csrgb = bright_srgb.^(1/2.2);
    
    % imshow(Csrgb);
    % fprintf("%i\n", size(Csrgb));
end