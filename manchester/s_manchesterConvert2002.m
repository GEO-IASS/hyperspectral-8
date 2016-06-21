%% List of URLs for the online Manchester data
% Scenes to download from Foster et al
%
% 2002 –Scenes 1-8  at
%   http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02.html
% 2004 Database Scenes 1-8 at:
%   http://personalpages.manchester.ac.uk/staff/david.foster/Hyperspectral_images_of_natural_scenes_04.html
% 2015- 30 hyperspectral radiance images of natural scenes in which small neutral probe spheres were embedded to provide estimates of local illumination spectra. Some of these scenes are also in 2002 and 2004 database, minus the probes http://personalpages.manchester.ac.uk/staff/david.foster/Local_Illumination_HSIs/Local_Illumination_HSIs_2015.html
% 2015 - Time lapsed image data for 4 scenes to show change in spectral content of illumination.. can also be used to create an illuminant image based on the pixels that change http://personalpages.manchester.ac.uk/staff/d.h.foster/Time-Lapse_HSIs/Time-Lapse_HSIs_2015.html

%% Clear work space
ieInit

% Make sure isetwork/Hyperspectral is on your path

%% Change to a local directory where we will temporarily download the data

d = fullfile(isetRootPath,'local','manchester');
if ~exist(d,'dir'), mkdir(d); end

%% Here are the URLs to the 2002 files with the reflectance data
urls2002 = {...
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02_files/scene1.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02_files/scene2.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02_files/scene3.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02_files/scene4.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02_files/scene5.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02_files/scene6.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02_files/scene7.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_02_files/scene8.zip'};

% Eight scene cropping rectangles
sz2002 = [
    1, 1, 818, 747;
    1, 1, 818, 700;
    1, 1, 819, 749;
    97,3, 724, 656;
    9, 1, 811, 818;
    168, 1, 467, 753;
    216, 95, 416, 681;
    214, 2 , 606, 698;
    ];

%% For each reflectance data set in the 2002 data set
chdir(d);
if ~exist(fullfile(d,'2002'),'dir'),mkdir('2002'); end

for ii=1:length(urls)
    %  Download it
    [p,fname,e] = fileparts(urls2002{ii});
    zipfilename = [fname,e];
    websave(zipfilename,urls2002{ii});
    
    % Unzip it to the directory with the base name
    unzip(zipfilename);
    
    % fname = sprintf('scene%d',ii);    
    load(fname);
    
    % Adjust the wavelength for some of the special cases
    nWave = size(reflectances,3);
    if nWave == 33
        wave = 400:10:720;
    elseif nWave == 31  % 2002 case should be this
        wave = 410:10:710;
    elseif nWave == 32  % 2004 has a 32 sample case
        wave = 400:10:710;
    end
    
    % Make an empty scene with the proper name and illuminant
    scene = sceneCreate('empty');
    scene = sceneSet(scene,'name',sprintf('Manchester_2002_scene%d',ii));
    scene = sceneSet(scene,'wave',wave);
    scene = sceneSet(scene,'illuminant',illuminantCreate('D65',wave));
    
    % Multiply the original reflectances by the illuminant to calculate
    % photons
    ill = sceneGet(scene,'illuminant photons');
    [reflectances,row,col] = RGB2XWFormat(reflectances);
    photons = XW2RGBFormat(reflectances*diag(ill),row,col);
    scene = sceneSet(scene,'photons',photons);
    
    % Crop the scene
    scene = sceneCrop(scene,sz2002(ii,:));
    
    % Now, write out scene
    mType = 'canonical';
    vExplained = 0.999;
    fullFile = fullfile(pwd,'2002',[fname,'_2002_iset.mat']);
    comment = 'Original reflectances from the posted data are preserved.  Illuminant set to D65';
    sceneToFile(fullFile,scene,vExplained,mType,comment);
    
    fprintf('%d Processed %s\n',ii,fullFile);
    s = sceneFromFile(fullFile,'multispectral');
    ieAddObject(s); sceneWindow;
   
end

%%  Create the JPEG images
d = fullfile(isetRootPath,'local','manchester','2002');
files = dir(fullfile(d,'*.mat'));

for ii=1:length(files)
    ifile = fullfile(d,files(ii).name);
    s = sceneFromFile(ifile,'multispectral');
    rgb = sceneGet(s,'rgb');
    [~,n,~] = fileparts(files(ii).name);
    oname = fullfile(d,[n,'_2002_iset.jpg']);
    imwrite(rgb,oname,'jpg');
end

%%
