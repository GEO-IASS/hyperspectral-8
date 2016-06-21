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
urls2004 = {...
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_04_files/scenes/scene1.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_04_files/scenes/scene2.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_04_files/scenes/scene3.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_04_files/scenes/scene4.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_04_files/scenes/scene5.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_04_files/scenes/scene6.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_04_files/scenes/scene7.zip',
    'http://personalpages.manchester.ac.uk/staff/d.h.foster/Hyperspectral_images_of_natural_scenes_04_files/scenes/scene8.zip'};

sz2004 = [ 
    1,1, 1018, 1339;
    1,1, 1017, 1338; 
    1,1, 1018, 1267;
    1,1, 1019, 1337;
    1,1, 1020, 1339];

refname = {
    'ref_crown3bb_reg1',
    'ref_ruivaes1bb_reg1_lax',
    'ref_mosteiro4bb_reg1_lax',
    'ref_cyflower1bb_reg1',
    'ref_cbrufefields1bb_reg1_lax',
    'ref_braga1bb_reg1',
    'ref_ribeira1bbb_reg1',
    'ref_farme1bbbb_reg1.mat'};

%% For each reflectance data set in the 2002 data set
chdir(d);
if ~exist(fullfile(d,'2004'),'dir'),mkdir('2004'); end

%  Download the files and unzip them
for ii=1:length(urls2004)
    [p,fname,e] = fileparts(urls2004{ii});
    zipfilename = [fname,e];
    websave(zipfilename,urls2004{ii});
    
    % Unzip it to the directory with the base name
    unzip(zipfilename);

end
%% Read reflectances and create scenes

% There are a series of files inside the directory fname
% The file containing the reflectance data is
for ii=1:length(urls2004)
    
    [p,fname,e] = fileparts(urls2004{ii});
    rFile = fullfile(d,sprintf('scene%d',ii),refname{ii});
    load(rFile);   % LOad the variable called reflectances
    
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
    scene = sceneSet(scene,'name',sprintf('Manchester_2004_scene%d',ii));
    scene = sceneSet(scene,'wave',wave);
    scene = sceneSet(scene,'illuminant',illuminantCreate('D65',wave));
    
    % Multiply the original reflectances by the illuminant to calculate
    % photons
    ill = sceneGet(scene,'illuminant photons');
    [reflectances,row,col] = RGB2XWFormat(reflectances);
    photons = XW2RGBFormat(reflectances*diag(ill),row,col);
    scene = sceneSet(scene,'photons',photons);
            
    % Now, write out scene
    mType = 'canonical';
    vExplained = 0.999;
    fullFile = fullfile(pwd,'2004',[fname,'_2004_iset.mat']);
    comment = 'Original reflectances from the posted data are preserved.  Illuminant set to D65';
    sceneToFile(fullFile,scene,vExplained,mType,comment);
    
    fprintf('%d Processed %s\n',ii,fullFile);
    s = sceneFromFile(fullFile,'multispectral');
    ieAddObject(s); sceneWindow;
    
end


%% Create the 2004 JPEG images
d = fullfile(isetRootPath,'local','manchester','2004');
files = dir(fullfile(d,'*.mat'));

for ii=1:length(files)
    ifile = fullfile(d,files(ii).name);
    s = sceneFromFile(ifile,'multispectral');
    rgb = sceneGet(s,'rgb');
    [~,n,~] = fileparts(files(ii).name);
    oname = fullfile(d,[n,'_2004_iset.jpg']);
    imwrite(rgb,oname,'jpg');
end

%%

