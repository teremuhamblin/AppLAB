---

### main.m

```matlab
% main.m – Script principal AppLAB

clear; close all; clc;

addpath('src');
dataDir = fullfile(pwd, 'data');

% Charger une image d'exemple
imgPath = fullfile(dataDir, 'soccer_4.jpg');
if ~isfile(imgPath)
    error('Image %s introuvable. Place les images dans le dossier data.', imgPath);
end

I = imread(imgPath);

% 1) Conversion en niveaux de gris
Igray = rgb_to_gray(I);

figure; imshow(Igray); title('Image en niveaux de gris');

% 2) Gradients de Sobel
[Gx, Gy, Gmag, Gdir] = sobel_xy(Igray);

figure;
subplot(2,2,1); imshow(mat2gray(Gx)); title('Gradient X');
subplot(2,2,2); imshow(mat2gray(Gy)); title('Gradient Y');
subplot(2,2,3); imshow(mat2gray(Gmag)); title('Magnitude');
subplot(2,2,4); imshow(Gdir, []); title('Direction');

% 3) Détection de coins de Harris
window_size = 3;
k = 0.04;
threshold = 0.01;
[corners, R] = harris_detector(Igray, window_size, k, threshold);

figure; imshow(Igray); hold on;
plot(corners(:,1), corners(:,2), 'r+');
title('Coins de Harris');

disp('Pipeline de base exécuté. Les fonctions F, RANSAC, reconstruction, etc. sont prêtes à être utilisées dans tes propres scripts.');
