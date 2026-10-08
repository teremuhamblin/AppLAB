###### ~/data/README.md >> markdown

![Dataset](https://img.shields.io/badge/Dataset-4_images-purple)
![Images](https://img.shields.io/badge/Images-JPEG-purple)

# 📦 Dossier ~/data/
- Images d’Exemple AppLAB

---

### 🔭 Présentation

Le *dossier ~/data/* contient les images d’exemple utilisées par le projet *AppLAB v2.0.0 pour tester les modules de `vision par ordinateur`*, la géométrie épipolaire et la reconstruction 3D.

### 🎯 Objectif :
- Fournir un jeu d’images minimaliste, reproductible, calibré pour les pipelines de Computer Vision nouvelle génération.

---

### 🧠 Contenu du Dataset

>{✔️ 1.jpg — Formes géométriques
- Image simple contenant des formes nettes : cercles, carrés, lignes, contrastes forts.  
- Modules concernés :  
  - ✔️ Conversion RGB → Gray  
  - ✔️ Sobel (X/Y/magnitude/orientation)  
  - ✔️ Détection de coins (Harris)

---

>>✔️ 2.jpg — Texture / Motifs
- Image avec motifs répétitifs : damier, briques, textures régulières.  
- Modules concernés :  
  - ✔️ Harris  
  - ✔️ Analyse de gradients  
  - ✔️ Détection de motifs répétitifs

---

>>✔️ 3.jpg — Scène naturelle
- Image d’une scène urbaine ou naturelle, riche en détails.  
- Modules concernés :  
  - ✔️ Extraction de points caractéristiques (SURF/SIFT)  
  - ✔️ Correspondances inter‑images  
  - ✔️ Analyse de features

---

>>✔️ 4.jpg — Scène stéréo (gauche/droite)
- Paire d’images stéréo cohérente pour la géométrie épipolaire.  
- Modules concernés :  
  - ✔️ RANSAC  
  - ✔️ Matrice fondamentale (8 points)  
  - ✔️ Triangulation 3D  
  - ✔️ Reprojection 3D → 2D

---

### 🧬 Utilisation dans le Pipeline AppLAB

```text
data/ → rgbtogray → sobelxy → harrisdetector
      → punktkorrespondenzen → Fransac → achtpunktalgorithmus
      → TRausE → rekonstruktion → rueckprojektion → résultats
```

🛡️ Dataset calibré pour les tests unitaires, la reproductibilité scientifique et les démonstrations GitHub Pages.

---

### 📝 Notes Importantes

- ✔️ Les images sont fournies en .jpg pour compatibilité totale MATLAB.  
- ✔️ Elles peuvent être remplacées par vos propres images (mêmes noms recommandés).  
- ✔️ Le dossier est chargé automatiquement par main.m.  
- ✔️ Dataset minimaliste → idéal pour CI/CD, tests rapides, reproductibilité.

---

### ⚔️ Signature Quantum‑Era

Dataset validé et maintenu par 98731 conforme aux standards AppLAB v2.0.0.  

###### Discipline, précision, efficacité.

---
