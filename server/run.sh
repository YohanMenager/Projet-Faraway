#!/bin/bash

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher l'aide
show_help() {
    echo -e "${BLUE}Usage: ./run.sh [OPTION]${NC}\n"
    echo -e "${YELLOW}Options:${NC}"
    echo -e "  ${GREEN}start${NC}      Démarrer les conteneurs"
    echo -e "  ${GREEN}stop${NC}       Arrêter les conteneurs"
    echo -e "  ${GREEN}restart${NC}    Redémarrer les conteneurs"
    echo -e "  ${GREEN}logs${NC}       Afficher les logs en temps réel"
    echo -e "  ${GREEN}ps${NC}         Afficher l'état des conteneurs"
    echo -e "  ${GREEN}shell${NC}      Se connecter au shell du conteneur app"
    echo -e "  ${GREEN}tinker${NC}     Lancer Laravel Tinker (shell interactif)"
    echo -e "  ${GREEN}migrate${NC}    Exécuter les migrations"
    echo -e "  ${GREEN}seed${NC}       Exécuter les seeders"
    echo -e "  ${GREEN}cache-clear${NC} Vider le cache"
    echo -e "  ${GREEN}clean${NC}      Nettoyer les conteneurs et volumes"
    echo -e "  ${GREEN}help${NC}       Afficher cette aide\n"
    echo -e "${YELLOW}Exemples:${NC}"
    echo -e "  ./run.sh start"
    echo -e "  ./run.sh logs"
    echo -e "  ./run.sh shell\n"
}

# Si aucun argument, afficher l'aide
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

# Traiter les arguments
case "$1" in
    start)
        echo -e "${YELLOW}Démarrage des conteneurs...${NC}"
        docker-compose up -d
        echo -e "${GREEN}✓ Conteneurs démarrés${NC}"
        echo -e "${BLUE}Application accessible à : ${GREEN}http://localhost${NC}"
        ;;
    stop)
        echo -e "${YELLOW}Arrêt des conteneurs...${NC}"
        docker-compose down
        echo -e "${GREEN}✓ Conteneurs arrêtés${NC}"
        ;;
    restart)
        echo -e "${YELLOW}Redémarrage des conteneurs...${NC}"
        docker-compose restart
        echo -e "${GREEN}✓ Conteneurs redémarrés${NC}"
        ;;
    logs)
        docker-compose logs -f
        ;;
    ps)
        docker-compose ps
        ;;
    shell)
        echo -e "${YELLOW}Connexion au shell du conteneur app...${NC}"
        docker-compose exec app bash
        ;;
    tinker)
        echo -e "${YELLOW}Lancement de Laravel Tinker...${NC}"
        docker-compose exec app php artisan tinker
        ;;
    migrate)
        echo -e "${YELLOW}Exécution des migrations...${NC}"
        docker-compose exec app php artisan migrate
        echo -e "${GREEN}✓ Migrations exécutées${NC}"
        ;;
    seed)
        echo -e "${YELLOW}Exécution des seeders...${NC}"
        docker-compose exec app php artisan db:seed
        echo -e "${GREEN}✓ Seeders exécutés${NC}"
        ;;
    cache-clear)
        echo -e "${YELLOW}Vidage du cache...${NC}"
        docker-compose exec app php artisan cache:clear
        docker-compose exec app php artisan config:cache
        docker-compose exec app php artisan route:cache
        echo -e "${GREEN}✓ Cache vidé${NC}"
        ;;
    clean)
        echo -e "${RED}Attention : Cela supprimera les conteneurs et les données${NC}"
        read -p "Êtes-vous sûr ? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Suppression des conteneurs et volumes...${NC}"
            docker-compose down -v
            echo -e "${GREEN}✓ Nettoyage terminé${NC}"
        else
            echo -e "${YELLOW}Opération annulée${NC}"
        fi
        ;;
    help)
        show_help
        ;;
    *)
        echo -e "${RED}Option inconnue : $1${NC}"
        show_help
        exit 1
        ;;
esac

