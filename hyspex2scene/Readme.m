%% The properties of the Hyspex data and the analysis of the data
%(see <http://www.hyspex.no/>)
%
% The text here includes things we did at several different points.  The
% most recent analysis is in faces3M/s_hyspexFaces3M.m
%
% The general background here is true.  Some of the specific metadata (such
% as the rects and other auxiliary data) are now out of date.
%
% The Hyspex data are stored in two files.
%   .img - the measurements, which are uncalibrated (relative) spectral radiance
%   .hdr - the information necessary to convert the img data to spectral
%          radiance with units of
%
% Torbjorn had a file he and JEF ran on his system that converted their raw
% data into the img and hdr data.  Those data are described here, but they
% are stored by JEF on a portable drive. 
%
% Copyright ImagEval Consultants, LLC, 2013

%% General
%
% The hyperspectral data are processed using the functions in ISET within
% the hypercube subdirectory.  Make sure you have ISET on your path!
%
%% Data files
%
% There are a lot of measurement files.  They have long names.  We assigned
% them more convenient names. The correspondence is stored in a data file
% (hyspexFilenames.mat). To use this file, you can run
%
% load('hyspexFilenames')
% hyspex = 
%            faces: [1x1 struct]
%     facecloseups: [1x1 struct]
%            fruit: [1x1 struct]
%          outdoor: [1x1 struct]
% 
% hyspex.faces.vnir =
%          names: {46x2 cell}
%     illuminant: 'Face test 1_VNIR_1600_SN0004_35000_us_2x_2011-12-12T155130_raw_rad'
%
% In some cases (faces) the name   of an illuminant file is also stored in
% hyspexFilenames.mat.  This is the name of a separate Hyspex file that has
% the whiteboard image used for estimating the illuminant spd and the
% variation of the illuminant spd across space.
%
% In other cases (facesCloseup, fruit, Outdoor) there is no illuminant
% file, and we estimate the illuminant spd using a white surface in the
% scene.

%% Regions of interest (out of date)
%
% We created a file with the rectangular coordinates of the area we cropped
% from the original Hyspex data files. This ROI file is has the name of the
% original Hyspex data file with a -sRect.mat extension. It is stored in
% the same directory as the original Hyspex data files
%
%% Processing
%
% The data are processed by scripts in the relevant directories (faces1M,
% faces3M ...)
%
% The scripts for uploading the processed data to the RDT are in the rdt
% subdirectory.
%
%% Auxiliary (out of date)
%
% We created a file that contains the parameters we used to create
% the ISET files.   The file has '_aux' appended to the isetFileName.
%
% This auxiliary file contains
%  'hyspexFileName :         the name of the Hypsex img file
%  'isetFileName':           the name of the ISET file
%  'sceneRect' :             the rect of the Hypex.img file that we cropped
%  'illuminantFileName':     the name of the Hyspex illuminant file. Note that
%                           if an illuminantFilename does not exist, then
%                           we know tha the illuminant rect was a portion
%                           of the image and not a portion of a separate
%                           file. This also means that we did NOT correct
%                           for non-uniform scene illumination
%  'illuminantRect':         the portion of the image (or illuminant file) that was
%                           used to estimate the illuminant
%  'illuminantScaleFactor':  in some cases we had to scale the illuminant
%                           because the maximum reflectance for objects was
%                           greater than 1.  This indicates that our
%                           illuminant estimates were off by a scale
%                           factor. This can happen when we use a surface
%                           in the scene (say a white or gray surface) to
%                           estimate the scene illuminant spd. Since we do
%                           not know how reflective the surface was, we can
%                           easily by off by a scale factor. While we had
%                           to make this adjustment by hand, this
%                           information is stored so that we can generate
%                           the ISET file from the original Hyspex data
%                           files.
%  'comment' (optional)
%
%% PROCESSING STEPS (General, but out of date)
%
% It is best to read the scripts in the relevant directories to see the
% most recent processing.  These notes are old and not always followed for
% faces3M and faces1M.
%
% To read the Hyspex data, we need to have 2 files with the same name but
% with *.hdr and *.img extensions.
%
% We also have a *-sRect.mat file that contains the sceneRect.
% We ran  s_hyspexCreateRects to create the *-sRect.mat files
% In a few cases we have a *-iRect.mat file that contains the
% illuminantRect.
%
% Illuminant SPD
%   1. Read in the Hyspex file for the scene data that has the Lambertian
%   surface we use to measure the illuminant
%   2. Read the data from the sceneRect or illuminantRect portion and
%   estimate the spd of the illumination.
%
%  Scene
%   3. Read in the Hyspex scene radiance data (energy units)
%   4. Crop using the saved sceneRect
%   5. Convert the scene to photons
%   6. Estimate the SNR in each waveband and decide which wavelengths to
%   retain (both for the scene and illuminant)  Not yet implemented.
%   7. Scale the mean illuminant level so that the reflectances are
%   between 0 and 1.
%   8. Validate that the reflectances make sense
%       ** For outdoor scenes illuminant and reflectances cannot be
%       properly estimated because we do not know what the scene illuminant
%       is at each point in the scene.  We plan to write a routine that
%       introduces space-varying illumination to bring the reflectances
%       into a reasonably normal range.
%
% Data storage and compression
%   9. Store scene and illuminant in an ISET file using sceneToFile.  We
%   store one version uncompressed and one compressed (basis functions and
%   basis coefficients)
%
%% EXPERIMENT NOTES (out of date)
%
% In some of our Hyspex sessions, we were able to place a white board
% across the area we were scanning and use the radiance from the white
% board to estimate the illumination.
%
% In the outdoor scenes, we could not put a white board across the vista
% and we cannot assume that the lighting is uniform. We will estimate the
% spectral power of an illuminant falling on a white board in the scene and
% store that But it is important to remember that using this illuminant to
% estimate reflectance is .... well, not so good.  We plan to write code to
% generate a space-varying illuminant that is consistent with the scene.
%
% Copyright ImagEval Consultants, LLC, 2012.
%
%%