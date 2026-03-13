# Projet-Faraway

## Structure du projet

### Serveur (Laravel)
Le dossier `server/` contient un projet Laravel 12 qui sert de backend PHP.

#### Démarrage du serveur
```bash
cd server
php artisan serve
```

Le serveur démarrera par défaut sur `http://localhost:8000`

#### Configuration
- Fichier d'environnement : `server/.env`
- Configuration de la base de données : `server/config/database.php`
- Routes API : `server/routes/api.php`
- Routes Web : `server/routes/web.php`

#### Dossiers principaux
- `app/` - Code applicatif (Models, Controllers, Services, etc.)
- `config/` - Fichiers de configuration
- `database/` - Migrations et seeders
- `resources/` - Vues et assets
- `routes/` - Définition des routes
- `storage/` - Fichiers générés et logs
- `public/` - Point d'entrée public (index.php)
