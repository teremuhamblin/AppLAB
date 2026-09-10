function [R1, R2, t] = TR_aus_E(E)
% TR_AUS_E Décomposition de la matrice essentielle en R et t.
%
%   [R1, R2, t] = TR_aus_E(E)
%
%   E : matrice essentielle 3x3
%   R1, R2 : deux rotations possibles
%   t      : vecteur de translation (direction)

[U,~,V] = svd(E);

if det(U) < 0, U(:,3) = -U(:,3); end
if det(V) < 0, V(:,3) = -V(:,3); end

W = [0 -1 0;
     1  0 0;
     0  0 1];

R1 = U * W  * V';
R2 = U * W' * V';
t  = U(:,3);

% S'assurer que les rotations sont valides
if det(R1) < 0, R1 = -R1; end
if det(R2) < 0, R2 = -R2; end
end
