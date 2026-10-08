###### ~/docs/architecture.md >> markdown

---

### ⚔️ Détails des sections (Quantum‑Era Doctrine)

>>1. src/ — Modules opérationnels
Le cœur du pipeline MATLAB, organisé par rôle :

- Pré‑processing : rgbtogray.m, sobel_xy.m
- Détection : harris_detector.m
- Matching : punkt_korrespondenzen.m, SURF intégré
- Géométrie épipolaire : achtpunktalgorithmus.m, Fransac.m, TRaus_E.m
- Reconstruction 3D : rekonstruktion.m, rueckprojektion.m
- Modules utilitaires Quantum‑Era :
  - info_applab.m
  - check_image.m
  - check_points.m
  - plot_points.m
  - plotepipolarlines.m
  - plot3dpoints.m

---

>>2. data/ — Données d’entrée
Images d’entraînement / test :

- soccer_4.jpg
- soccer_5.jpg

---

>>3. docs/ — Documentation militaire
Documentation professionnelle :

- AppLAB.md — présentation du framework
- pipeline.md — pipeline complet (Harris → SURF → RANSAC → F → E → 3D)
- architecture.md — architecture interne
- modules/ — documentation par module
- assets/diagrams/ — schémas ASCII (compatibles GitHub)

---

>>4. .github/ — Infrastructure GitHub Enterprise

Workflows CI/CD :
- matlab_ci.yml — tests MATLAB automatisés
- security.yml — scans de sécurité
- pages.yml — déploiement GitHub Pages

Gouvernance :
- CODEOWNERS
- ISSUE_TEMPLATE.md
- PULLREQUESTTEMPLATE.md
- dependabot.yml
- FUNDING.yml

---

>>5. Fichiers racine
- README.md — version Quantum‑Era
- SECURITY.md — doctrine Zero‑Trust
- CONTRIBUTING.md — règles d’engagement
- ROADMAP.md — vision v2.0.0 → v3.0.0
- CHANGELOG.md — historique militaire
- VERSION — version actuelle
- LICENSE — MIT ou autre
- .gitignore — MATLAB + GitHub

---

### 🧨 Ton dépôt va passer de “laboratoire brut” à “framework militaire de vision par ordinateur”

Tu vas obtenir :

- une architecture propre, scalable, professionnelle
- une documentation lisible, modulaire, GitHub‑friendly
- une CI/CD automatisée
- une gouvernance Enterprise‑grade
- un pipeline MATLAB structuré, documenté, maintenable

---
