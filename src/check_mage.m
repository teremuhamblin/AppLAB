function check_image(I, name)
% =========================================================================
%  CHECK_IMAGE — Vérification robuste d'une image
% =========================================================================

if isempty(I)
    error("Image '%s' vide ou non chargée.", name);
end

if ndims(I) ~= 2 && ndims(I) ~= 3
    error("Image '%s' invalide : doit être 2D ou RGB.", name);
end

if any(isnan(I(:))) || any(isinf(I(:)))
    warning("Image '%s' contient des valeurs NaN ou Inf.", name);
end

end
