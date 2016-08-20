# webstack

Set the owner to linux user `webstack(901)`.

```
docker run -d --name mariadb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 nisnaker/webstack:mariadb 

docker run -d --name php-fpm --link mariadb:mariadb -v /localproject:/var/www -w /var/www nisnaker/webstack:php-fpm

docker run -d --name nginx --link php-fpm:php-fpm -p 8080:80  -v /localproject:/var/www -w /var/www nisnaker/webstack:nginx

----

docker run --rm -it --name rsync_server -v /dst:/data -e ROLE=server -p 873 nisnaker/webstack:rsync

docker run --rm -it --name rsync_client -v /src:/data -e ROLE=client -e REMOTE_HOST=172.17.0.1 nisnaker/webstack:rsync

```

[example docker-compose.yml](https://github.com/nisnaker/webstack/blob/master/docker/docker-compose.yml)