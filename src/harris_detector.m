function [corners, R] = harris_detector(Igray, window_size, k, threshold)
% =========================================================================
%  HARRIS_DETECTOR — Détecteur de coins de Harris (version robuste)
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      [corners, R] = harris_detector(Igray, window_size, k, threshold)
%
%  Entrées :
%      Igray        — Image en niveaux de gris (2D)
%      window_size  — Taille du filtre de lissage (ex : 3, 5, 7)
%      k            — Paramètre de Harris (0.04 recommandé)
%      threshold    — Seuil de réponse normalisée (0.01 recommandé)
%
%  Sorties :
%      corners — Liste des coins détectés [x y]
%      R       — Carte de réponse de Harris
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Sécurisation de l'image
Igray = im2double(Igray);

if ndims(Igray) ~= 2
    error('Igray doit être une image 2D en niveaux de gris.');
end

%% Gradients (Sobel PRO)
% Plus stable que gradient() et cohérent avec ton module sobel_xy.m
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = sobel_x';

Gx = conv2(Igray, sobel_x, 'same');
Gy = conv2(Igray, sobel_y, 'same');

%% Tenseur de structure (filtré)
sigma = window_size / 3;   % règle empirique
w = fspecial('gaussian', window_size, sigma);

Ix2 = conv2(Gx.^2, w, 'same');
Iy2 = conv2(Gy.^2, w, 'same');
Ixy = conv2(Gx .* Gy, w, 'same');

%% Réponse de Harris
R = (Ix2 .* Iy2 - Ixy.^2) - k * (Ix2 + Iy2).^2;

%% Normalisation robuste
Rnorm = mat2gray(R);

%% Seuil
mask = Rnorm > threshold;

%% Non-max suppression (version robuste)
corners = [];
[rows, cols] = find(mask);

for i = 1:length(rows)
    r = rows(i);
    c = cols(i);

    % Fenêtre locale 3x3
    rmin = max(r-1, 1);
    rmax = min(r+1, size(R,1));
    cmin = max(c-1, 1);
    cmax = min(c+1, size(R,2));

    local = Rnorm(rmin:rmax, cmin:cmax);

    % Coin = maximum local strict
    if Rnorm(r,c) == max(local(:))
        corners = [corners; c r]; %#ok<AGROW>
    end
end

%% Filtrage final des coins faibles
if ~isempty(corners)
    % On garde uniquement les coins avec une réponse forte
    strong = R(sub2ind(size(R), corners(:,2), corners(:,1))) > threshold;
    corners = corners(strong, :);
end

%% Sécurisation finale
if any(isnan(R), 'all')
    warning('Réponse de Harris contient des NaN. Vérifie l’image d’entrée.');
end

end
