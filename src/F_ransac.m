function [F_best, inliers_best] = F_ransac(x1, x2, threshold, iterations)
% =========================================================================
%  F_RANSAC — Estimation robuste de la matrice fondamentale via RANSAC
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      [F_best, inliers_best] = F_ransac(x1, x2, threshold, iterations)
%
%  Entrées :
%      x1, x2      — Correspondances (N x 2)
%      threshold   — Seuil d'inlier (par défaut : 1e-3)
%      iterations  — Nombre d'itérations RANSAC (par défaut : 1000)
%
%  Sorties :
%      F_best       — Meilleure matrice fondamentale estimée
%      inliers_best — Indices des inliers associés
%
%  Description :
%      Implémentation robuste de RANSAC pour estimer la matrice fondamentale.
%      Utilise l'algorithme des 8 points pour chaque échantillon minimal.
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Paramètres par défaut
if nargin < 3, threshold = 1e-3; end
if nargin < 4, iterations = 1000; end

%% Vérifications
N = size(x1, 1);
if N ~= size(x2, 1)
    error('x1 et x2 doivent contenir le même nombre de correspondances.');
end
if N < 8
    error('Il faut au moins 8 correspondances pour estimer F.');
end

%% Initialisation
F_best = [];
inliers_best = [];
best_count = 0;

% Homogénéisation des points (optimisation : hors boucle)
x1h = [x1, ones(N,1)];
x2h = [x2, ones(N,1)];

%% Boucle RANSAC
for it = 1:iterations

    % ---------------------------------------------------------
    % 1. Sélection aléatoire de 8 correspondances
    % ---------------------------------------------------------
    idx = randperm(N, 8);

    % ---------------------------------------------------------
    % 2. Estimation de F via l'algorithme des 8 points
    % ---------------------------------------------------------
    F = achtpunktalgorithmus(x1(idx,:), x2(idx,:));

    % Sécurisation : ignorer les F dégénérées
    if any(isnan(F), 'all') || any(isinf(F), 'all')
        continue;
    end

    % ---------------------------------------------------------
    % 3. Calcul de l'erreur géométrique (distance épipolaire)
    % ---------------------------------------------------------
    % Droites épipolaires dans l'image 2
    l2 = (F * x1h')';   % (N x 3)

    % Erreur : distance point-ligne
    num = abs(sum(l2 .* x2h, 2));
    den = sqrt(l2(:,1).^2 + l2(:,2).^2) + eps;  % eps pour stabilité
    d = num ./ den;

    % ---------------------------------------------------------
    % 4. Sélection des inliers
    % ---------------------------------------------------------
    inliers = find(d < threshold);
    count = numel(inliers);

    % ---------------------------------------------------------
    % 5. Mise à jour du meilleur modèle
    % ---------------------------------------------------------
    if count > best_count
        best_count = count;
        F_best = F;
        inliers_best = inliers;
    end
end

%% Sécurisation finale
if isempty(F_best)
    warning('RANSAC n’a trouvé aucun modèle valide. Vérifie les correspondances.');
    F_best = zeros(3);
    inliers_best = [];
end

end
