% s_ illuminantEstimate
%
% Read the image with the MCC in it. Divide the spectral radiance from the
% white chip of the MCC by its reflectance (measured by HB). This produces
% the relative spectral power distribution of the illuminant.
%
% This is the same illuminant used for all of the face hyperspectral data.
%
% See macbethReadReflectance 

%% Initialize
ieInit

% wDir = fullfile(isetRootPath,'local','facesHyper');
wDir = fullfile(hyspexRootPath,'hcdata');
chdir(wDir);

%% Here is the spectral radiance of the scene

% hyspexFileName  = 'LowResMale2';
hyspexFileName  = 'MCC';

% The scaling parameter is in info.description{18}
hFile = [hyspexFileName,'.img'];
if exist(hFile,'file')
    [img,infoScene] = hcReadHyspex(hFile);
end
wave = infoScene.wavelength;
scaleScene = str2double(infoScene.description{18}(12:end));


%% Select the white chip in the MCC
% This crops
[whiteHC,whiteRect] = hcimageCrop(img,[],80);
whiteHC = double(whiteHC)/scaleScene;
whiteHC = RGB2XWFormat(whiteHC);
whiteSPD = mean(whiteHC);

vcNewGraphWin; plot(wave,whiteSPD);

%% Divide the radiance by the reflectance.  

load('mccWhite');  % Spectral reflectance measured by HB
wReflectance = interp1(mccWhite.wavelength,mccWhite.reflectance,wave);

% vcNewGraphWin; plot(mccWhite.wavelength,mccWhite.reflectance);
vcNewGraphWin; plot(wave,wReflectance);

illSPD = whiteSPD./wReflectance;
vcNewGraphWin; plot(wave,illSPD,'k-',wave,whiteSPD,'r-')
legend('Illuminant','White chip')

save('illSPD','wave','illSPD')

%%