# Database & Payment Guide

## 🗄️ Accessing the Database (Firestore)

Your application uses **Cloud Firestore** to store user data (credits, premium status, etc.).

1.  Go to the [Firebase Console](https://console.firebase.google.com/).
2.  Select your project.
3.  In the left menu, click on **Build** > **Firestore Database**.
4.  You will see a `users` collection. Click on it to see user documents.
    *   Each document ID corresponds to a User UID.
    *   You can manually edit fields like `isPremium` or `credits` here if needed for support.

## 💳 Setting up Payments (Stripe)

To receive payments, you need to configure Stripe.

1.  **Create a Stripe Account**: Go to [stripe.com](https://stripe.com) and sign up.
2.  **Get API Keys**:
    *   Go to **Developers** > **API keys**.
    *   Copy the **Secret key** (`sk_live_...` or `sk_test_...`).
3.  **Set up Webhook**:
    *   Go to **Developers** > **Webhooks**.
    *   Add an endpoint. The URL will be your Firebase Functions URL + `/stripeWebhook`.
        *   Example: `https://us-central1-YOUR-PROJECT.cloudfunctions.net/stripeWebhook`
    *   Select the event `checkout.session.completed`.
    *   Copy the **Signing secret** (`whsec_...`).
4.  **Configure Firebase**:
    Run the following commands in your terminal to set the secrets:

    ```bash
    firebase functions:config:set stripe.secret="sk_..." stripe.webhook_secret="whsec_..."
    ```
    *Note: In the code, we used `process.env.STRIPE_SECRET_KEY`. You might need to update the code to use `functions.config().stripe.secret` or set environment variables in your Google Cloud Console.*

    **Recommended (Modern way):**
    Create a `.env` file in `functions/` (do not commit this file):
    ```
    STRIPE_SECRET_KEY=sk_test_...
    STRIPE_WEBHOOK_SECRET=whsec_...
    GEMINI_API_KEY=AIza...
    ```
    Then deploy functions: `firebase deploy --only functions`

## 🚀 Deployment

1.  Run `./deploy.sh` to build and deploy everything.
2.  Make sure you have updated the `firebaseConfig` object in `index.html` with your actual project details (found in Firebase Console > Project Settings).
