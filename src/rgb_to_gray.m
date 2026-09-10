function Igray = rgb_to_gray(I)
% RGB_TO_GRAY Convertit une image RGB en niveaux de gris.
%
%   Igray = rgb_to_gray(I)
%
%   Si l'image est déjà mono-canal, elle est renvoyée telle quelle.

if ndims(I) == 3
    I = im2double(I);
    Igray = 0.299 * I(:,:,1) + 0.587 * I(:,:,2) + 0.114 * I(:,:,3);
else
    Igray = im2double(I);
end
end
