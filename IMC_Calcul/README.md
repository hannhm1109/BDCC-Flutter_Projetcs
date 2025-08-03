# 📲 App Mobile – Calculateur d'IMC Android

Une application mobile native qui détermine l'**Indice de Masse Corporelle (IMC)** en fonction des données corporelles de l'utilisateur. L'app fournit une évaluation complète incluant le **score IMC** et la **classification sanitaire** avec support visuel.

---

## 🎯 Caractéristiques principales

- Saisie du **poids corporel (kg)**
- Renseignement de la **hauteur (cm)**
- Computation instantanée basée sur la formule standard :

  \[
  \text{IMC} = \frac{\text{Masse (kg)}}{\left(\frac{\text{Hauteur (cm)}}{100}\right)^2}
  \]

- Présentation du **score IMC arrondi** à **deux chiffres après la virgule**
- Interface enrichie avec :
  - **Illustration visuelle** adaptée à chaque tranche d'IMC
  - **Libellé descriptif** de la catégorie (ex: Insuffisance pondérale, Corpulence normale, Excès de poids...)

---

## 📋 Classifications d'IMC reconnues

| Classification            | Plage IMC      |
|---------------------------|----------------|
| Insuffisance pondérale    | < 18.5         |
| Corpulence normale        | 18.5 – 24.9    |
| Excès de poids            | 25 – 29.9      |
| Obésité                   | ≥ 30           |

---

## 🔧 Stack technique

- **Framework** : Java natif Android
- **Environnement** : Android Studio
- **Interface** : Mise en page XML utilisant `ConstraintLayout` et `LinearLayout`
- **Compatibilité** : API niveau 21+ (Android 5.0 Lollipop et versions ultérieures)