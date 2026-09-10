function [Gx, Gy, Gmag, Gdir] = sobel_xy(Igray)
% SOBEL_XY Calcule les gradients de Sobel en X et Y.
%
%   [Gx, Gy, Gmag, Gdir] = sobel_xy(Igray)

Igray = im2double(Igray);

Sx = [ -1 0 1;
       -2 0 2;
       -1 0 1 ];

Sy = [ -1 -2 -1;
        0  0  0;
        1  2  1 ];

Gx = conv2(Igray, Sx, 'same');
Gy = conv2(Igray, Sy, 'same');

Gmag = sqrt(Gx.^2 + Gy.^2);
Gdir = atan2(Gy, Gx);
end
