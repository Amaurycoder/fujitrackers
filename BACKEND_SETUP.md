# Backend Setup Guide - Fujifilm Recipe Tracker

Ce guide vous accompagne dans la configuration complète du backend Firebase pour votre application.

## Prérequis

- Node.js 18+ installé
- Un compte Google
- Firebase CLI installé : `npm install -g firebase-tools`

## Étape 1 : Créer un Projet Firebase

1. Allez sur [Firebase Console](https://console.firebase.google.com)
2. Cliquez sur "Ajouter un projet"
3. Nommez votre projet (ex: `fujifilm-recipe-tracker`)
4. Désactivez Google Analytics (optionnel)
5. Cliquez sur "Créer le projet"

## Étape 2 : Configurer Authentication

1. Dans la console Firebase, allez dans **Authentication**
2. Cliquez sur "Commencer"
3. Activez les méthodes de connexion :
   - **Google** : Activez et configurez
   - **E-mail/Mot de passe** : Activez

## Étape 3 : Configurer Firestore Database

1. Dans la console Firebase, allez dans **Firestore Database**
2. Cliquez sur "Créer une base de données"
3. Choisissez le mode **Production**
4. Sélectionnez une région (ex: `europe-west1` pour l'Europe)
5. Cliquez sur "Activer"

## Étape 4 : Obtenir la Configuration Firebase

1. Dans la console Firebase, allez dans **Paramètres du projet** (icône engrenage)
2. Faites défiler jusqu'à "Vos applications"
3. Cliquez sur l'icône Web `</>`
4. Enregistrez l'application (ex: "Fujifilm Recipe Tracker Web")
5. **Copiez la configuration Firebase** qui ressemble à :

```javascript
{
  "apiKey": "AIzaSy...",
  "authDomain": "your-project.firebaseapp.com",
  "projectId": "your-project-id",
  "storageBucket": "your-project.appspot.com",
  "messagingSenderId": "123456789",
  "appId": "1:123456789:web:abc123"
}
```

6. Dans votre application, ouvrez les **Paramètres** (icône engrenage)
7. Allez dans l'onglet **Développeur**
8. Collez cette configuration dans le champ "Config Firebase (JSON)"
9. Cliquez sur **Sauvegarder**

## Étape 5 : Obtenir une Clé API Gemini

1. Allez sur [Google AI Studio](https://aistudio.google.com)
2. Connectez-vous avec votre compte Google
3. Cliquez sur "Get API Key"
4. Créez une nouvelle clé API
5. **Copiez la clé** (elle commence par `AIzaSy...`)
6. Dans votre application, allez dans **Paramètres** > **Développeur**
7. Collez la clé dans "Override Clé API Gemini"
8. Cliquez sur **Sauvegarder**

## Étape 6 : Configurer Firebase CLI

```bash
# Connectez-vous à Firebase
firebase login

# Initialisez le projet (dans le dossier de votre application)
cd /Users/amaury/Downloads/fujifilm-recipe-tracker
firebase init

# Sélectionnez :
# - Firestore
# - Functions
# - Hosting (optionnel)

# Choisissez "Use an existing project"
# Sélectionnez votre projet créé à l'étape 1

# Pour Functions :
# - Langage : TypeScript
# - ESLint : Oui
# - Installer les dépendances : Oui

# Pour Firestore :
# - Utilisez les fichiers par défaut (firestore.rules, firestore.indexes.json)

# Pour Hosting :
# - Public directory : dist
# - Single-page app : Oui
```

## Étape 7 : Configurer les Variables d'Environnement

```bash
# Allez dans le dossier functions
cd functions

# Copiez le fichier d'exemple
cp .env.example .env

# Éditez .env et ajoutez votre clé Gemini
# GEMINI_API_KEY=AIzaSy...
```

**Important** : Pour déployer en production, configurez la variable d'environnement :

```bash
firebase functions:config:set gemini.api_key="AIzaSy..."
```

Puis mettez à jour `functions/src/index.ts` ligne 16 :

```typescript
const GEMINI_API_KEY = functions.config().gemini?.api_key || process.env.GEMINI_API_KEY || "";
```

## Étape 8 : Installer les Dépendances

```bash
# Dans le dossier functions
cd functions
npm install

# Retournez à la racine
cd ..
```

## Étape 9 : Mettre à Jour .firebaserc

Éditez le fichier `.firebaserc` à la racine et remplacez `your-project-id-here` par votre vrai ID de projet Firebase.

## Étape 10 : Déployer le Backend

```bash
# Déployer les Cloud Functions
firebase deploy --only functions

# Déployer les règles Firestore
firebase deploy --only firestore:rules

# Déployer tout
firebase deploy
```

## Étape 11 : Passer au Plan Blaze (Requis pour Functions)

Les Cloud Functions nécessitent le plan Blaze (pay-as-you-go) :

1. Dans la console Firebase, cliquez sur "Mettre à niveau"
2. Sélectionnez le plan **Blaze**
3. Configurez votre facturation

**Note** : Le plan Blaze reste gratuit jusqu'à certaines limites généreuses. Vous ne paierez que si vous dépassez ces limites.

## Étape 12 : Tester l'Application

1. Ouvrez votre application web
2. Allez dans **Paramètres** et connectez-vous avec Google ou Email
3. Testez les fonctionnalités IA :
   - Recherche de recettes
   - Recettes tendances
   - Conseiller IA

## Structure des Données Firestore

Votre base de données aura cette structure :

```
users/
  {userId}/
    email: string
    createdAt: timestamp
    isPremium: boolean
    credits: {
      date: string
      count: number
    }
    recipes: array
```

## Commandes Utiles

```bash
# Voir les logs des functions
firebase functions:log

# Tester localement avec l'émulateur
firebase emulators:start

# Déployer uniquement les functions
firebase deploy --only functions

# Déployer uniquement les règles
firebase deploy --only firestore:rules
```

## Dépannage

### "Unauthenticated" lors des appels Functions

- Vérifiez que vous êtes bien connecté dans l'application
- Vérifiez que la configuration Firebase est correcte
- Vérifiez les règles Firestore

### "GEMINI_API_KEY not set"

- Configurez la variable d'environnement : `firebase functions:config:set gemini.api_key="votre-clé"`
- Redéployez les functions : `firebase deploy --only functions`

### "Daily credit limit reached"

- C'est normal pour les utilisateurs gratuits (5 crédits/jour)
- Les crédits se réinitialisent à minuit
- Passez Premium dans l'app pour un accès illimité

## Sécurité

- ✅ Les clés API sont côté serveur (Cloud Functions)
- ✅ Authentication requise pour tous les appels
- ✅ Règles Firestore protègent les données utilisateur
- ✅ Rate limiting pour éviter les abus

## Support

Pour toute question, consultez :
- [Documentation Firebase](https://firebase.google.com/docs)
- [Documentation Gemini API](https://ai.google.dev/docs)
