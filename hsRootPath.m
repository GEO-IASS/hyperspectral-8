function rootPath=hsRootPath()
% Return the path to the root iset directory
%
% This function must reside in the directory at the base of the
% hyperspectral directory structure.  It is used to determine the location
% of various sub-directories.
% 
% Example:
%   fullfile(hsRootPath,'manchester')

rootPath = which('hsRootPath');

rootPath = fileparts(rootPath);

return
