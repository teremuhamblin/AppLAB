%% =========================================================================
%  AppLAB — Pipeline Avancé de Vision par Ordinateur
%  Version : v2.0.0 Quantum‑Era Edition
%  Auteur  : Teremu
%
%  Modules utilisés :
%    - rgb_to_gray.m
%    - sobel_xy.m
%    - harris_detector.m
%    - punkt_korrespondenzen.m
%    - F_ransac.m
%    - TR_aus_E.m
%    - rekonstruktion.m
%    - rueckprojektion.m
%
%  Description :
%    Pipeline complet incluant :
%      1) Prétraitement
%      2) Détection de coins
%      3) Extraction de correspondances (SURF)
%      4) Estimation de F (RANSAC)
%      5) Calcul de E
%      6) Décomposition en (R, t)
%      7) Reconstruction 3D
%      8) Reprojection
%      9) Visualisation 3D
%
%  Dépôt officiel : https://github.com/teremuhamblin/AppLAB
%% =========================================================================

clear; close all; clc;

fprintf("=== AppLAB v2.0.0 — Initialisation du pipeline avancé ===\n");

%% =========================================================================
% 0. Chargement des modules
%% =========================================================================
addpath('src');
dataDir = fullfile(pwd, 'data');

%% =========================================================================
% 1. Chargement des images
%% =========================================================================
img1 = fullfile(dataDir, 'soccer_4.jpg');
img2 = fullfile(dataDir, 'soccer_5.jpg');

if ~isfile(img1) || ~isfile(img2)
    error("Images introuvables. Place soccer_4.jpg et soccer_5.jpg dans /data.");
end

I1 = imread(img1);
I2 = imread(img2);

fprintf("[OK] Images chargées : soccer_4.jpg & soccer_5.jpg\n");

%% =========================================================================
% 2. Conversion en niveaux de gris
%% =========================================================================
G1 = rgb_to_gray(I1);
G2 = rgb_to_gray(I2);

fprintf("[OK] Conversion RGB → Gris\n");

%% =========================================================================
% 3. Détection de coins (Harris)
%% =========================================================================
[c1, ~] = harris_detector(G1, 3, 0.04, 0.01);
[c2, ~] = harris_detector(G2, 3, 0.04, 0.01);

fprintf("[OK] Coins Harris détectés : %d / %d\n", size(c1,1), size(c2,1));

%% =========================================================================
% 4. Extraction des correspondances (SURF)
%% =========================================================================
[x1, x2] = punkt_korrespondenzen(G1, G2);

fprintf("[OK] Correspondances SURF extraites : %d\n", size(x1,1));

%% =========================================================================
% 5. Estimation de la matrice fondamentale F (RANSAC)
%% =========================================================================
[F_best, inliers] = F_ransac(x1, x2, 1e-3, 2000);

fprintf("[OK] Matrice fondamentale estimée via RANSAC\n");
fprintf("     Inliers retenus : %d\n", length(inliers));

%% =========================================================================
% 6. Calcul de la matrice essentielle E
%% =========================================================================
K = [1000 0 320;
     0 1000 240;
     0    0   1];

E = K' * F_best * K;

fprintf("[OK] Matrice essentielle calculée\n");

%% =========================================================================
% 7. Décomposition de E → (R, t)
%% =========================================================================
[R1, R2, t] = TR_aus_E(E);

fprintf("[OK] Décomposition de E effectuée\n");

%% =========================================================================
% 8. Reconstruction 3D (Triangulation)
%% =========================================================================
P1 = K * [eye(3), zeros(3,1)];
P2 = K * [R1, t];

pts3D = rekonstruktion(P1, P2, x1(inliers,:), x2(inliers,:));

fprintf("[OK] Reconstruction 3D terminée : %d points\n", size(pts3D,1));

%% =========================================================================
% 9. Reprojection dans l'image 1
%% =========================================================================
proj1 = rueckprojektion(P1, pts3D);

fprintf("[OK] Reprojection effectuée\n");

%% =========================================================================
% 10. Visualisation 2D
%% =========================================================================
figure('Name','AppLAB - Reprojection');
imshow(I1); hold on;
plot(proj1(:,1), proj1(:,2), 'r.');
title('Reprojection des points 3D dans l’image 1');

%% =========================================================================
% 11. Visualisation 3D
%% =========================================================================
figure('Name','AppLAB - Reconstruction 3D');
plot3(pts3D(:,1), pts3D(:,2), pts3D(:,3), 'b.');
grid on; axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Points reconstruits en 3D');

fprintf("=== Pipeline avancé AppLAB exécuté avec succès ===\n");
fprintf("Pipeline complet opérationnel. Modules prêts pour CI/CD et extensions.\n");
