function [R1, R2, t] = TR_aus_E(E)
% =========================================================================
%  TR_AUS_E — Décomposition de la matrice essentielle en rotations et translation
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      [R1, R2, t] = TR_aus_E(E)
%
%  Entrée :
%      E — Matrice essentielle (3x3)
%
%  Sorties :
%      R1, R2 — Deux rotations possibles (SO(3))
%      t      — Direction de translation (vecteur unitaire)
%
%  Description :
%      Décomposition standard de la matrice essentielle via SVD.
%      Produit les deux solutions possibles pour la rotation et la direction
%      de translation. Compatible avec les pipelines de reconstruction 3D.
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Vérification de la matrice essentielle
if ~isequal(size(E), [3 3])
    error('La matrice essentielle E doit être de taille 3x3.');
end

%% Décomposition SVD
[U, S, V] = svd(E);

% Sécurisation : correction des inversions de U et V
if det(U) < 0
    U(:,3) = -U(:,3);
end
if det(V) < 0
    V(:,3) = -V(:,3);
end

%% Matrice W (rotation de 90° autour de Z)
W = [0 -1  0;
     1  0  0;
     0  0  1];

%% Calcul des deux rotations possibles
R1 = U * W  * V';
R2 = U * W' * V';

%% Correction pour garantir des rotations valides (SO(3))
if det(R1) < 0
    R1 = -R1;
end
if det(R2) < 0
    R2 = -R2;
end

%% Direction de translation
t = U(:,3);

% Normalisation pour stabilité numérique
t = t / norm(t);

%% Sécurisation finale
if any(isnan(R1), 'all') || any(isnan(R2), 'all') || any(isnan(t))
    warning('Décomposition de E instable. Vérifie la matrice essentielle.');
end

end
