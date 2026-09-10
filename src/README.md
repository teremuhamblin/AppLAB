###### README.md >> markdown
- Dossier src/ du projet `AppLAB`.  
Il présente chaque module, son rôle, et la logique générale du dossier.

---

### 📁 Dossier src/
>src/ — ` *Modules MATLAB* **AppLAB** `
- Le dossier `src/` contient l’ensemble des fonctions *MATLAB* utilisées par le projet AppLAB, un ensemble pédagogique et `pratique dédié aux bases de la vision par ordinateur`
- Chaque fichier .m correspond à un module indépendant, réutilisable dans vos propres scripts ou dans main.m.

---

### 📦 Contenu des modules
### 1. **rgbtogray.m**
Convertit une image couleur RGB en niveaux de gris selon une pondération standard.
- Entrée : image RGB ou mono‑canal  
- Sortie : image en niveaux de gris normalisée

---

### 2. **sobel_xy.m**
Calcule les gradients de Sobel en X et Y.
- Sorties : Gx, Gy, Gmag (magnitude), Gdir (direction)
- Utilisé pour l’extraction de contours et la détection de variations d’intensité

---

### 3. **harris_detector.m**
Implémente le détecteur de coins de Harris.
- Entrée : image en niveaux de gris  
- Sortie : liste des coins détectés + carte de réponse Harris  
- Inclut un filtrage gaussien et une suppression des non‑maxima

---

### 4. **achtpunktalgorithmus.m**
Algorithme des 8 points pour estimer la matrice fondamentale F.
- Normalisation des points  
- Construction de la matrice A  
- SVD + contrainte de rang 2  
- Dé‑normalisation finale

---

### 5. **F_ransac.m**
Estimation robuste de la matrice fondamentale via RANSAC.
- Sélection aléatoire de 8 correspondances  
- Calcul de F  
- Mesure d’erreur géométrique  
- Sélection des inliers  
- Retourne : F_best + indices des inliers

---

### 6. **punkt_korrespondenzen.m**
Extraction automatique de correspondances entre deux images.
- Utilise SURF (détection + description)  
- Appariement des descripteurs  
- Sorties : x1, x2 (points correspondants)

---

### 7. **rekonstruktion.m**
Triangulation 3D à partir de deux vues.
- Entrées : matrices de projection P1, P2 + correspondances  
- Sortie : points 3D reconstruits dans le repère caméra

---

### 8. **rueckprojektion.m**
Reprojection de points 3D dans une image.
- Entrée : matrice de projection + points 3D  
- Sortie : coordonnées 2D projetées

---

### 9. **TR_aus_E.m**
Décomposition de la matrice essentielle E.
- Sorties : deux rotations possibles (R1, R2)  
- Une direction de translation t  
- Utilisé pour la reconstruction stéréo et la pose relative

---

### 🎯 Objectif du dossier
Ce dossier regroupe les briques fondamentales nécessaires pour :
- la détection de caractéristiques,
- l’estimation de géométrie épipolaire,
- la reconstruction 3D,
- la reprojection,
- la manipulation de matrices essentielles et fondamentales.

>Il constitue la base du pipeline AppLAB, utilisé dans main.m.

---

### 📘 Utilisation
1. Dans MATLAB :
```matlab
addpath('src');
```

2. Puis appeler les fonctions selon vos besoins :
```matlab
Igray = rgbtogray(I);
[corners, R] = harris_detector(Igray, 3, 0.04, 0.01);
[F, inliers] = F_ransac(x1, x2, 1e-3, 1000);
```

---

### 🛠️ Notes
- Toutes les fonctions sont autonomes et peuvent être utilisées dans d’autres projets.
- Les modules respectent une structure simple, lisible et pédagogique.
- Le dossier src/ est conçu pour être compatible avec MATLAB R2018+.

---
