%% s_manchesterDownload
%
% Example of how to download a scene from the Manchester database

%% Open the repository
rd = RdtClient('isetbio');
rd.crp('/resources/scenes/hyperspectral/manchester_database/2002');

a = rd.listArtifacts('type','mat');
sData = rd.readArtifact(a(1),'type','mat');

%%
scene = sceneFromBasis(sData);
scene = sceneSet(scene,'name','Manchester 2002 scene1');
ieAddObject(scene); sceneWindow;

%%
rd.crp('/resources/scenes/hyperspectral/manchester_database/2004');

a = rd.listArtifacts('type','mat');
sData = rd.readArtifact(a(1),'type','mat');

%%
scene = sceneFromBasis(sData);
scene = sceneSet(scene,'name','Manchester 2004 scene1');
ieAddObject(scene); sceneWindow;

%%