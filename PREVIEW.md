# Guide de Prévisualisation Locale

Pour tester votre application sur votre machine, suivez ces étapes.

## 1. Installation (Première fois seulement)

Ouvrez votre terminal dans le dossier du projet :

```bash
# 1. Installer les dépendances du site (Frontend)
npm install

# 2. Installer les dépendances de l'API (Backend)
cd api
npm install
cd ..
```

## 2. Configuration

Créez un fichier `.env` à la racine du projet (s'il n'existe pas) et ajoutez votre clé Gemini :

```env
GEMINI_API_KEY=votre_clé_api_ici
PORT=3000
```

## 3. Lancer l'Application

Il faut lancer **deux terminaux** en parallèle :

### Terminal 1 : Le Serveur API
```bash
cd api
npm run dev
```
✅ Doit afficher : `🚀 API server running on port 3000`

### Terminal 2 : Le Site Web
```bash
npm run dev
```
✅ Doit afficher : `Local: http://localhost:5173`

## 4. Accéder au site

Ouvrez votre navigateur sur **[http://localhost:5173](http://localhost:5173)**

Vous pouvez maintenant tester :
- La recherche de recettes
- Les tendances
- Le système de crédits (5/jour)
