function [val,hdrStrings] = hyspexFindString(fName,str)
% Find the value of a string in a hyspex header file
%
%   val = hyspexFindString(fName,str)
%
% Example:
%
%  fName = 'F:\HyspexDatabase\Faces\VNIR\_VNIR_1600_SN0004_35000_us_2x_2011-12-12T162627_raw_rad';
%
%  [val,hdrStrings] = hyspexFindString(fName,'Scaling');
%
%  [val,hdrStrings] = hyspexFindString(fName,'Scaling');
%  val = hyspexFindString(fName,'Lens')
%  val = hyspexFindString(fName,'NumberOfAvg')
%
% (c) Imageval, LLC 2013

if ieNotDefined('fName'), error('File name required'); end
[p,n,e] = fileparts(fName);

if isempty(e), fName = [fName,'.hdr'];
elseif ~strcmp(e,'.hdr')
    error('File extension should be hdr');
end
if ieNotDefined('str'), str = 'Scaling'; end

fid = fopen(fName,'r');
hdrStrings = textscan(fid,'%s');
fclose(fid);
strCellArray = hdrStrings{1};

switch str
    case {'Scaling','NumberOfAvg','Lens'}
        for ii=1:1000
            if strcmp(strCellArray{ii},str)
                val = str2double(strCellArray{ii+2});
                break
            end
        end
        
    case {'PixelSizeX'}
        for ii=1:1000
            if strcmp(strCellArray{ii},'Pixelsize')
                if strcmp(strCellArray{ii+1},'x')
                    val = str2double(strCellArray{ii+3});
                    break
                end
            end
        end
        
    case {'PixelSizeY'}
        for ii=1:1000
            if strcmp(strCellArray{ii},'Pixelsize')
                if strcmp(strCellArray{ii+1},'y')
                    val = str2double(strCellArray{ii+3});
                    break
                end
            end
        end
        
    otherwise
        error('Unknown string %s\n',str);
end

end

