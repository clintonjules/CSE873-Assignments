function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%

    % Check if filter dimensions are odd
    if mod(size(filter, 1), 2) == 0 || mod(size(filter, 2), 2) == 0
        error('Filter dimensions must be odd');
    end

    % Get dimensions of the image and filter
    [img_height, img_width, num_channels] = size(image);
    [filter_height, filter_width] = size(filter);
    
    % Calculate padding sizes
    pad_height = (filter_height - 1) / 2;
    pad_width = (filter_width - 1) / 2;
    
    % Initialize output image
    output = zeros(size(image), 'like', image);
    
    % Pad the image with zeros using padarray()
    padded_image = padarray(image, [pad_height, pad_width], 0, 'both');
    
    % Apply filter to each channel
    for channel = 1:num_channels
        for i = 1:img_height
            for j = 1:img_width
                % Extract the region of interest
                roi = padded_image(i:i+filter_height-1, j:j+filter_width-1, channel);
                
                % Apply filter
                output(i, j, channel) = sum(roi(:) .* filter(:));
            end
        end
    end
end