FROM php:8.3-fpm-alpine

# Install extensions + web server
RUN docker-php-ext-install pdo pdo_mysql opcache pcntl \
 && apk add --no-cache nginx supervisor curl

# Get Composer from official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Install deps first (Docker layer cache)
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-scripts

COPY . .

# Warm all caches
RUN php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache \
 && chmod -R 775 storage bootstrap/cache

EXPOSE 8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
