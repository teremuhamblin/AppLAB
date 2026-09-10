function [corners, R] = harris_detector(Igray, window_size, k, threshold)
% HARRIS_DETECTOR Détecteur de coins de Harris.
%
%   [corners, R] = harris_detector(Igray, window_size, k, threshold)
%
%   corners : [x y] des points détectés
%   R       : carte de réponse de Harris

Igray = im2double(Igray);

% Gradients
[Gx, Gy] = gradient(Igray);

% Filtre de lissage
w = fspecial('gaussian', [window_size window_size], 1);

Ix2 = conv2(Gx.^2, w, 'same');
Iy2 = conv2(Gy.^2, w, 'same');
Ixy = conv2(Gx .* Gy, w, 'same');

% Réponse de Harris
R = (Ix2 .* Iy2 - Ixy.^2) - k * (Ix2 + Iy2).^2;

% Normalisation
Rnorm = mat2gray(R);

% Seuil
mask = Rnorm > threshold;

% Non-max suppression simple
corners = [];
[rows, cols] = find(mask);
for i = 1:length(rows)
    r = rows(i); c = cols(i);
    % petite fenêtre 3x3
    rmin = max(r-1,1); rmax = min(r+1,size(R,1));
    cmin = max(c-1,1); cmax = min(c+1,size(R,2));
    local = Rnorm(rmin:rmax, cmin:cmax);
    if Rnorm(r,c) == max(local(:))
        corners = [corners; c r]; %#ok<AGROW>
    end
end
end
