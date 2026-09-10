###### README.md >> markdown 
# AppLAB

[![MATLAB CI](https://github.com/teremuhamblin/AppLAB/actions/workflows/matlab-ci.yml/badge.svg)](https://github.com/teremuhamblin/AppLAB/actions/workflows/matlab-ci.yml)

>Computer Vision en **MATLAB**

Ce projet regroupe des briques de base de vision par ordinateur en MATLAB :

[![Lint MATLAB Code](https://github.com/teremuhamblin/AppLAB/actions/workflows/lint.yml/badge.svg)](https://github.com/teremuhamblin/AppLAB/actions/workflows/lint.yml)

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

[![Build Docs](https://github.com/teremuhamblin/AppLAB/actions/workflows/docs.yml/badge.svg)](https://github.com/teremuhamblin/AppLAB/actions/workflows/docs.yml)

- Fonctions
   - `main.m` : script principal de démonstration
   - `src/` : fonctions MATLAB
   - `data/` : images d'exemple

- Architecture :
```text
AppLAB/
├─ README.md
├─ .gitignore
├─ main.m
├─ .github/
│  ├─ workflows/
│  ├─ .gitkeep
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
