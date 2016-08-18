# webstack

Set the owner to linux user `webstack(901)`.

```
docker run -d --name mariadb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 nisnaker/webstack:mariadb 

docker run -d --name php-fpm --link mariadb:mariadb -v /localproject:/var/www -w /var/www nisnaker/webstack:php-fpm

docker run -d --name nginx --link php-fpm:php-fpm -p 8080:80  -v /localproject:/var/www -w /var/www nisnaker/webstack:nginx
```