function t = findHomogrpahy(fixed, moving, iterations, dicom)
    
    % Read in the data and open it as a dicom - image
    if ~dicom
        moving = imread(moving);
        fixed = imread(fixed);
        
        dicomwrite(moving, "moving.dcm");
        dicomwrite(fixed, "fixed.dcm");
        
        moving = dicomread("moving.dcm");
        fixed = dicomread("fixed.dmc");
    else
        moving = dicomread(moving);
        fixed = dicomread(fixed);
        
    end
    
    % convert the images from rgb to gray
    moving = rgb2gray(moving);
    fixed = rgb2gray(fixed);
    
    % show the inital pair prior to registering
    imshowpair(fixed, moving)
    
    % initalize the metric and optimizer for image registration
    [optimizer, metric] = imregconfig("multimodal");
    
    % set the desired number of iterations
    optimizer.MaximumIterations = iterations;
    
    % get the optimized matrix
    tform = imregtform(moving, fixed, "affine", optimizer, metric);
    
    % register the image
    registered = imwarp(moving,tform,"OutputView",imref2d(size(fixed)));
    
    %visualize the registration
    imshowpair(registered, fixed)
    
    t = tform.T;
    
    
    
        
        
    
