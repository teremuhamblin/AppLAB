function X = rekonstruktion(P1, P2, x1, x2)
% REKONSTRUKTION Triangulation de points 3D à partir de deux vues.
%
%   X = rekonstruktion(P1, P2, x1, x2)
%
%   P1, P2 : matrices de projection 3x4
%   x1, x2 : Nx2 points correspondants
%   X      : Nx3 points 3D

N = size(x1,1);
X = zeros(N,3);

for i = 1:N
    A = [ x1(i,1)*P1(3,:) - P1(1,:);
          x1(i,2)*P1(3,:) - P1(2,:);
          x2(i,1)*P2(3,:) - P2(1,:);
          x2(i,2)*P2(3,:) - P2(2,:) ];

    [~,~,V] = svd(A);
    Xh = V(:,end);
    X(i,:) = Xh(1:3)' / Xh(4);
end
end
