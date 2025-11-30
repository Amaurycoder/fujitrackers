# Déploiement Backend - Guide Rapide

## 📋 Checklist Pré-Déploiement

### Configuration Firebase
- [ ] Projet Firebase créé sur [console.firebase.google.com](https://console.firebase.google.com)
- [ ] Authentication activée (Google + Email/Password)
- [ ] Firestore Database créée
- [ ] Plan Blaze activé (requis pour Cloud Functions)

### Clés API
- [ ] Clé API Gemini obtenue sur [aistudio.google.com](https://aistudio.google.com)
- [ ] Clé configurée dans `.env` local (pour tests)
- [ ] Clé configurée dans Firebase Functions config (pour production)

### Configuration Projet
- [ ] `.firebaserc` mis à jour avec votre project ID
- [ ] Dépendances installées (`cd functions && npm install`)
- [ ] Build réussi (`npm run build`)

## 🚀 Commandes de Déploiement

### 1. Login Firebase
```bash
firebase login
```

### 2. Initialiser le projet (si pas déjà fait)
```bash
firebase init
# Sélectionnez : Functions, Firestore, Hosting (optionnel)
```

### 3. Configurer la clé API Gemini (Production)
```bash
firebase functions:config:set gemini.api_key="AIzaSy..."
```

### 4. Déployer tout
```bash
# Déployer Functions + Firestore Rules
firebase deploy

# OU déployer séparément :
firebase deploy --only functions
firebase deploy --only firestore:rules
```

## 🧪 Tests Locaux (Optionnel)

```bash
# Démarrer les émulateurs
firebase emulators:start

# L'app sera disponible sur :
# - Functions: http://localhost:5001
# - Firestore: http://localhost:8080
# - Auth: http://localhost:9099
```

## 📝 Après le Déploiement

### 1. Vérifier les Functions
```bash
firebase functions:log
```

### 2. Tester dans l'application
1. Ouvrir l'app web
2. Aller dans **Paramètres** → **Développeur**
3. Coller la configuration Firebase JSON
4. Se connecter avec Google ou Email
5. Tester les fonctionnalités IA

### 3. Surveiller les coûts
- Consultez la console Firebase → Usage
- Les limites gratuites sont généreuses
- Configurez des alertes de budget si nécessaire

## ⚠️ Problèmes Courants

### "Missing required environment variable"
```bash
firebase functions:config:set gemini.api_key="votre-clé"
firebase deploy --only functions
```

### "Permission denied"
Vérifiez les règles Firestore et l'authentification

### "Function timeout"
Augmentez le timeout dans `firebase.json` :
```json
{
  "functions": {
    "timeoutSeconds": 60
  }
}
```

## 📊 Monitoring

```bash
# Voir les logs en temps réel
firebase functions:log --only searchRecipes

# Voir les erreurs
firebase functions:log --only errors

# Voir toutes les functions
firebase functions:list
```

## 🎯 Prochaines Étapes

Après le déploiement réussi :
1. ✅ Tester toutes les fonctionnalités
2. ✅ Configurer les alertes de monitoring
3. ✅ Partager l'app avec des utilisateurs test
4. ✅ Collecter les retours
5. ✅ Itérer et améliorer

Bon déploiement ! 🚀
