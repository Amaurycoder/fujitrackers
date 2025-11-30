# Guide de Gestion du Système

Ce document explique comment gérer votre application, configurer les paiements et administrer les comptes utilisateurs.

## 1. 🔴 Correction de l'erreur "API Key Not Valid"

L'erreur que vous voyez (`auth/api-key-not-valid`) vient du fait que le fichier `index.html` contient encore des valeurs par défaut.

**Action requise :**
1.  Allez sur la [Console Firebase](https://console.firebase.google.com/).
2.  Cliquez sur l'engrenage ⚙️ > **Paramètres du projet**.
3.  Descendez jusqu'à "Vos applications" et sélectionnez l'app Web.
4.  Copiez l'objet `firebaseConfig` (qui ressemble à ça) :
    ```javascript
    const firebaseConfig = {
      apiKey: "AIzaSy...",
      authDomain: "...",
      projectId: "...",
      // ...
    };
    ```
5.  Ouvrez le fichier `index.html` sur votre ordinateur.
6.  Cherchez la ligne `// TODO: Replace with your actual Firebase config`.
7.  Remplacez le bloc `firebaseConfig` existant par celui que vous avez copié.

## 2. 💳 Recevoir des Paiements (Stripe)

Pour recevoir de l'argent sur **votre** compte bancaire, nous utilisons **Stripe**.

1.  **Créer un compte** : Allez sur [stripe.com](https://stripe.com) et créez un compte (c'est gratuit).
2.  **Lier votre banque** : Dans Stripe, configurez vos informations bancaires pour recevoir les virements.
3.  **Récupérer les Clés** :
    *   Allez dans **Développeurs** > **Clés API**.
    *   Copiez la **Clé secrète** (`sk_live_...` pour la prod, `sk_test_...` pour tester).
4.  **Configurer le Webhook** (pour savoir quand un paiement est validé) :
    *   Allez dans **Développeurs** > **Webhooks**.
    *   Ajoutez un endpoint : `https://us-central1-VOTRE-PROJET.cloudfunctions.net/stripeWebhook`
    *   Événement à écouter : `checkout.session.completed`.
    *   Copiez la **Clé de signature** (`whsec_...`).
5.  **Mettre les clés dans Firebase** :
    Dans votre terminal, lancez :
    ```bash
    firebase functions:config:set stripe.secret="sk_..." stripe.webhook_secret="whsec_..."
    firebase deploy --only functions
    ```

## 3. 👥 Gestion des Comptes & Emails

Tout se gère depuis la Console Firebase.

### Base de Données (Firestore)
C'est là que sont stockées les infos utilisateurs (crédits, statut premium).
*   Allez dans **Build** > **Firestore Database**.
*   Collection `users` : Vous verrez la liste des utilisateurs.
*   Vous pouvez modifier manuellement un utilisateur (ex: mettre `isPremium: true` pour offrir un abonnement).

### Emails de Confirmation & Mots de passe
Firebase gère ça automatiquement.
*   Allez dans **Build** > **Authentication**.
*   Onglet **Sign-in method** : Activez "Email/Password" et "Google".
*   Onglet **Templates** : Vous pouvez personnaliser les emails envoyés (vérification d'adresse, mot de passe oublié, etc.).

## 4. 🚀 Déploiement

Une fois la configuration faite :
1.  Lancez `./deploy.sh` dans le terminal.
2.  Votre site sera en ligne à l'adresse `https://VOTRE-PROJET.web.app`.
