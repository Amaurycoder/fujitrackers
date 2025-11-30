# Guide de Déploiement - Fujifilm Recipe Tracker

## 🚀 Déploiement sur Vercel (Recommandé)

Vercel est la solution la plus simple pour déployer cette application.

### Étape 1: Préparer le Repository

```bash
# Initialiser git si ce n'est pas déjà fait
git init
git add .
git commit -m "Initial commit"

# Créer un repo sur GitHub et pusher
git remote add origin https://github.com/VOTRE-USERNAME/fujifilm-recipe-tracker
git push -u origin main
```

### Étape 2: Déployer sur Vercel

1. Allez sur [vercel.com](https://vercel.com)
2. Cliquez sur "New Project"
3. Importez votre repository GitHub
4. Vercel détectera automatiquement la configuration (`vercel.json`)
5. Ajoutez la variable d'environnement :
   - **Name:** `GEMINI_API_KEY`
   - **Value:** Votre clé API Gemini depuis [aistudio.google.com](https://aistudio.google.com)
6. Cliquez sur "Deploy"

✅ Votre app sera en ligne en 2 minutes sur `https://votre-app.vercel.app`

### Étape 3: Obtenir une Clé API Gemini

1. Allez sur [Google AI Studio](https://aistudio.google.com)
2. Connectez-vous avec votre compte Google
3. Cliquez sur "Get API Key"
4. Créez une nouvelle clé API
5. Copiez la clé (elle commence par `AIzaSy...`)

**Important:** La clé Gemini est **gratuite** avec des limites généreuses.

## 🔧 Configuration Avancée

### Variables d'Environnement Vercel

Dans **Settings → Environment Variables**, vous pouvez ajouter :

| Variable | Description | Requis |
|----------|-------------|--------|
| `GEMINI_API_KEY` | Clé API Gemini | ✅ Oui |
| `PORT` | Port du serveur (auto sur Vercel) | ❌ Non |

### Domaine Personnalisé

1. Dans Vercel, allez dans **Settings → Domains**
2. Ajoutez votre domaine personnalisé
3. Suivez les instructions DNS

## 🌐 Autres Options de Déploiement

### Option 2: Netlify

```bash
# Installer Netlify CLI
npm install -g netlify-cli

# Déployer
netlify deploy --prod
```

Ajoutez `GEMINI_API_KEY` dans **Site settings → Environment variables**.

### Option 3: Railway

1. Allez sur [railway.app](https://railway.app)
2. Créez un nouveau projet depuis GitHub
3. Ajoutez la variable `GEMINI_API_KEY`
4. Déployez

### Option 4: Serveur VPS (DigitalOcean, AWS, etc.)

```bash
# Sur votre serveur
git clone https://github.com/VOTRE-REPO/fujifilm-recipe-tracker
cd fujifilm-recipe-tracker

# Installer les dépendances
cd api && npm install && cd ..
npm install

# Configurer .env
echo "GEMINI_API_KEY=votre_clé" > .env

# Lancer avec PM2
npm install -g pm2
pm2 start api/server.js --name fuji-api
pm2 startup
pm2 save

# Build du frontend
npm run build

# Servir avec nginx
sudo cp -r dist/* /var/www/html/
```

## 🔍 Vérification du Déploiement

### Test de l'API

```bash
# Health check
curl https://votre-app.vercel.app/api/health

# Test de recherche
curl -X POST https://votre-app.vercel.app/api/search-recipes \
  -H "Content-Type: application/json" \
  -d '{"query":"Kodachrome"}'
```

### Monitoring

- **Vercel Dashboard:** Logs en temps réel
- **Analytics:** Activez dans Settings → Analytics
- **Alerts:** Configurez des alertes pour les erreurs

## 📊 Limites et Quotas

### Vercel Free Tier

- ✅ 100 GB bandwidth/mois
- ✅ Serverless Functions illimitées
- ✅ Déploiements illimités
- ✅ SSL automatique

### Gemini API (Gratuit)

- ✅ 60 requêtes/minute
- ✅ 1500 requêtes/jour
- ✅ Gratuit pour toujours (Flash model)

### Rate Limiting de l'App

- 10 requêtes/minute par IP
- Configurable dans `api/server.js`

## 🐛 Résolution de Problèmes

### Erreur "API not configured"

```bash
# Vérifier que la variable est définie
vercel env ls

# Ajouter la variable
vercel env add GEMINI_API_KEY
```

### Build Failed

```bash
# Vérifier les logs
vercel logs

# Rebuild localement
npm run build
```

### API Timeout

Augmentez le timeout dans `vercel.json` :

```json
{
  "functions": {
    "api/server.js": {
      "maxDuration": 30
    }
  }
}
```

## 🔄 Mises à Jour

```bash
# Faire vos modifications
git add .
git commit -m "Update: description"
git push

# Vercel redéploie automatiquement !
```

## 📱 PWA (Progressive Web App)

Pour transformer l'app en PWA installable :

1. Ajoutez un `manifest.json`
2. Ajoutez un Service Worker
3. Vercel servira automatiquement en HTTPS

## 🎉 C'est Tout !

Votre application est maintenant accessible mondialement, sans configuration utilisateur requise !

**URL de production:** `https://votre-app.vercel.app`

Pour toute question, consultez la [documentation Vercel](https://vercel.com/docs).
