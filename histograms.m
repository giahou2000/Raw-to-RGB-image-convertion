function [] = histograms(Csrgb, Clinear, Cxyz, Ccam)
    %% Csrgb
    R = imhist(Csrgb(:,:,1)); 
    G = imhist(Csrgb(:,:,2)); 
    B = imhist(Csrgb(:,:,3)); 
    figure('Name', 'Csrgb Histogram')
    plot(R,'r') 
    hold on, 
    plot(G,'g') 
    plot(B,'b')
    legend(' Red channel','Green channel','Blue channel');
    hold off
    
    %% Clinear
    R = imhist(Clinear(:,:,1)); 
    G = imhist(Clinear(:,:,2)); 
    B = imhist(Clinear(:,:,3)); 
    figure('Name', 'Clinear Histogram')
    plot(R,'r') 
    hold on, 
    plot(G,'g') 
    plot(B,'b')
    legend(' Red channel','Green channel','Blue channel');
    hold off
    
    %% Cxyz
    R = imhist(Cxyz(:,:,1)); 
    G = imhist(Cxyz(:,:,2)); 
    B = imhist(Cxyz(:,:,3)); 
    figure('Name', 'Cxyz Histogram')
    plot(R,'r') 
    hold on, 
    plot(G,'g') 
    plot(B,'b')
    legend(' Red channel','Green channel','Blue channel');
    hold off
    
    %% Ccam
    R = imhist(Ccam(:,:,1)); 
    G = imhist(Ccam(:,:,2)); 
    B = imhist(Ccam(:,:,3)); 
    figure('Name', 'Ccam Histogram')
    plot(R,'r') 
    hold on, 
    plot(G,'g') 
    plot(B,'b')
    legend(' Red channel','Green channel','Blue channel');
    hold off
end