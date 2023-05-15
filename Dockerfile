FROM php:8.1-apache

RUN apt-get update \
  && apt-get install -y \
  libpq-dev \
  libzip-dev \
  libjpeg-dev \
  libpng-dev \
  libonig-dev \
  libxml2-dev \
  libicu-dev \
  libexif-dev \
  libcurl4-openssl-dev \
  libssl-dev \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-jpeg \
  && docker-php-ext-install -j$(nproc) \
  pdo_mysql \
  opcache \
  bcmath \
  zip \
  gd \
  intl \
  exif \
  pcntl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY apache.conf /etc/apache2/conf-available/
RUN a2enmod rewrite
RUN a2enconf apache

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html

RUN composer install --no-dev --optimize-autoloader

EXPOSE 80
CMD ["apache2-foreground"]
