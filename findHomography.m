function t = findHomography(fixed, moving, vargain)
    % fixed: the image to be match
    % moving: the image to be warped to the fixed image
    % vargain{1}: variable if the image is a dicom or not
    % vargain{2}: NumIterations Hyper parameter for the optmizer
    % vargain{3}: Whether or not to visualize the images
    %
    
    % Read in the data and open it as a dicom - image
    if ~vargain{1}
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
    
    
    
        
        
    
