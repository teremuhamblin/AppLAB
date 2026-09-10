function F = achtpunktalgorithmus(x1, x2)
% ACHTPUNKTALGORITHMUS Algorithme des 8 points pour estimer la matrice fondamentale.
%
%   F = achtpunktalgorithmus(x1, x2)
%
%   x1, x2 : Nx2 points correspondants (en pixels)
%   F      : matrice fondamentale 3x3

if size(x1,1) < 8 || size(x2,1) < 8
    error('Il faut au moins 8 correspondances.');
end

% Normalisation simple (centrage + mise à l'échelle)
[x1n, T1] = normalize_points(x1);
[x2n, T2] = normalize_points(x2);

N = size(x1n,1);
A = zeros(N,9);

for i = 1:N
    X = x1n(i,1); Y = x1n(i,2);
    Xp = x2n(i,1); Yp = x2n(i,2);
    A(i,:) = [Xp*X, Xp*Y, Xp, Yp*X, Yp*Y, Yp, X, Y, 1];
end

[~,~,V] = svd(A);
f = V(:,end);
Fnorm = reshape(f, [3 3])';

% Contraindre F à rang 2
[U,S,V] = svd(Fnorm);
S(3,3) = 0;
Fnorm = U * S * V';

% Dé-normalisation
F = T2' * Fnorm * T1;
end

function [xn, T] = normalize_points(x)
% Normalisation isotropique des points 2D

centroid = mean(x,1);
x_shift = x - centroid;

mean_dist = mean(sqrt(sum(x_shift.^2,2)));
scale = sqrt(2) / mean_dist;

T = [scale 0      -scale*centroid(1);
     0     scale  -scale*centroid(2);
     0     0       1];

x_h = [x ones(size(x,1),1)];
xnh = (T * x_h')';
xn = xnh(:,1:2);
end
