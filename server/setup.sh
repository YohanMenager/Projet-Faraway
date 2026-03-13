#!/bin/bash

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}================================${NC}"
echo -e "${YELLOW}Setup du serveur Faraway${NC}"
echo -e "${YELLOW}================================${NC}\n"

# Vérifier si Docker est installé
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Docker trouvé${NC}"

# Vérifier si Docker Compose est installé
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Docker Compose n'est pas installé${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Docker Compose trouvé${NC}\n"

# Créer le fichier .env s'il n'existe pas
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Copie du fichier .env...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✓ Fichier .env créé${NC}"
else
    echo -e "${GREEN}✓ Fichier .env existe déjà${NC}"
fi

# Générer la clé d'application
echo -e "${YELLOW}Génération de la clé d'application...${NC}"
docker-compose run --rm app php artisan key:generate
echo -e "${GREEN}✓ Clé générée${NC}\n"

# Construire les images
echo -e "${YELLOW}Construction des images Docker...${NC}"
docker-compose build
echo -e "${GREEN}✓ Images construites${NC}\n"

# Démarrer les conteneurs
echo -e "${YELLOW}Démarrage des conteneurs...${NC}"
docker-compose up -d
echo -e "${GREEN}✓ Conteneurs démarrés${NC}\n"

# Attendre que la base de données soit prête
echo -e "${YELLOW}Attente de la base de données...${NC}"
sleep 10

# Exécuter les migrations
echo -e "${YELLOW}Exécution des migrations...${NC}"
docker-compose exec -T app php artisan migrate --force
echo -e "${GREEN}✓ Migrations exécutées${NC}\n"

# Créer le symlink storage
echo -e "${YELLOW}Création du symlink storage...${NC}"
docker-compose exec -T app php artisan storage:link || true
echo -e "${GREEN}✓ Symlink créé${NC}\n"

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Setup terminé avec succès !${NC}"
echo -e "${GREEN}================================${NC}\n"

echo -e "${YELLOW}Serveur accessible à :${NC}"
echo -e "${GREEN}http://localhost${NC}\n"

echo -e "${YELLOW}Commandes utiles :${NC}"
echo -e "  ${GREEN}./run.sh start${NC}        - Démarrer les conteneurs"
echo -e "  ${GREEN}./run.sh stop${NC}         - Arrêter les conteneurs"
echo -e "  ${GREEN}./run.sh logs${NC}         - Voir les logs"
echo -e "  ${GREEN}./run.sh shell${NC}        - Accès au shell\n"

