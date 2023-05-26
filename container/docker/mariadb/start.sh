#!/usr/bin/env bash

docker run -d --name mariadb-dev \
  -p 3309:3306  \
  -v /tmp/mysql/:/docker-entrypoint-initdb.d/:ro \
  -v mariadb-storage:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=root@mysql -e MYSQL_DATABASE=dev -e MYSQL_USER=dev -e MYSQL_PASSWORD=dev \
  mariadb:10.5 \
  --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci \
  --transaction-isolation=READ-COMMITTED \
  --slow_query_log=ON --slow_query_log_file=slow.log --long_query_time=10 --log_slow_rate_limit=10 \
  --log-bin --binlog_format=MIXED --innodb_flush_log_at_trx_commit=1 \
  --innodb_buffer_pool_size=536870912 --innodb-file-per-table=ON --innodb_page_size=32k \
  --innodb_default_row_format=dynamic --innodb_sort_buffer_size=16777216
