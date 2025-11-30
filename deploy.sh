#!/bin/bash

# Build the frontend
echo "🏗️  Building frontend..."
npm run build

# Deploy to Firebase
echo "🚀 Deploying to Firebase..."
firebase deploy

echo "✅ Deployment complete!"
