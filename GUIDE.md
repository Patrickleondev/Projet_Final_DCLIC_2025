# Guide d'Installation et d'Utilisation - NoteZone

## Table des matières
1. [Introduction](#introduction)
2. [Prérequis](#prérequis)
3. [Installation](#installation)
4. [Configuration](#configuration)
5. [Utilisation](#utilisation)
6. [Fonctionnalités](#fonctionnalités)
7. [Dépannage](#dépannage)

## Introduction
NoteZone est une application mobile de prise de notes sécurisée développée avec Flutter. Elle permet aux utilisateurs de créer, organiser et gérer leurs notes de manière efficace et sécurisée.

## Prérequis
- Flutter SDK (version 3.7.2 ou supérieure)
- Dart SDK
- Un IDE (Android Studio, VS Code)
- Git
- Un émulateur Android/iOS ou un appareil physique pour les tests

## Installation

### 1. Cloner le projet
```bash
git clone https://github.com/Patrickleondev/Projet_Final_DCLIC_2025.git
cd Projet_Final_DCLIC_2025
```

### 2. Installer les dépendances
```bash
flutter pub get
```

### 3. Configuration de l'environnement
- Assurez-vous que Flutter est correctement installé en exécutant :
```bash
flutter doctor
```
- Résolvez tous les problèmes signalés par flutter doctor

### 4. Compilation et exécution
```bash
flutter run
```

## Configuration

### Configuration de la base de données
L'application utilise SQLite pour le stockage local des données. La base de données est automatiquement créée lors de la première exécution.

### Configuration des icônes
Les icônes de l'application sont configurées dans le fichier `pubspec.yaml`. Pour générer les icônes :
```bash
flutter pub run flutter_launcher_icons
```

## Utilisation

### Création d'un compte
1. Lancez l'application
2. Cliquez sur "S'inscrire"
3. Remplissez les champs requis :
   - Nom (minimum 3 caractères)
   - Email (format valide requis)
   - Mot de passe (minimum 6 caractères)

### Connexion
1. Sur l'écran d'accueil, entrez vos identifiants
2. Cliquez sur "Se connecter"

### Gestion des notes
1. Création d'une note :
   - Cliquez sur le bouton "+"
   - Remplissez le titre (minimum 3 caractères)
   - Ajoutez le contenu (minimum 10 caractères)
   - Sauvegardez

2. Modification d'une note :
   - Sélectionnez la note à modifier
   - Cliquez sur l'icône de modification
   - Apportez vos modifications
   - Sauvegardez

3. Suppression d'une note :
   - Sélectionnez la note
   - Cliquez sur l'icône de suppression
   - Confirmez la suppression

## Fonctionnalités

### Validation des données
L'application inclut plusieurs validateurs pour assurer la qualité des données :
- Validation du nom (minimum 3 caractères)
- Validation de l'email (format valide)
- Validation du mot de passe (minimum 6 caractères)
- Validation du titre (minimum 3 caractères)
- Validation du contenu (minimum 10 caractères)

### Sécurité
- Stockage local sécurisé avec SQLite
- Validation des entrées utilisateur
- Protection des données sensibles

### Interface utilisateur
- Design Material Design
- Navigation intuitive
- Interface responsive

## Dépannage

### Problèmes courants

1. Erreur de compilation
   - Vérifiez que toutes les dépendances sont installées
   - Exécutez `flutter clean` suivi de `flutter pub get`

2. Problèmes de base de données
   - Vérifiez les permissions de l'application
   - Désinstallez et réinstallez l'application

3. Problèmes de performance
   - Vérifiez l'espace de stockage disponible
   - Nettoyez le cache de l'application

### Support
Pour toute question ou problème non résolu, veuillez :
1. Consulter la documentation
2. Vérifier les issues sur le repository
3. Contacter l'équipe de support

