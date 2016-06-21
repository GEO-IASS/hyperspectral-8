%% s_hyspexFilenamesCreate.m
%
% The first entry is the long Hyspex name for each radiance file (energy
% units).  The second entry is the shorter ISET scene file name.  This
% script creates the variables and saves then in hyspexFilenames.
%
% The files are stored in a directory tree.  The root of the data tree is
% HyspexDatabase.  The path to each of the files is stored in a
% corresponding variables.  For examples, hyspexFacesNames and
% hyspexFacesNamesPath.
%
% There are several different types of file names grouped for
%   Faces, FacesCloseUp, Fruit
%
% The hyspex structure contains slots for
%    faces, facecloseups, fruit
% 
% These are divided into vnir and swir sections.
% Each of these sections has a slot for
%  names: Cell array, N x 2, a hyspex file name, ISET scene file name
%  illuminant:  Illuminant file name in hyspex database side
%
% An example is hyspex.faces.vnir.names, or
% hyspex.facescloseup.swir.illuminant
%
% The outdoor scenes will be handled differently.  See s_hyspexOutdoors.m
%
% % Copyright ImagEval Consultants, LLC, 2013


%%
hcRootPath='/Users/joyce/Documents/MATLAB/SVN/pdcprojects/Hyperspectral';
%% Faces (low resolution) VNIR

faces.vnir.names = {
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T111055_raw_rad', 'LoResMale1', 
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T135721_raw_rad', 'LoResMale2',     
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T151022_raw_rad', 'LoResMale3', 
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T120459_raw_rad', 'LoResMale4',   
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T140138_raw_rad', 'LoResMale5',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T130301_raw_rad', 'LoResMale6',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T111411_raw_rad', 'LoResMale7',  
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T112602_raw_rad', 'LoResMale8', 
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T121001_raw_rad', 'LoResMale9',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T141528_raw_rad', 'LoResMale10',  
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T160023_raw_rad', 'LoResMale11',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T111611_raw_rad', 'LoResMale12', 
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T121446_raw_rad', 'LoResMale13', 
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T154753_raw_rad', 'LoResMale14',    
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T111258_raw_rad', 'LoResMale15',    
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T121314_raw_rad', 'LoResMale16',    
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T151830_raw_rad', 'LoResMale17', 
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T151605_raw_rad', 'LoResMale18', 
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T121924_raw_rad', 'LoResMale19',    
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T125142_raw_rad', 'LoResMale21'
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T121732_raw_rad', 'LoResMale22',  
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T162939_raw_rad', 'LoResMale23', 
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T164247_raw_rad', 'LoResMale24',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T110944_raw_rad', 'LoResMale25',
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T164107_raw_rad', 'LoResMale27',
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T163952_raw_rad', 'LoResMale28', 
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T130626_raw_rad', 'LoResMale29',  
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T112718_raw_rad', 'LoResMale30', 
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T130106_raw_rad', 'LoResMale31',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T111827_raw_rad', 'LoResMale32',       
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T125343_raw_rad', 'LoResMale34',    
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T151511_raw_rad', 'LoResMale36',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T110755_raw_rad', 'LoResMale39',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T114837_raw_rad', 'LoResMale40',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T125243_raw_rad', 'LoResFemale1',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T123618_raw_rad', 'LoResFemale2',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T141415_raw_rad', 'LoResFemale3',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T130444_raw_rad', 'LoResFemale4',
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T151925_raw_rad', 'LoResFemale5',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T113728_raw_rad', 'LoResFemale6',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T131241_raw_rad', 'LoResFemale7', 
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T111728_raw_rad', 'LoResFemale8',     
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T161124_raw_rad', 'LoResFemale9',
'Faces day 2_VNIR_1600_SN0004_40000_us_2x_2011-12-13T135210_raw_rad', 'LoResFemale10',     
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T160704_raw_rad', 'LoResFemale11', 
'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T151416_raw_rad', 'LoResFemale12'};

faces.vnir.illuminant = 'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T155130_raw_rad';




%% Faces (low resolution) SWIR
% 
% faces.swir.names = {
% 'Faces day2_SWIR_320me_SN3506_11000_us_HSNR16_2011-12-13T151433_raw_rad', 'LoResFemale5SWIR',
% 'Faces day 2_SWIR_320me_SN3506_11000_us_HSNR16_2011-12-13T151721_raw_rad','LoResMale2SWIR',
% 'Faces day 2_SWIR_320me_SN3506_2700_us_2011-12-13T150754_raw', 'MCCSWIR'};
% no whiteboard

%% FacesCloseup (high resolution) VNIR

facecloseups.vnir.names = {
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T155925_corr_rad', 'HiResMale1',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T125853_corr_rad', 'HiResMale2',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T160622_corr_rad', 'HiResMale3',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T163151_corr_rad', 'HiResMale4'
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T133710_corr_rad', 'HiResMale5',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T145842_corr_rad', 'HiResMale6',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T150140_corr_rad', 'HiResMale7',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T163745_corr_rad', 'HiResMale8',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T143912_corr_rad', 'HiResMale9',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T132311_corr_rad', 'HiResMale10',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T164635_corr_rad', 'HiResMale11',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T124623_corr_rad', 'HiResMale12',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T150844_corr_rad', 'HiResFemale1',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T140538_corr_rad', 'HiResFemale2',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T162154_corr_rad', 'HiResFemale3',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T122814_corr_rad', 'HiResFemale4',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T130437_corr_rad', 'HiResFemale5',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T130826_corr_rad', 'HiResFemale6',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T162154_corr_rad', 'HiResFemale7',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T162748_corr_rad', 'HiResFemale8',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T145202_corr_rad', 'HiResFemale9',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T124943_corr_rad', 'HiResFemale10',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T122439_corr_rad', 'HiResFemale11',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T151520_corr_rad', 'HiResFemale12',
'faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T152352_corr_rad', 'HiResFemale13'};

