%% =========================================================================
%  AppLAB — Script Principal
%  Version : v1.1.0
%  Auteur  : Teremu
%
%  Description :
%     Pipeline de base pour démontrer les modules fondamentaux :
%       1) Conversion RGB → Gris
%       2) Gradients de Sobel
%       3) Détection de coins (Harris)
%
%     Les modules avancés (F, RANSAC, reconstruction 3D, etc.)
%     sont prêts à être intégrés dans un pipeline complet.
%
%  Dépôt officiel : https://github.com/teremuhamblin/AppLAB
%% =========================================================================

clear; close all; clc;

fprintf("=== AppLAB v1.1.0 — Initialisation ===\n");

%% =========================================================================
% 0. Chargement des modules
%% =========================================================================
addpath('src');
dataDir = fullfile(pwd, 'data');

%% =========================================================================
% 1. Chargement de l'image
%% =========================================================================
imgName = 'soccer_4.jpg';
imgPath = fullfile(dataDir, imgName);

if ~isfile(imgPath)
    error('Image introuvable : %s\nPlace les images dans le dossier /data.', imgPath);
end

I = imread(imgPath);
fprintf("[OK] Image chargée : %s\n", imgName);

%% =========================================================================
% 2. Conversion en niveaux de gris
%% =========================================================================
Igray = rgb_to_gray(I);

figure('Name','AppLAB - Niveaux de gris');
imshow(Igray);
title('Image en niveaux de gris');

fprintf("[OK] Conversion RGB → Gris\n");

%% =========================================================================
% 3. Gradients de Sobel
%% =========================================================================
[Gx, Gy, Gmag, Gdir] = sobel_xy(Igray);

figure('Name','AppLAB - Sobel');
subplot(2,2,1); imshow(mat2gray(Gx)); title('Gradient X');
subplot(2,2,2); imshow(mat2gray(Gy)); title('Gradient Y');
subplot(2,2,3); imshow(mat2gray(Gmag)); title('Magnitude');
subplot(2,2,4); imshow(Gdir, []); title('Direction');

fprintf("[OK] Gradients de Sobel calculés\n");

%% =========================================================================
% 4. Détection de coins (Harris)
%% =========================================================================
window_size = 3;
k = 0.04;
threshold = 0.01;

[corners, R] = harris_detector(Igray, window_size, k, threshold);

figure('Name','AppLAB - Harris');
imshow(Igray); hold on;
plot(corners(:,1), corners(:,2), 'r+');
title('Coins détectés (Harris)');

fprintf("[OK] Détection de coins Harris (%d coins)\n", size(corners,1));

%% =========================================================================
% 5. Fin du pipeline de démonstration
%% =========================================================================
fprintf("=== Pipeline de base exécuté avec succès ===\n");
fprintf("Modules avancés disponibles : F, RANSAC, correspondances, reconstruction 3D.\n");
fprintf("Intègre-les dans ton pipeline complet selon tes besoins.\n");
