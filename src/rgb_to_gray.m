function Igray = rgb_to_gray(I)
% =========================================================================
%  RGB_TO_GRAY — Conversion robuste RGB → niveaux de gris
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      Igray = rgb_to_gray(I)
%
%  Entrée :
%      I — Image RGB, RGBA ou grayscale
%
%  Sortie :
%      Igray — Image en niveaux de gris (double, normalisée)
%
%  Description :
%      Conversion robuste en niveaux de gris :
%        - Support RGB, RGBA, grayscale
%        - Coefficients ITU-R BT.601 (0.299, 0.587, 0.114)
%        - Normalisation automatique
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Sécurisation de l'image
if isempty(I)
    error('Image vide : impossible de convertir en niveaux de gris.');
end

% Conversion en double
I = im2double(I);

%% Cas 1 : Image RGB (3 canaux)
if ndims(I) == 3 && size(I,3) == 3
    % Coefficients ITU-R BT.601
    Igray = 0.299 * I(:,:,1) + ...
            0.587 * I(:,:,2) + ...
            0.114 * I(:,:,3);

%% Cas 2 : Image RGBA (4 canaux)
elseif ndims(I) == 3 && size(I,3) == 4
    % On ignore le canal alpha
    Igray = 0.299 * I(:,:,1) + ...
            0.587 * I(:,:,2) + ...
            0.114 * I(:,:,3);

%% Cas 3 : Image déjà en niveaux de gris
elseif ndims(I) == 2
    Igray = I;

%% Cas non supporté
else
    error('Format d’image non supporté pour rgb_to_gray.');
end

%% Normalisation robuste
Igray = max(min(Igray, 1), 0);

%% Sécurisation finale
if any(isnan(Igray), 'all') || any(isinf(Igray), 'all')
    warning('Conversion RGB → Gray instable. Vérifie l’image d’entrée.');
end

end
