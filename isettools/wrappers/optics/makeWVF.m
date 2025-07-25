function theWVF = makeWVF(wavefrontSpatialSamples, zcoeffsMicrons, measWavelength, wavelengthsToCompute, ...
    measPupilDiameterMM, calcPupilDiameterMM, umPerDegree, name, varargin)

    % Parse input
    p = inputParser;
    p.addParameter('flipPSFUpsideDown', false, @islogical);
    p.addParameter('rotatePSF90degs', false, @islogical);
    p.addParameter('upsampleFactor', [], @(x)(isempty(x) || ((isnumeric(x))&&(numel(x)==1)&&(x>0))));
    p.addParameter('noLCA',false,@islogical);
    p.parse(varargin{:});
    flipPSFUpsideDown = p.Results.flipPSFUpsideDown;
    rotatePSF90degs = p.Results.rotatePSF90degs;
    upsampleFactor = p.Results.upsampleFactor;
    noLCA = p.Results.noLCA;

    theWVF = wvfCreate(...
    			'umPerDegree', umPerDegree, ...
                'calc wavelengths',wavelengthsToCompute,...
                'measuredpupil', measPupilDiameterMM, ...
                'calc pupil size',calcPupilDiameterMM, ...
                'spatialsamples', wavefrontSpatialSamples, ...
                'zcoeffs', zcoeffsMicrons,...
                'measured wl', measWavelength, ...
                'name', name, ...
                'flipPSFUpsideDown', flipPSFUpsideDown, ...
                'rotatePSF90degs', rotatePSF90degs);
    
    if (~isempty(upsampleFactor))
        arcminPerSample = wvfGet(theWVF,'psf angle per sample','min',measWavelength);
        theWVF = wvfSet(theWVF,'ref psf sample interval',arcminPerSample/double(upsampleFactor));
    end
    
    % Now compute the PSF
    theWVF = wvfComputePSF(theWVF, false, 'nolca', noLCA);
end