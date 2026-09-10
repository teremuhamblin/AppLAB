function [F_best, inliers_best] = F_ransac(x1, x2, threshold, iterations)
% F_RANSAC Estimation robuste de la matrice fondamentale par RANSAC.
%
%   [F_best, inliers_best] = F_ransac(x1, x2, threshold, iterations)

if nargin < 3, threshold = 1e-3; end
if nargin < 4, iterations = 1000; end

N = size(x1,1);
if N < 8
    error('Il faut au moins 8 correspondances.');
end

F_best = [];
inliers_best = [];
best_count = 0;

for it = 1:iterations
    idx = randperm(N, 8);
    F = achtpunktalgorithmus(x1(idx,:), x2(idx,:));

    % Erreur géométrique simple
    x1h = [x1 ones(N,1)];
    x2h = [x2 ones(N,1)];

    l2 = (F * x1h')';      % droites dans image 2
    num = abs(sum(l2 .* x2h,2));
    den = sqrt(l2(:,1).^2 + l2(:,2).^2);
    d = num ./ den;

    inliers = find(d < threshold);
    count = numel(inliers);

    if count > best_count
        best_count = count;
        F_best = F;
        inliers_best = inliers;
    end
end
end