facecloseups.vnir.illuminant ='faces_VNIR_1600_SN0004_40000_us_2x_2012-02-06T152628_corr_rad';


%% FacesClosup (high resolution) SWIR

facecloseups.swir.names = {
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T150717_corr_rad', 'SWIR_HiResFemale1',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T140313_corr_rad', 'SWIR_HiResFemale2',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T162036_corr_rad', 'SWIR_HiResFemale3',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T123531_corr_rad', 'SWIR_HiResFemale4',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T162036_corr_rad', 'SWIR_HiResFemale8',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T145533_corr_rad', 'SWIR_HiResFemale9',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T132942_corr_rad', 'SWIR_HiResFemale11',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T151407_corr_rad', 'SWIR_HiResFemale12',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T130328_corr_rad', 'SWIR_HiResFemale5',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T152231_corr_rad', 'SWIR_HiResFemale13',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T160144_corr_rad', 'SWIR_HiResMale1',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T130105_corr_rad', 'SWIR_HiResMale2',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T160442_corr_rad', 'SWIR_HiResMale3',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T163052_corr_rad', 'SWIR_HiResMale4',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T143754_corr_rad', 'SWIR_HiResMale5',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T145737_corr_rad', 'SWIR_HiResMale6',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T150405_corr_rad', 'SWIR_HiResMale7',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T163644_corr_rad', 'SWIR_HiResMale8',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T143754_corr_rad', 'SWIR_HiResMale9',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T132610_corr_rad', 'SWIR_HiResMale10',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T164512_corr_rad', 'SWIR_HiResMale11',
'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T124256_corr_rad', 'SWIR_HiResMale12'};

facecloseups.swir.illuminant = 'faces_SWIR_320me_SN3506_10000_us_HSNR04_2012-02-06T152856_corr_rad';

%%  Fruit VNIR

fruit.vnir.names= {
'Still life 4_VNIR_1600_SN0004_35000_us_2x_HSNR08_2011-12-12T140308_raw_rad', 'FruitMCC',
'charts++_VNIR_1600_SN0004_100000_us_2x_2011-12-20T142631_corr_rad', 'ChartsRottenFruit'};
fruit.vnir.illuminant = [];

%%  Fruit SWIR

fruit.swir.names = {
'Still life 4_SWIR_320me_SN3506_12000_us_HSNR08_2011-12-12T141508_raw_rad', 'FruitMCCSWIR',
'charts++_SWIR_320me_SN3506_18000_us_HSNR04_2011-12-20T144328_corr_rad','ChartsRottenFruitSWIR'};
fruit.swir.illuminant = [];

%% Outdoor VNIR and SWIR will probably be separated and handled differently
outdoor.vnir.names = {
'view_VNIR_1600_SN0004_4000_us_2x_HSNR04_2012-02-02T135936_corr_rad_cropDish', 'StanfordDish',         
'view_VNIR_1600_SN0004_4000_us_2x_HSNR04_2012-02-02T135936_corr_rad_cropSanFran', 'SanFrancisco',      
'view_VNIR_1600_SN0004_4000_us_2x_HSNR04_2012-02-02T135936_corr_rad_cropStanford', 'StanfordTower',     
'view_VNIR_1600_SN0004_8000_us_2x_HSNR04_2012-02-02T135228_corr_rad_cropDish',         'StanfordDishPFilter',
'view_VNIR_1600_SN0004_8000_us_2x_HSNR04_2012-02-02T135228_corr_rad_cropSanFran',      'SanFranciscoPFilter',  
'view_VNIR_1600_SN0004_8000_us_2x_HSNR04_2012-02-02T135228_corr_rad_cropStanford',    'StanfordTowerPFilter'
'quad_VNIR_1600_SN0004_8000_us_2x_HSNR08_2012-02-01T101456_corr_rad_crop', 'StanfordMemorial'};
outdoor.vnir.illuminant = [];

%% Outdoor SWIR
outdoor.swir.names = {
'view_SWIR_320me_SN3506_5000_us_HSNR04_2012-02-02T125930_corr_rad', 'StanfordTowerSWIR',
'view_SWIR_320me_SN3506_5000_us_HSNR04_2012-02-02T132716_corr_rad', 'StanfordDishPanoramaSWIR'};
outdoor.swir.illuminant = [];

%% Save the structure in the hyperspectral database directory.

% Make the  hyspex structure with all the cell arrays
hyspex.faces        = faces;
hyspex.facecloseups = facecloseups;
hyspex.fruit        = fruit;
hyspex.outdoor     = outdoor;

fname = fullfile(hcRootPath,'database','hyspexFilenames');
save(fname,'hyspex');

%%



