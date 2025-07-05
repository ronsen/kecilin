FROM ubuntu:latest

LABEL maintainer="Ronald Nababan"

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www/html

RUN apt update && apt upgrade -y && \
	apt install -y zip unzip sqlite3 curl && \
	apt install -y php-cli php-sqlite3 php-gd php-curl php-imap php-mbstring \
	php-xml php-zip php-bcmath php-soap php-intl php-readline php-msgpack \
	php-igbinary php-memcached php-pcov php-imagick php-xdebug && \
	apt clean && rm -rf /var/lib/apt/lists/*

RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh && \
	bash nodesource_setup.sh && \
	apt install -y nodejs

RUN ln -s /usr/local/bin/frankenphp /usr/local/bin/frankenphp

COPY . .

RUN composer install --optimize-autoloader --no-dev

RUN chown www-data:www-data -R storage && \
	chown www-data:www-data database && \
	chown www-data:www-data database/database.sqlite

RUN php artisan storage:link

RUN npm install && npm run build

EXPOSE 8000

ENTRYPOINT ["php", "artisan", "octane:start"]
