function x = rueckprojektion(P, X)
% =========================================================================
%  RUECKPROJEKTION — Reprojection de points 3D dans une image
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      x = rueckprojektion(P, X)
%
%  Entrées :
%      P — Matrice de projection (3x4)
%      X — Points 3D (N x 3)
%
%  Sortie :
%      x — Points projetés (N x 2)
%
%  Description :
%      Reprojection homogène robuste :
%        - Conversion des points 3D en homogène
%        - Projection via P
%        - Normalisation homogène
%        - Gestion des cas dégénérés
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Vérifications
if ~isequal(size(P), [3 4])
    error('La matrice de projection P doit être de taille 3x4.');
end

if size(X,2) ~= 3
    error('Les points 3D X doivent être de taille N x 3.');
end

N = size(X,1);

%% Conversion en coordonnées homogènes
Xh = [X, ones(N,1)];

%% Projection
xh = (P * Xh')';   % (N x 3)

%% Normalisation homogène robuste
w = xh(:,3);

% Gestion des cas dégénérés (w ≈ 0)
degenerate = abs(w) < eps;

if any(degenerate)
    warning('Certains points projetés ont w ≈ 0 (projection dégénérée).');
    w(degenerate) = eps;   % éviter division par zéro
end

x = xh(:,1:2) ./ w;

%% Sécurisation finale
if any(isnan(x), 'all') || any(isinf(x), 'all')
    warning('Reprojection instable. Vérifie les points 3D ou la matrice P.');
end

end
