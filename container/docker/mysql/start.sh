#!/usr/bin/env bash

docker run -d --name mysql-dev \
  -p 3309:3306 -v /tmp/mysql/:/docker-entrypoint-initdb.d/:ro -e MYSQL_ROOT_PASSWORD=root@mysql \
  -e MYSQL_DATABASE=dev -e MYSQL_USER=dev -e MYSQL_PASSWORD=dev \
  mysql:5 \
  --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci \
  --transaction-isolation=READ-COMMITTED \
  --slow_query_log=ON --slow_query_log_file=slow.log
