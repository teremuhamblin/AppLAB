function check_points(x1, x2)
% =========================================================================
%  CHECK_POINTS — Vérification des correspondances 2D
% =========================================================================

if size(x1,1) ~= size(x2,1)
    error("x1 et x2 doivent avoir le même nombre de points.");
end

if size(x1,2) ~= 2 || size(x2,2) ~= 2
    error("Les points doivent être de taille N x 2.");
end

if size(x1,1) < 8
    warning("Moins de 8 correspondances : estimation de F impossible.");
end

end
