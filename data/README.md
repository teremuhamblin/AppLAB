###### README.md >> markdown

![Dataset](https://img.shields.io/badge/Dataset-4_images-blue)
![Images](https://img.shields.io/badge/Images-JPEG-purple)

# Dossier `data/`
- Images d'exemple AppLAB

Ce dossier contient les informations images utilisées par le projet **AppLAB** pour tester les modules de vision par ordinateur.

### Contenu

### 1.jpg
- Formes géométriques :
   - Image simple contenant des formes nettes (cercles, carrés, lignes).
   - Utilisée pour : conversion en niveaux de gris, Sobel, Harris.

### 2.jpg
- Texture / motifs :
   - Image avec motifs répétitifs (damier, briques).
   - Utilisée pour : détection de coins, analyse de gradients.

### 3.jpg
- Scène naturelle :
   - Image d'une scène urbaine ou naturelle.
   - Utilisée pour : extraction de points caractéristiques (SURF), correspondances.

### 4.jpg
- Scène stéréo :
   - Paire d’images gauche/droite pour la géométrie épipolaire.
   - Utilisée pour : RANSAC, matrice fondamentale, triangulation 3D, reprojection.

### Notes
- Les images sont fournies en `.jpg` pour compatibilité MATLAB.
- Elles peuvent être remplacées par vos propres images selon vos besoins.
- Le dossier est utilisé automatiquement par `main.m`.
