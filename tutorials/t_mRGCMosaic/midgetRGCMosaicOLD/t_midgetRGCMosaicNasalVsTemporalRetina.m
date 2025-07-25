function t_midgetRGCMosaicNasalVsTemporalRetina()

    % Generate mosaics in the left eye
    whichEye = 'left eye';

    % At a radial eccentricity of 20 degs
    radialEcc = 25;

    % And an angle of 0 degress (horizontal meridian)
    thetaDegs = 0;

    % Nasal mosaic
    % Compute the mosaic's (x,y) eccentricity based on its retinal meridian location
    [horizontalEcc,~] = cMosaic.eccentricitiesForRetinaMeridianInEye(radialEcc*cosd(thetaDegs), 'nasal meridian', whichEye);
    [~,verticalEcc]   = cMosaic.eccentricitiesForRetinaMeridianInEye(radialEcc*sind(thetaDegs), 'inferior meridian', whichEye);

    % Generate the mosaic
    theNasalMidgetRGCmosaic = midgetRGCMosaic(...
           'sourceLatticeSizeDegs', 60, ...
           'eccentricityDegs', [horizontalEcc verticalEcc], ...
           'sizeDegs', [1 1], ...
           'whichEye', whichEye ...
     );

    % Temporal mosaic
    % Compute the mosaic's (x,y) eccentricity based on its retinal meridian location
    [horizontalEcc,~] = cMosaic.eccentricitiesForRetinaMeridianInEye(radialEcc*cosd(thetaDegs), 'temporal meridian', whichEye);
    [~,verticalEcc] =   cMosaic.eccentricitiesForRetinaMeridianInEye(radialEcc*sind(thetaDegs), 'inferior meridian', whichEye);
    
    % Generate the mosaic
    theTemporalMidgetRGCmosaic = midgetRGCMosaic(...
           'sourceLatticeSizeDegs', 60, ...
           'eccentricityDegs', [horizontalEcc verticalEcc], ...
           'sizeDegs', [1 1], ...
           'whichEye', whichEye ...
     );

    % Temporal mosaic at the temporal equivalent eccentricity corresponding
    % to the eccentricity of the nasal mosaic
    % Compute the nasal mosaic's temporal equivalent eccentricity
    temporalEquivalentEccDegs = theNasalMidgetRGCmosaic.temporalEquivalentEccentricityDegs();

    % Generate the mosaic
    theEquivalentTemporalEccentricityTemporalMidgetRGCmosaic = midgetRGCMosaic(...
           'sourceLatticeSizeDegs', 60, ...
           'eccentricityDegs', temporalEquivalentEccDegs, ...
           'sizeDegs', [1 1], ...
           'whichEye', whichEye);

    
    % Visualize the three mosaics
    hFig = figure(1); clf;
    set(hFig, 'Position', [10 10 1900 550], 'Color', [1 1 1]);

    % The nasal-inferior mosaic at the target eccentricity
    ax = subplot(1,3,1);
    theNasalMidgetRGCmosaic.visualize(...
            'figureHandle', hFig, ...
            'axesHandle', ax, ...
            'maxVisualizedRFs', 18, ...
            'xRangeDegs', [-0.25 0.25], ...
            'yRangeDegs', [-0.25 0.25], ...
            'fontSize', 20, ...
            'retinalMeridianAxesLabeling', true, ...
            'plotTitle', sprintf('%s\nTEE: (%2.1f,%2.1f) degs', ...
                            theNasalMidgetRGCmosaic.whichEye, ...
                            theNasalMidgetRGCmosaic.temporalEquivalentEccentricityDegs(1), ...
                            theNasalMidgetRGCmosaic.temporalEquivalentEccentricityDegs(2)));

    % The nasal-inferior mosaic at the equivalent temporal eccentricity
    ax = subplot(1,3,2);
    theEquivalentTemporalEccentricityTemporalMidgetRGCmosaic.visualize(...
            'figureHandle', hFig, ...
            'axesHandle', ax, ...
            'maxVisualizedRFs', 18, ...
            'xRangeDegs', [-0.25 0.25], ...
            'yRangeDegs', [-0.25 0.25], ...
            'fontSize', 20, ...
            'retinalMeridianAxesLabeling', true, ...
            'plotTitle', sprintf('%s\n(temporal equiv. ecc)', ...
                            theNasalMidgetRGCmosaic.whichEye));

    % The temporal-inferior mosaic at the target eccentricity
    ax = subplot(1,3,3);
    theTemporalMidgetRGCmosaic.visualize(...
            'figureHandle', hFig, ...
            'axesHandle', ax, ...
            'maxVisualizedRFs', 18, ...
            'xRangeDegs', [-0.25 0.25], ...
            'yRangeDegs', [-0.25 0.25], ...
            'fontSize', 20, ...
            'retinalMeridianAxesLabeling', true, ...
            'plotTitle', sprintf('%s\nTEE: (%2.1f,%2.1f) degs', ...
                            theTemporalMidgetRGCmosaic.whichEye, ...
                            theTemporalMidgetRGCmosaic.temporalEquivalentEccentricityDegs(1), ...
                            theTemporalMidgetRGCmosaic.temporalEquivalentEccentricityDegs(2)));

end
