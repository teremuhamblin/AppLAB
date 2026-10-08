function plot_points(I, pts, title_str)
% =========================================================================
%  PLOT_POINTS — Affichage militaire-tech de points 2D
% =========================================================================

figure('Name', title_str);
imshow(I); hold on;

plot(pts(:,1), pts(:,2), 'r+', 'MarkerSize', 6, 'LineWidth', 1.2);

title(title_str);
end
