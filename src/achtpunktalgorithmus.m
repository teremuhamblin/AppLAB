function F = achtpunktalgorithmus(x1, x2)
% =========================================================================
%  ACHTPUNKTALGORITHMUS — Algorithme des 8 points (version robuste)
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      F = achtpunktalgorithmus(x1, x2)
%
%  Entrées :
%      x1, x2 — Correspondances (N x 2)
%
%  Sortie :
%      F — Matrice fondamentale (3x3)
%
%  Description :
%      Implémentation robuste de l’algorithme des 8 points incluant :
%        - Normalisation isotropique (Hartley)
%        - Construction vectorisée de la matrice A
%        - Contrainte de rang 2
%        - Dé-normalisation stable
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Vérifications
if size(x1,1) < 8 || size(x2,1) < 8
    error('Il faut au moins 8 correspondances pour estimer F.');
end
if size(x1,1) ~= size(x2,1)
    error('x1 et x2 doivent avoir le même nombre de points.');
end

%% Normalisation des points (Hartley)
[x1n, T1] = normalize_points(x1);
[x2n, T2] = normalize_points(x2);

N = size(x1n,1);

%% Construction vectorisée de la matrice A
X  = x1n(:,1);
Y  = x1n(:,2);
Xp = x2n(:,1);
Yp = x2n(:,2);

A = [Xp.*X, Xp.*Y, Xp, ...
     Yp.*X, Yp.*Y, Yp, ...
     X,     Y,     ones(N,1)];

%% SVD de A
[~,~,V] = svd(A);

% Dernière colonne de V = solution du système
f = V(:,end);
Fnorm = reshape(f, [3 3])';

%% Contrainte de rang 2
[U,S,V] = svd(Fnorm);
S(3,3) = 0;          % suppression du plus petit singulier
Fnorm = U * S * V';

%% Dé-normalisation
F = T2' * Fnorm * T1;

%% Normalisation finale pour stabilité
F = F ./ norm(F);

%% Sécurisation
if any(isnan(F), 'all') || any(isinf(F), 'all')
    warning('Matrice fondamentale instable. Vérifie les correspondances.');
end

end

% =========================================================================
%  Normalisation isotropique des points (Hartley)
% =========================================================================
function [xn, T] = normalize_points(x)

centroid = mean(x,1);
x_shift = x - centroid;

mean_dist = mean(sqrt(sum(x_shift.^2,2)));
scale = sqrt(2) / (mean_dist + eps);

T = [scale 0      -scale*centroid(1);
     0     scale  -scale*centroid(2);
     0     0       1];

x_h = [x, ones(size(x,1),1)];
xnh = (T * x_h')';
xn = xnh(:,1:2);

end
