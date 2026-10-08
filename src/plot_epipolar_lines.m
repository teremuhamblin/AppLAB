function plot_epipolar_lines(F, pts, I)
% =========================================================================
%  PLOT_EPIPOLAR_LINES — Tracé des droites épipolaires
% =========================================================================

figure('Name','Epipolar Lines');
imshow(I); hold on;

for i = 1:size(pts,1)
    x = [pts(i,:) 1]';
    l = F * x;   % droite épipolaire

    % l = [a b c] → ax + by + c = 0
    a = l(1); b = l(2); c = l(3);

    % Calcul des intersections avec les bords
    x0 = 1;
    y0 = -(a*x0 + c)/b;

    x1 = size(I,2);
    y1 = -(a*x1 + c)/b;

    plot([x0 x1], [y0 y1], 'g-', 'LineWidth', 1.2);
end

title('Droites épipolaires');
end
