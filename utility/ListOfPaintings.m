% ListOfPaintings
% go through and look at the images and decide which to put in the database
% this is just a start

chdir('F:\Stanford hyperspectral data\Art\Radiance\Sellaio\SWIR')
% List of files
%
painting = 'Sellaio_SWIR_320me_SN3506_17700_us_HSNR32_2012-02-03T153251_corr_rad'; % good
painting = 'Sellaio_SWIR_320me_SN3506_17700_us_2012-02-03T153711_corr_rad' % with lambertian target
painting = 'Sellaio_SWIR_320me_SN3506_17700_us_2012-02-03T153636_corr_rad'; % reference
painting = 'Sellaio_SWIR_320me_SN3506_17700_us_2012-02-03T153232_corr_rad'; % good

whiteboard = 'Sellaio_SWIR_320me_SN3506_17700_us_2012-02-03T153636_corr_rad';

dataFile = [painting ,'.img'];
if ~exist(dataFile,'file'), error('Could not find %s\n',dataFile);
else
    [img,info] = hcReadHyspex(dataFile);
end

hcimage(img);