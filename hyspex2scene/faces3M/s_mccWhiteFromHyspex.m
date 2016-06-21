% s_ mccWhiteFromHyspex
%
% Henryk measured the reflectance spectra of one of our MCC targets all the
% way out to 1000 nm.  The data in macbethChart contains the 24 chips.
% We pulled out the white one to use for illuminant correction.
%
% This is the actual chart we used in the experiments.
%
%  We are wondering if we should change the ISET infrastructure,
%  which is based on the other MCC data, and use these measurements
%  instead?
%
% See macbethReadReflectance 

%% Initialize
ieInit

% wDir = fullfile(isetRootPath,'local','facesHyper');
wDir = fullfile(isetRootPath,'local','hyperspectral');
chdir(wDir);

%% The spectral reflectance of the MCC 
mcc = load('macbethChart');
% for ii=1:24
%     disp(ii)
%     plot(mcc.wavelength,mcc.data(:,4))
%     pause
% end

mccWhite.wavelength = mcc.wavelength;
mccWhite.reflectance = mcc.data(:,4);
vcNewGraphWin;
plot(mccWhite.wavelength,mccWhite.reflectance)
save mccWhite mccWhite

%%