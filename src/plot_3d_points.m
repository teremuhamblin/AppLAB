function plot_3d_points(X)
% =========================================================================
%  PLOT_3D_POINTS — Visualisation 3D militaire-tech
% =========================================================================

figure('Name','3D Reconstruction');
plot3(X(:,1), X(:,2), X(:,3), 'b.', 'MarkerSize', 8);

grid on; axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Points reconstruits en 3D');
end
