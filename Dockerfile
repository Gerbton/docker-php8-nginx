#Version: 1.1.0
FROM ubuntu:20.04
LABEL maintainer="gerbton@gmail.com"
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update --fix-missing && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update --fix-missing && \

    # Install VIM and NGINX
    apt-get install -y --no-install-recommends vim nginx \

    # Install Node \
    nodejs npm \

    # Install Composer \
    composer \

    # Install PHP8.0
    php8.0 php8.0-cli php8.0-fpm php8.0-dev php-json php8.0-pdo php8.0-mysql php8.0-zip php8.0-gd php8.0-mbstring php8.0-curl php8.0-xml php8.0-bcmath php8.0-xdebug && \

    apt-get clean

# Configure NGINX
ADD ./nginx/sites-available/default /etc/nginx/sites-available/default
ADD ./nginx/snippets /etc/nginx/snippets

# Configure PHP8.0
ADD ./php/8.0/mods-available/xdebug.ini /etc/php/8.0/mods-available/xdebug.ini

WORKDIR /var/www/html

EXPOSE 80
CMD service php8.0-fpm start && nginx -g 'daemon off;'
