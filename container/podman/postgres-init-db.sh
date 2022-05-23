#!/usr/bin/env bash

set -e
psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-EOSQL
  CREATE ROLE dbmgmt NOLOGIN CREATEDB;
  CREATE ROLE devel LOGIN CONNECTION LIMIT 100 PASSWORD 'devel@1290' INHERIT IN ROLE dbmgmt;
  GRANT ALL ON DATABASE postgres to devel;
EOSQL
