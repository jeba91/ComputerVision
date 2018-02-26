function [ imOut ] = denoise( image, kernel_type, varargin)


switch kernel_type
    case 'box'
        imOut = imboxfilt(image,varargin{1});
    case 'median'
        imOut = medfilt2(image,[varargin{1} varargin{2}]);
    case 'gaussian'
        fprintf('Not implemented\n')
end

return

end
