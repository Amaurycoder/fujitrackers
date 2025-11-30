# 💰 Guide de Monétisation & Déploiement

Ce guide vous explique comment transformer votre application en source de revenus et la déployer gratuitement.

## 🚀 1. Déploiement Gratuit (Vercel)

Vercel est la plateforme idéale : gratuite pour démarrer, performante, et zéro configuration.

### Étapes Rapides :

1.  **Créez un compte** sur [vercel.com](https://vercel.com).
2.  **Installez Vercel CLI** (optionnel mais pratique) :
    ```bash
    npm install -g vercel
    ```
3.  **Déployez depuis votre terminal** :
    ```bash
    vercel
    ```
    - Répondez `Y` à tout.
    - Vercel détectera automatiquement `vercel.json`.

4.  **Configurez la clé API** :
    - Allez sur le dashboard Vercel de votre projet.
    - **Settings** > **Environment Variables**.
    - Ajoutez `GEMINI_API_KEY` avec votre clé (gratuite sur [aistudio.google.com](https://aistudio.google.com)).

✅ **C'est en ligne !** Votre app est accessible via l'URL fournie par Vercel.

---

## 💎 2. Stratégie de Monétisation (Freemium)

Le modèle est déjà intégré dans le code :

*   **Gratuit** : 5 générations IA par jour (suffisant pour tester et devenir accro).
*   **Premium** : Illimité.

### Comment encaisser l'argent ?

Pour l'instant, le bouton "Passer Premium" est une simulation. Voici comment le rendre réel avec **Stripe** (le standard du paiement).

1.  **Créez un compte Stripe** sur [stripe.com](https://stripe.com).
2.  **Créez un lien de paiement** :
    - Dashboard Stripe > **Catalogue de produits**.
    - Ajoutez un produit "Fujifilm Premium".
    - Prix : **5€ / mois** (ou 50€ / an).
    - Créez un **Lien de paiement** (Payment Link).

3.  **Connectez le bouton** :
    - Dans `index.html`, cherchez la fonction `upgradeToPremium`.
    - Remplacez le code actuel par une redirection vers votre lien Stripe :
      ```javascript
      const upgradeToPremium = () => {
          window.location.href = "https://buy.stripe.com/VOTRE_LIEN_STRIPE";
      };
      ```

4.  **Après paiement** :
    - Configurez Stripe pour rediriger l'utilisateur vers votre site avec un paramètre, ex: `https://votre-site.vercel.app/?success=true`.
    - Dans `index.html`, détectez ce paramètre pour activer le mode Premium automatiquement (version simple) ou via un système de compte (version robuste).

### Astuce "Quick Win" (Sans Backend Complexe)

Pour commencer sans gérer de comptes utilisateurs complexes :
1.  L'utilisateur paie sur Stripe.
2.  Stripe lui envoie un email automatique avec un "Code d'accès Premium".
3.  Ajoutez un champ "Saisir code" dans votre app.
4.  Si le code est bon (ex: stocké dans votre code ou une petite liste), activez le mode Premium localement.

---

## 📈 3. Faire connaître l'app (Acquisition)

Pour faire des sous, il faut du trafic.

1.  **Reddit** : Postez vos meilleures recettes sur r/fujifilm et r/fujix en mentionnant que vous les avez trouvées avec votre "Assistant IA".
2.  **Groupes Facebook** : "Fujifilm X Series", etc.
3.  **TikTok / Reels** : Montrez une photo "avant/après" avec une recette, et dites "Lien en bio pour l'outil".

## 🛡️ Sécurité & Coûts

*   **Coût Vercel** : 0€ (jusqu'à beaucoup de trafic).
*   **Coût Gemini** : 0€ (le modèle Flash est gratuit actuellement).
*   **Votre Marge** : 100% (moins les frais Stripe ~1.5%).

---

**Résumé :**
1. `vercel` pour mettre en ligne.
2. Clé Gemini dans les réglages Vercel.
3. Remplacez le bouton Premium par votre lien Stripe.
4. Partagez sur les réseaux.
5. **Profitez !** 💸
