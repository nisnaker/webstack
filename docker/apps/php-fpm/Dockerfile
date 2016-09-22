FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

# https://hub.docker.com/r/yavin/alpine-php-fpm/~/dockerfile/

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk -U add \
        php7 \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fpm \
        php7-gd \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mongodb \
        php7-mysqli \
        php7-opcache \
        php7-pdo_mysql \
        php7-posix \
        php7-redis \
        php7-session \
        php7-xml \
        php7-iconv \
        php7-phar \
        php7-openssl \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php7 /usr/bin/php \
    && addgroup -g 901 -S webstack \
    && adduser -u 901 -D -S -G webstack webstack

RUN sed -ri 's/short_open_tag = Off/short_open_tag = On/' /etc/php7/php.ini \
    && sed -ri 's/upload_max_filesize = 2M/upload_max_filesize = 20M/' /etc/php7/php.ini \
    && sed -ri 's/variables_order = "GPCS"/variables_order = "EGPCS"/' /etc/php7/php.ini \
    && sed -ri 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE & ~E_WARNING/' /etc/php7/php.ini \
    && sed -ri 's/user = nobody/user = webstack/' /etc/php7/php-fpm.d/www.conf \
    && sed -ri 's/group = nobody/group = webstack/' /etc/php7/php-fpm.d/www.conf \
    && sed -ri 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php7/php-fpm.d/www.conf \
    && sed -ri 's/pm.max_children = 5/pm.max_children = 128/' /etc/php7/php-fpm.d/www.conf \
    && sed -ri 's/pm.start_servers = 2/pm.start_servers = 20/' /etc/php7/php-fpm.d/www.conf \
    && sed -ri 's/pm.min_spare_servers = 1/pm.min_spare_servers = 20/' /etc/php7/php-fpm.d/www.conf \
    && sed -ri 's/pm.max_spare_servers = 3/pm.max_spare_servers = 128/' /etc/php7/php-fpm.d/www.conf \
    && echo 'clear_env = no' >> /etc/php7/php-fpm.d/www.conf

VOLUME /var/www

WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm7", "-F"]