# Application Flutter Tic Tac Toe avec Authentification - BDCC

Une application mobile Flutter développée dans le cadre du cursus BDCC, combinant authentification utilisateur et jeu de morpion. Ce projet illustre les concepts de navigation, persistance de données et logique de jeu en Flutter.

## Fonctionnalités implémentées

- Système d'authentification complet avec écrans de connexion et d'inscription
- Stockage local des identifiants via `SharedPreferences`
- Maintien de la session utilisateur entre les lancements
- Fonctionnalité de déconnexion depuis l'écran de jeu
- Logique complète du jeu Tic Tac Toe avec détection de victoire et d'égalité
- Boîtes de dialogue pour afficher les résultats de partie

## Captures d'écran

<table>!
   <tr>
     <td><img src="screenshots/Screenshot 2025-08-02 184143.png" width="200"/></td>
     <td><img src="screenshots/Screenshot 2025-08-02 184224.png" width="200"/></td>
     <td><img src="screenshots/Screenshot 2025-08-02 184240.png" width="200"/></td>
     <td><img src="screenshots/Screenshot 2025-08-02 184320.png" width="200"/></td>
   </tr>
</table>

## Installation et lancement

1. Cloner le dépôt
   ```bash
   git clone https://github.com/hananenhm1109/flutter_nav_data.git
   cd flutter_nav_data
   ```

2. Installer les dépendances
   ```bash
   flutter pub get
   ```

3. Lancer l'application
   ```bash
   flutter run
   ```

> Configuration recommandée : Émulateur ou appareil physique avec Android SDK 34+

## Architecture du projet

```
lib/
├── main.dart
├── screen/
    ├── login.screen.dart
    ├── signup.screen.dart
    └── tictactoe.screen.dart
```

## Technologies utilisées

- Flutter SDK
- Dart
- SharedPreferences pour la persistance locale
- Material Design pour l'interface utilisateur

## Auteur

**Hanane Nahim**