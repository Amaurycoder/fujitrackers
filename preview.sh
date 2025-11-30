#!/bin/bash

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Démarrage de Fujifilm Recipe Tracker...${NC}"

# Fonction pour tuer les processus en quittant
cleanup() {
    echo -e "\n${BLUE}🛑 Arrêt des serveurs...${NC}"
    kill $(jobs -p) 2>/dev/null
    exit
}

# Capturer Ctrl+C
trap cleanup SIGINT SIGTERM

# Vérifier si les node_modules sont là
if [ ! -d "node_modules" ]; then
    echo "📦 Installation des dépendances Frontend..."
    npm install
fi

if [ ! -d "api/node_modules" ]; then
    echo "📦 Installation des dépendances Backend..."
    cd api && npm install && cd ..
fi

# Charger les variables d'environnement du fichier .env à la racine
if [ -f .env ]; then
  echo -e "${BLUE}🔑 Chargement de la configuration (.env)...${NC}"
  export $(grep -v '^#' .env | xargs)
fi

# 1. Lancer l'API en arrière-plan
echo -e "${GREEN}📡 Lancement du Backend (API)...${NC}"
cd api && npm run dev &
API_PID=$!

# Attendre un peu que l'API démarre
sleep 2

# 2. Lancer le Frontend
echo -e "${GREEN}🎨 Lancement du Frontend...${NC}"
npm run dev &
FRONTEND_PID=$!

echo -e "${BLUE}✅ Tout est lancé ! Appuyez sur Ctrl+C pour arrêter.${NC}"

# Attendre que l'un des processus se termine
wait
