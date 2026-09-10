function [x1, x2] = punkt_korrespondenzen(I1, I2)
% PUNKT_KORRESPONDENZEN Exemple de génération de correspondances de points.
%
%   [x1, x2] = punkt_korrespondenzen(I1, I2)
%
%   Ici, on utilise des features SURF pour obtenir des correspondances automatiques.

I1g = rgb_to_gray(I1);
I2g = rgb_to_gray(I2);

points1 = detectSURFFeatures(I1g);
points2 = detectSURFFeatures(I2g);

[features1, validPoints1] = extractFeatures(I1g, points1);
[features2, validPoints2] = extractFeatures(I2g, points2);

indexPairs = matchFeatures(features1, features2);

matchedPoints1 = validPoints1(indexPairs(:,1));
matchedPoints2 = validPoints2(indexPairs(:,2));

x1 = matchedPoints1.Location;
x2 = matchedPoints2.Location;
end
