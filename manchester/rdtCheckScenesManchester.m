%% Download and check the natural scene database
%
% These scenes are stored on the Archiva Remote Data Toolbox system.
%
% This script validates the relative illumination and radiance of the
% stored scenes, checking that the reflectances are mainly in a physically
% plausible range.
%
% There will be some exceptions because of specularities and an inability
% to account for illumination.  But the basic values should be right.
%
% A potential challenge with this script is that we download the whole data
% set and it takes up a lot of disk space.
%
% See also:  Requires the Remote Data Toolbox on your path
%
% Copyright Imageval Consulting, LLC 2016

%%
rd = RdtClient('isetbio');

rd.crp('/resources/scenes/hyperspectral/manchester_database');

%% List the scenes
sList = rd.listArtifacts('printID',true);

%% Download, convert, and show one
ii = 8
data  = rd.readArtifact(sList(ii).artifactId);
scene = data.scene;
ieAddObject(scene); sceneWindow;

%%  Select an ROI
sceneGet(scene,'reflectance')
[locs,rect] = ieROISelect(scene);

% I wonder if I could set the roi used to correct it
% scene = sceneSet(scene,'roi',rect);

%% Based on what you know about, scale the data

desiredR = 0.44;   % This changes for each scene
rad = sceneGet(scene,'roi mean photons',rect);
scene = sceneSet(scene,'illuminant photons',rad*(1/desiredR));
vcReplaceObject(scene);

%% Convert the file
nBases = size(data.mcCOEF,3);
mType = 'canonical';
fullFile = fullfile(pwd,[sList(ii).artifactId,'.mat']);
vExplained = sceneToFile(fullFile,scene,nBases,mType);

%% Delete the old name, if it is there

fprintf('Using the browser, delete this artifact: %s\n',sList(ii).artifactId)

%%  This is how you publish the scenes and the jpg files
rd.publishArtifact(fullFile);

%%  Check with the browser
rd.openBrowser;

%%  Now, make a jpg of the data and put it up there, too
displayFlag = 1;
rgb = sceneShowImage(scene,displayFlag);
vcNewGraphWin; image(rgb); axis image
[p,n,e] = fileparts(fullFile);
fullFileJPG = fullfile(p,[n,'.jpg']);
imwrite(rgb,fullFileJPG);

%% Upload all the scenes and jpg to an HDR directory

rd.crp('/resources/scenes/faces');

%% Make a zip file combining all the hdr scenes and upload that, too.

rd.credentialsDialog;

localFolder = fullfile(isetRootPath,'local','facesScenes');

rd.publishArtifacts(localFolder,'type','mat');

rd.publishArtifacts(localFolder,'type','jpg');

%%
