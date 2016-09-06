#!/bin/sh

cd /var/log/nginx
d=`date "+%Y-%m-%d"`
mv access.log access.${d}.log
kill -USR1 `cat /var/run/nginx.pid`