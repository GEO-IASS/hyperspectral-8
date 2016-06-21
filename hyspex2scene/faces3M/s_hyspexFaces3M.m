% s_hyspexFaces3M
%
% This script creates a scene from Hyspex 3M face data 
% (see http://www.hyspex.no/)
%
% The Hyspex data are stored in two files.
%   .img - the measurements, which are uncalibrated (relative) spectral radiance
%   .hdr - the information necessary to convert the img data to spectral
%          radiance with units of
%
% The img and hdr data are currently on a 1T hard drive that JEF has.
%
% Copyright ImagEval Consultants, LLC, 2013

%% Initialize
ieInit

% The data are on this drive.
wDir = '/Volumes/G-DRIVE mobile with Thunderbolt/Hyspex/Data/Faces_3meters/VNIR';
chdir(wDir);


%% Here is the set of file names and the illuminant file

load('hyspexFilenames');   % Loads hyspex variable 

theseFiles = hyspex.faces.vnir.names;
nFiles = size(theseFiles,1);
fileNames = cell(1,nFiles);
saveNames = cell(1,nFiles);
for ii=1:nFiles
    fileNames{ii} = hyspex.faces.vnir.names{ii,1};
    saveNames{ii} = hyspex.faces.vnir.names{ii,2};
end

%% Create the save directory.  Note we are not emptying it if it exists

saveDir = fullfile(pwd,'output');
if ~exist(saveDir,'dir'), mkdir(saveDir); end


%% Read the spatial distribution of the illuminant data

% We use the same rect from the illData as the rect we chose for the scene
illuminantFile = hyspex.faces.vnir.illuminant;
illuminantFile = [illuminantFile,'.img'];
if ~exist(illuminantFile,'file')
    error('Could not find %s\n',illuminantFile);
else
    [illData,infoIll] = hcReadHyspex(illuminantFile);
end
hcimage(illData);


%% Read the illuminant which is stored locally by BW.

% The illuminant was calculated using s_illuminantEstimate.m in the
% isetwork/Hyperspectral/ directory.
ill = illuminantCreate;
illFile = fullfile(hyspexRootPath,'hcdata','illSPD');
foo = load(illFile);
ill = illuminantSet(ill,'wave',foo.wave);

% Scale factor chosen to match Henryk's reflectance measurement.  We save
% the illuminant structure as part of the final scene.
ill = illuminantSet(ill,'energy',foo.illSPD*1.05);

% We use the SPD in calculations below
illSPD = sceneGet(scene,'illuminant energy');

%% Process the face files in a loop

for ii=1:nFiles
    hyspexFileName = fileNames{ii};
    
    % The scaling parameter is in info.description{18}
    hFile = [hyspexFileName,'.img'];
    if exist(hFile,'file')
        [img,infoScene] = hcReadHyspex(hFile);
    end
    wave = infoScene.wavelength;
    scaleScene = str2double(infoScene.description{18}(12:end));
    if isnan(scaleScene)
        % There was one file without a good scale factor.  So we trapped
        % the case here and kept scaling until we found this reasonable
        % number.
        warning('Scale scene is a NaN.  Making something up.');
        scaleScene = 1.3e+6;
    else fprintf('scene scale %g\n',scaleScene);
    end
    
    % This asks the user to crop the image data
    [sceneHC,sceneRect] = hcimageCrop(img,[],80);
    sceneHC = double(sceneHC)/scaleScene;
    hcimage(sceneHC);
    
    % Estimate the illuminant level from the illData in the same rect.  The
    % illData is a whiteboard
    [illuminantHC, illuminantRect] = hcimageCrop(illData,sceneRect);
    scaleIll = str2double(infoIll.description{18}(12:end));
    illuminantHC = (double(illuminantHC)/scaleIll);
    
    % The board has some scratches, so we blur it
    spatialSpread   = 15;
    illuminantHC    = hcBlur(illuminantHC,spatialSpread);
    
    % Now summarize the illuminant level across space
    illuminantSpace = mean(illuminantHC,3);
    illuminantSpace = ieScale(illuminantSpace,1);
    
    vcNewGraphWin; mesh(illuminantSpace);colormap(cool);
    % Make the spatial spectral illuminant
    
    % Make a spatial spectral illuminant from the relative intensities
    % derived from the whiteboard and from the relative spd in illSPD
    sz = size(sceneHC);    
    ssIlluminant = repmat(illSPD(:)',[prod(sz(1:2)),1]);
    ssIlluminant = XW2RGBFormat(ssIlluminant,sz(1),sz(2));
    
    % Multiply every wavelength dimension by the normalized spatial
    % intensity that we calculated above
    ssIlluminant = bsxfun(@times,illuminantSpace,ssIlluminant);
    
    % Make a dummy scene and fill it with the data
    patchSize = 16;
    scene = sceneCreate('default',patchSize,wave);
    scene = sceneSet(scene,'energy',sceneHC);
    scene = sceneSet(scene,'illuminant energy',ssIlluminant);
    % ieAddObject(scene); sceneWindow;
    
    sceneR = sceneRotate(scene,'ccw');
    % ieAddObject(sceneR); sceneWindow;

    oFiles = fullfile(saveDir,saveNames{ii});
    sceneToFile(oFiles,sceneR,0.999);
end

%%
