function [x1, x2] = punkt_korrespondenzen(I1, I2)
% =========================================================================
%  PUNKT_KORRESPONDENZEN — Extraction robuste de correspondances SURF
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      [x1, x2] = punkt_korrespondenzen(I1, I2)
%
%  Entrées :
%      I1, I2 — Images RGB ou grayscale
%
%  Sorties :
%      x1, x2 — Points correspondants (N x 2)
%
%  Description :
%      Extraction automatique de correspondances via :
%        - SURF Features
%        - Ratio test (Lowe)
%        - Filtrage des correspondances aberrantes
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Conversion en niveaux de gris (robuste)
if size(I1,3) == 3
    I1g = rgb_to_gray(I1);
else
    I1g = im2double(I1);
end

if size(I2,3) == 3
    I2g = rgb_to_gray(I2);
else
    I2g = im2double(I2);
end

%% Détection des points SURF
points1 = detectSURFFeatures(I1g, 'MetricThreshold', 500);
points2 = detectSURFFeatures(I2g, 'MetricThreshold', 500);

%% Extraction des descripteurs
[features1, validPoints1] = extractFeatures(I1g, points1);
[features2, validPoints2] = extractFeatures(I2g, points2);

%% Matching avec ratio test (Lowe)
indexPairs = matchFeatures(features1, features2, ...
    'MatchThreshold', 60, ...       % seuil de distance
    'MaxRatio', 0.7, ...            % ratio test
    'Unique', true);                % correspondances uniques

%% Récupération des points correspondants
matchedPoints1 = validPoints1(indexPairs(:,1));
matchedPoints2 = validPoints2(indexPairs(:,2));

x1 = matchedPoints1.Location;
x2 = matchedPoints2.Location;

%% Filtrage des correspondances aberrantes
if ~isempty(x1)
    % Distance moyenne
    d = sqrt(sum((x1 - x2).^2, 2));
    med = median(d);

    % On garde les correspondances raisonnables
    keep = d < (3 * med + eps);
    x1 = x1(keep, :);
    x2 = x2(keep, :);
end

%% Sécurisation finale
if size(x1,1) < 8
    warning('Moins de 8 correspondances valides. Reconstruction impossible.');
end

end
