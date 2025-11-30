# API Documentation - Cloud Functions

## Base URL

```
https://us-central1-YOUR-PROJECT-ID.cloudfunctions.net
```

## Authentication

Tous les endpoints nécessitent une authentification Firebase. Le token d'authentification est automatiquement géré par le SDK Firebase côté client.

## Endpoints

### 1. Search Recipes

Recherche de recettes Fujifilm sur le web via IA.

**Endpoint:** `searchRecipes`

**Method:** `httpsCallable`

**Request:**
```typescript
{
  query: string  // Recherche (ex: "Kodachrome", "Portrait", etc.)
}
```

**Response:**
```typescript
{
  success: boolean,
  recipes: RecipeData[],
  creditsRemaining: number
}
```

**Errors:**
- `unauthenticated`: Utilisateur non authentifié
- `resource-exhausted`: Limite de crédits atteinte
- `invalid-argument`: Paramètre query manquant ou invalide

**Example:**
```javascript
const searchRecipes = httpsCallable(functions, 'searchRecipes');
const result = await searchRecipes({ query: 'Kodachrome' });
console.log(result.data.recipes);
```

---

### 2. Get Trending Recipes

Récupère les 5 recettes les plus populaires du moment.

**Endpoint:** `getTrendingRecipes`

**Method:** `httpsCallable`

**Request:**
```typescript
{}  // Pas de paramètres requis
```

**Response:**
```typescript
{
  success: boolean,
  recipes: RecipeData[],
  creditsRemaining: number
}
```

**Errors:**
- `unauthenticated`: Utilisateur non authentifié
- `resource-exhausted`: Limite de crédits atteinte

**Example:**
```javascript
const getTrendingRecipes = httpsCallable(functions, 'getTrendingRecipes');
const result = await getTrendingRecipes({});
console.log(result.data.recipes);
```

---

### 3. Suggest Recipe

Suggère une recette basée sur un contexte de prise de vue.

**Endpoint:** `suggestRecipe`

**Method:** `httpsCallable`

**Request:**
```typescript
{
  context: string,      // Description de la situation (ex: "Tokyo la nuit sous la pluie")
  recipes: Recipe[]     // Liste des recettes disponibles
}
```

**Response:**
```typescript
{
  success: boolean,
  suggestion: string,
  creditsRemaining: number
}
```

**Errors:**
- `unauthenticated`: Utilisateur non authentifié
- `resource-exhausted`: Limite de crédits atteinte
- `invalid-argument`: Paramètres manquants ou invalides

**Example:**
```javascript
const suggestRecipe = httpsCallable(functions, 'suggestRecipe');
const result = await suggestRecipe({
  context: "Tokyo la nuit, néons partout",
  recipes: myRecipes
});
console.log(result.data.suggestion);
```

---

### 4. Get Credit Status

Vérifie le statut des crédits de l'utilisateur.

**Endpoint:** `getCreditStatus`

**Method:** `httpsCallable`

**Request:**
```typescript
{}  // Pas de paramètres requis
```

**Response:**
```typescript
{
  success: boolean,
  remaining: number,    // -1 si Premium (illimité)
  isPremium: boolean
}
```

**Errors:**
- `unauthenticated`: Utilisateur non authentifié

**Example:**
```javascript
const getCreditStatus = httpsCallable(functions, 'getCreditStatus');
const result = await getCreditStatus({});
console.log(`Crédits restants: ${result.data.remaining}`);
```

---

## Data Types

### RecipeData

```typescript
interface RecipeData {
  name: string;
  baseSimulation: string;
  dynamicRange: string;
  highlight: number;          // -4 à +4
  shadow: number;             // -4 à +4
  color: number;              // -4 à +4
  noiseReduction: number;     // -4 à +4
  sharpening: number;         // -4 à +4
  clarity: number;            // -5 à +5
  grainRoughness: string;     // "Off", "Weak", "Strong"
  grainSize: string;          // "Small", "Large"
  colorChromeEffect: string;  // "Off", "Weak", "Strong"
  colorChromeFXBlue: string;  // "Off", "Weak", "Strong"
  whiteBalance: string;
  whiteBalanceShiftR: number;
  whiteBalanceShiftB: number;
  iso: string;
  tags: string[];
  notes: string;
  type: string;               // "Color", "B&W"
}
```

## Rate Limiting

- **Utilisateurs gratuits:** 5 crédits par jour (reset à minuit)
- **Utilisateurs Premium:** Illimité

## Error Handling

Toutes les erreurs suivent le format Firebase HttpsError:

```typescript
try {
  const result = await searchRecipes({ query: 'test' });
} catch (error) {
  console.error(error.code);     // Code d'erreur
  console.error(error.message);  // Message d'erreur
  console.error(error.details);  // Détails additionnels
}
```

## Cloud Function Triggers

### onUserCreated

Déclenché automatiquement lors de la création d'un nouveau compte utilisateur.

**Action:** Crée un document utilisateur dans Firestore avec:
- Email
- Date de création
- Statut Premium (false par défaut)
- Crédits initiaux (5)
- Tableau de recettes vide

**Note:** Cette fonction est automatique, pas d'appel manuel nécessaire.
