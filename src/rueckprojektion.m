function x = rueckprojektion(P, X)
% RUECKPROJEKTION Reprojection de points 3D dans une image.
%
%   x = rueckprojektion(P, X)
%
%   P : matrice de projection 3x4
%   X : Nx3 points 3D
%   x : Nx2 points projetés

N = size(X,1);
Xh = [X ones(N,1)];
xh = (P * Xh')';
x = xh(:,1:2) ./ xh(:,3);
end
