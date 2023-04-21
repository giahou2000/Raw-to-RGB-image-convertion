function [] = print(Csrgb, Clinear, Cxyz, Ccam, method)
    if method == "nearest"
        figure('Name', 'Ccam_Nearest_Neighbor');
        imshow(Ccam);
        figure('Name', 'Cxyz_Nearest_Neighbor');
        imshow(Cxyz);
        figure('Name', 'Clinear_Nearest_Neighbor');
        imshow(Clinear);
        figure('Name', 'Csrgb_Nearest_Neighbor');
        imshow(Csrgb);
    elseif method == "linear"
        figure('Name', 'Ccam_bilinear_interpolation');
        imshow(Ccam);
        figure('Name', 'Cxyz_bilinear_interpolation');
        imshow(Cxyz);
        figure('Name', 'Clinear_bilinear_interpolation');
        imshow(Clinear);
        figure('Name', 'Csrgb_bilinear_interpolation');
        imshow(Csrgb);
    end
end