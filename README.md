###### README.md >> markdown 
# AppLAB
>Computer Vision en **MATLAB**

Ce projet regroupe des briques de base de vision par ordinateur en MATLAB :
```md
- Conversion RGB → niveau de gris
- Détection de coins (Harris)
- Gradients de Sobel
- Estimation de la matrice fondamentale (algorithme des 8 points)
- Estimation robuste par RANSAC
- Correspondances de points en stéréo
- Reconstruction 3D et reprojection
- Pose (R, T) à partir de la matrice essentielle
```

### Structure
- `main.m` : script principal de démonstration
- `src/` : fonctions MATLAB
- `data/` : images d'exemple

### Utilisation
Ouvrir MATLAB, se placer dans le dossier `AppLAB` puis lancer :
```matlab
main
```
