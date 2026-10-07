function X = rekonstruktion(P1, P2, x1, x2)
% =========================================================================
%  REKONSTRUKTION — Triangulation linéaire de points 3D (DLT)
%  Version : Quantum‑Era Edition
%
%  Syntaxe :
%      X = rekonstruktion(P1, P2, x1, x2)
%
%  Entrées :
%      P1, P2 — Matrices de projection (3x4)
%      x1, x2 — Points correspondants (N x 2)
%
%  Sortie :
%      X — Points 3D reconstruits (N x 3)
%
%  Description :
%      Triangulation linéaire robuste via DLT :
%        - Construction de la matrice A pour chaque correspondance
%        - Résolution par SVD
%        - Normalisation homogène
%
%  Auteur :
%      Teremu — AppLAB / Quantum‑Era Division
% =========================================================================

%% Vérifications
if ~isequal(size(P1), [3 4]) || ~isequal(size(P2), [3 4])
    error('P1 et P2 doivent être des matrices de projection 3x4.');
end

if size(x1,1) ~= size(x2,1)
    error('x1 et x2 doivent contenir le même nombre de points.');
end

N = size(x1,1);
X = zeros(N,3);

%% Triangulation point par point (DLT)
for i = 1:N

    % ---------------------------------------------------------
    % 1. Construction de la matrice A (DLT)
    % ---------------------------------------------------------
    A = [ x1(i,1)*P1(3,:) - P1(1,:);
          x1(i,2)*P1(3,:) - P1(2,:);
          x2(i,1)*P2(3,:) - P2(1,:);
          x2(i,2)*P2(3,:) - P2(2,:) ];

    % ---------------------------------------------------------
    % 2. Résolution par SVD
    % ---------------------------------------------------------
    [~,~,V] = svd(A);

    % Dernière colonne = solution homogène
    Xh = V(:,end);

    % ---------------------------------------------------------
    % 3. Normalisation homogène
    % ---------------------------------------------------------
    if abs(Xh(4)) < eps
        % Cas dégénéré : on évite la division par zéro
        X(i,:) = [NaN NaN NaN];
    else
        X(i,:) = (Xh(1:3) ./ Xh(4))';
    end
end

%% Sécurisation finale
if any(isnan(X), 'all')
    warning('Certains points 3D sont NaN. Vérifie les correspondances ou les matrices de projection.');
end

end
