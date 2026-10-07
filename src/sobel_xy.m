function [Gx, Gy, Gmag, Gdir] = sobel_xy(Igray)
% =========================================================================
%  SOBEL_XY — Calcul robuste des gradients Sobel
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      [Gx, Gy, Gmag, Gdir] = sobel_xy(Igray)
%
%  Entrée :
%      Igray — Image en niveaux de gris (2D)
%
%  Sorties :
%      Gx    — Gradient horizontal
%      Gy    — Gradient vertical
%      Gmag  — Magnitude du gradient
%      Gdir  — Direction du gradient (radians)
%
%  Description :
%      Calcul des gradients Sobel :
%        - Convolution vectorisée
%        - Magnitude et direction robustes
%        - Normalisation automatique
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Sécurisation de l'image
Igray = im2double(Igray);

if ndims(Igray) ~= 2
    error('sobel_xy : Igray doit être une image 2D en niveaux de gris.');
end

%% Filtres Sobel (standard)
Sx = [ -1 0 1;
       -2 0 2;
       -1 0 1 ];

Sy = [ -1 -2 -1;
        0  0  0;
        1  2  1 ];

%% Convolution (vectorisée)
Gx = conv2(Igray, Sx, 'same');
Gy = conv2(Igray, Sy, 'same');

%% Magnitude du gradient
Gmag = sqrt(Gx.^2 + Gy.^2);

%% Direction du gradient
Gdir = atan2(Gy, Gx);

%% Normalisation robuste de la magnitude
Gmag = Gmag ./ (max(Gmag(:)) + eps);

%% Sécurisation finale
if any(isnan(Gmag), 'all') || any(isinf(Gmag), 'all')
    warning('sobel_xy : magnitude du gradient instable.');
end

end
