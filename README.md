###### README.md >> markdown 
# AppLAB
![Version](https://img.shields.io/badge/AppLAB-v1.0.0-blue)
![MATLAB](https://img.shields.io/badge/MATLAB-R2026a-blue?logo=mathworks)
![Status](https://img.shields.io/badge/Status-Stable-success)

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

![Dependabot Status](https://img.shields.io/badge/Dependabot-AutoUpdate-blue?logo=dependabot)

Ouvrir MATLAB, se placer dans le dossier `AppLAB` puis lancer :
```matlab
main
```
