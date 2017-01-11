FROM nisnaker/webstack:php-fpm

MAINTAINER https://github.com/nisnaker/webstack

COPY swoole.so /usr/lib/php7/modules/swoole.so

RUN echo "extension=swoole.so" >> /etc/php7/conf.d/20_swoole.ini

VOLUME /var/www

WORKDIR /var/www

EXPOSE 9000

CMD ["php", "-m"]