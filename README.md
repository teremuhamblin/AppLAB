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

### Structure :
- Fonctions
   - `main.m` : script principal de démonstration
   - `src/` : fonctions MATLAB
   - `data/` : images d'exemple

- Architecture :
```text
AppLAB/
├─ README.md
├─ main.m
├─ src/
│  ├─ rgb_to_gray.m
│  ├─ sobel_xy.m
│  ├─ harris_detector.m
│  ├─ achtpunktalgorithmus.m
│  ├─ F_ransac.m
│  ├─ punkt_korrespondenzen.m
│  ├─ rekonstruktion.m
│  ├─ rueckprojektion.m
│  ├─ TR_aus_E.m
└─ data/
   ├─ 1.jpg
   ├─ 2.jpg
   ├─ 3.jpg
   └─ 4.jpg
```

### Utilisation
Ouvrir MATLAB, se placer dans le dossier `AppLAB` puis lancer :
```matlab
main
```
