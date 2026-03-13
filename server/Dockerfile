FROM php:8.2-fpm

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    curl \
    libpq-dev \
    libzip-dev \
    unzip \
    git \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    zip \
    bcmath \
    && docker-php-ext-enable \
    pdo \
    pdo_pgsql \
    zip \
    bcmath

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet
COPY . .

# Installer les dépendances PHP
RUN composer install --no-interaction --optimize-autoloader

# Installer les dépendances Node (si nécessaire pour Vite)
RUN npm install

# Créer les répertoires nécessaires
RUN mkdir -p storage/logs storage/app storage/framework/views storage/framework/cache \
    && chmod -R 777 storage bootstrap/cache

# Exposer le port pour PHP-FPM
EXPOSE 9000

# Commande de démarrage
CMD ["php-fpm"]

