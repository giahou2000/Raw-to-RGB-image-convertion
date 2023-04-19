function [rawim ,XYZ2Cam, wbcoeffs, meta_info] = readdng(filename)
    obj = Tiff(filename ,'r');
    offsets = getTag(obj ,'SubIFD');
    setSubDirectory(obj ,offsets (1));
    rawim = read(obj);
    close(obj);
    
    meta_info = imfinfo(filename);
    % (x_origin ,y_origin) is the uper left corner of the useful part of the sensor and consequently of the array rawim
    y_origin = meta_info.SubIFDs{1}.ActiveArea(1) + 1; % +1 due to MATLAB indexing
    x_origin = meta_info.SubIFDs{1}.ActiveArea(2) + 1; % +1 due to MATLAB indexing
    formatSpec = 'y_origin is %i and x_origin %i\n';
    fprintf(formatSpec, y_origin, x_origin)
    % width and height of the image (the useful part of array rawim)
    width = meta_info.SubIFDs{1}.DefaultCropSize(1);
    height = meta_info.SubIFDs{1}.DefaultCropSize(2);
    formatSpec = 'width is %i and height %i\n';
    fprintf(formatSpec, width, height)
    
    % get the useful part of the image - crop to only valid pixels
    rawim = double(rawim(y_origin:y_origin + height - 1, x_origin:x_origin + width - 1));
    
    % linearization in case of non-linear transformation (it is not needed for now but it is put here for completeness purposes)
    if isfield(meta_info.SubIFDs{1}, 'LinearizationTable')
        ltab = meta_info.SubIFDs{1}.LinearizationTable;
        rawim = ltab(rawim + 1);
    end
    
    % dynamic range
    blacklevel = meta_info.SubIFDs{1}.BlackLevel(1); % sensor value corresponding to black
    whitelevel = meta_info.SubIFDs{1}.WhiteLevel; % sensor value corresponding to white
    formatSpec = 'blacklevel is %i and whitelevel %i\n';
    fprintf(formatSpec, blacklevel, whitelevel);
    rawim = (rawim - blacklevel)/(whitelevel - blacklevel);
    
    % "noise reduction"
    rawim = max(0, min(rawim, 1));
    
    % white balance correction
    wbcoeffs = (meta_info.AsShotNeutral).^-1;
    wbcoeffs = wbcoeffs/wbcoeffs(2); % green channel will be left unchanged
    
    % color space info
    XYZ2Cam = meta_info.ColorMatrix2;
    XYZ2Cam = reshape(XYZ2Cam, 3, 3)';
end