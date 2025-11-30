# Fujifilm Recipe Tracker

Application web pour gérer et découvrir des recettes de simulation de film pour appareils Fujifilm X-Trans V (X-S20, X-T5).

**[💰 Guide de Monétisation & Déploiement](./MONETIZATION_GUIDE.md)** - Pour lancer votre business rapidement.

## 🎯 Fonctionnalités

- 📸 Gestion de recettes de simulation de film Fujifilm
- 🤖 **Recherche de recettes via IA** (Gemini + Google Search) - **Accessible à tous**
- 🔥 **Découverte des recettes tendances** - **Gratuit et illimité**
- 💡 **Suggestions personnalisées** basées sur le contexte
- 💾 Sauvegarde locale (localStorage)
- 🚀 Déploiement en 1 clic sur Vercel

## 🚀 Déploiement Rapide (Recommandé)

### Option 1: Déployer sur Vercel (1 clic)

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/VOTRE-REPO)

1. Cliquez sur le bouton ci-dessus
2. Connectez-vous à Vercel
3. Ajoutez votre clé API Gemini dans les variables d'environnement :
   - `GEMINI_API_KEY` = votre clé depuis [Google AI Studio](https://aistudio.google.com)
4. Déployez !

Votre app sera accessible sur `https://votre-app.vercel.app`

## 💻 Développement Local

### Prérequis

- Node.js 18+
- Une clé API Gemini (gratuite sur [aistudio.google.com](https://aistudio.google.com))

### Installation

```bash
# Cloner le repo
git clone https://github.com/VOTRE-REPO/fujifilm-recipe-tracker
cd fujifilm-recipe-tracker

# Installer les dépendances du backend
cd api
npm install

# Configurer la clé API
cp ../.env.example ../.env
# Éditer .env et ajouter votre GEMINI_API_KEY

# Lancer le serveur API
npm start
```

Le serveur API démarre sur `http://localhost:3000`

### Lancer le frontend

```bash
# Retourner à la racine
cd ..

# Installer les dépendances frontend
npm install

# Lancer le dev server
npm run dev
```

L'application sera accessible sur `http://localhost:5173`

## 🏗️ Architecture

```
┌─────────────┐
│   Frontend  │  React + Tailwind
│  (Vite App) │  
└──────┬──────┘
       │ API Calls
       ▼
┌─────────────┐
│  Backend API│  Express.js
│  (Vercel)   │  Rate Limiting: 10 req/min
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Gemini AI  │  Google Generative AI
│   (Flash)   │  
└─────────────┘
```

## 📡 API Endpoints

### `POST /api/search-recipes`
Recherche de recettes Fujifilm via IA.

**Body:**
```json
{
  "query": "Kodachrome"
}
```

**Response:**
```json
{
  "success": true,
  "recipes": [...]
}
```

### `GET /api/trending-recipes`
Récupère les 5 recettes les plus populaires.

**Response:**
```json
{
  "success": true,
  "recipes": [...]
}
```

### `POST /api/suggest-recipe`
Suggère une recette basée sur un contexte.

**Body:**
```json
{
  "context": "Tokyo la nuit, néons",
  "recipes": [...]
}
```

**Response:**
```json
{
  "success": true,
  "suggestion": "..."
}
```

## 🔒 Rate Limiting

- **10 requêtes par minute** par adresse IP
- Protection anti-abus automatique
- Pas de système de crédits ou d'authentification requis

## 🛠️ Tech Stack

- **Frontend:** React 18, Tailwind CSS, Vite
- **Backend:** Express.js, Node.js 18+
- **IA:** Google Gemini 2.0 Flash
- **Hosting:** Vercel (frontend + API)
- **Storage:** localStorage (navigateur)

## 📝 Variables d'Environnement

Créez un fichier `.env` à la racine :

```env
GEMINI_API_KEY=votre_clé_api_gemini
PORT=3000
```

Sur Vercel, configurez dans **Settings → Environment Variables**.

## 🎨 Personnalisation

### Modifier les recettes par défaut

Éditez `index.html` ligne 165-170 pour changer les recettes initiales.

### Changer le rate limiting

Éditez `api/server.js` ligne 24 :

```javascript
const limiter = rateLimit({
  windowMs: 60 * 1000,  // 1 minute
  max: 10,              // 10 requêtes max
  // ...
});
```

## 🐛 Dépannage

### "Trop de requêtes"
Attendez 1 minute. Le rate limiting se réinitialise automatiquement.

### "API not configured"
Vérifiez que `GEMINI_API_KEY` est bien défini dans `.env` ou sur Vercel.

### Le serveur ne démarre pas
```bash
cd api
rm -rf node_modules package-lock.json
npm install
npm start
```

## 📄 License

MIT

## 🙏 Crédits

- Recettes inspirées de [FujiXWeekly](https://fujixweekly.com)
- Communauté Reddit [r/fujifilm](https://reddit.com/r/fujifilm)
- Google Gemini AI pour la recherche intelligente
