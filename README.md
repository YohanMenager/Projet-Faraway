# Projet-Faraway

## Structure du projet

```
Projet-Faraway/
├── README.md
├── .gitignore
└── server/              # Serveur Laravel indépendant
    ├── Dockerfile
    ├── docker-compose.yml
    ├── setup.sh         # Script d'installation initial
    ├── run.sh           # Script de gestion des conteneurs
    ├── nginx.conf
    ├── .env
    ├── .env.example
    └── ... (fichiers Laravel)
```

ot ## Serveur Laravel

Le dossier `server/` contient un projet **Laravel 12 totalement indépendant** avec sa propre configuration Docker.

### Installation et démarrage avec Docker

#### Première installation
```bash
cd server
./setup.sh
```

Ce script va :
- Vérifier que Docker et Docker Compose sont installés
- Copier le fichier `.env`
- Générer la clé d'application
- Construire les images Docker
- Démarrer les conteneurs
- Exécuter les migrations

#### Gestion des conteneurs
```bash
./run.sh start        # Démarrer les conteneurs
./run.sh stop         # Arrêter les conteneurs
./run.sh restart      # Redémarrer les conteneurs
./run.sh logs         # Afficher les logs en temps réel
./run.sh ps           # État des conteneurs
./run.sh help         # Afficher l'aide complète
```

#### Commandes Laravel
```bash
./run.sh shell        # Accès au shell du conteneur
./run.sh tinker       # Lancer Laravel Tinker (shell interactif)
./run.sh migrate      # Exécuter les migrations
./run.sh seed         # Exécuter les seeders
./run.sh cache-clear  # Vider le cache
./run.sh clean        # Nettoyer les conteneurs et volumes
```

### Services Docker

- **app** : PHP 8.2 FPM avec Laravel
- **webserver** : Nginx (accessible sur `http://localhost:80`)
- **db** : PostgreSQL 16
- **redis** : Redis 7 (pour cache/session)

### Accès à l'application
- **URL** : http://localhost
- **Base de données** : localhost:5432 (laravel/secret)
- **Redis** : localhost:6379

### Démarrage sans Docker

```bash
cd server
composer install
php artisan serve
```

Le serveur démarrera sur `http://localhost:8000`

### Configuration

- Fichier d'environnement : `server/.env`
- Configuration de la base de données : `server/config/database.php`
- Routes API : `server/routes/api.php`
- Routes Web : `server/routes/web.php`

### Dossiers principaux

- `app/` - Code applicatif (Models, Controllers, Services, etc.)
- `config/` - Fichiers de configuration
- `database/` - Migrations et seeders
- `resources/` - Vues et assets
- `routes/` - Définition des routes
- `storage/` - Fichiers générés et logs
- `public/` - Point d'entrée public (index.php)
