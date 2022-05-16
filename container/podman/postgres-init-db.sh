#!/usr/bin/env bash

### create role: admin/admin@1290
### revoke all on public

set -e
psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-EOSQL
  CREATE ROLE admin LOGIN CONNECTION LIMIT 100 PASSWORD 'admin@1290';
  GRANT ALL ON DATABASE postgres to admin;
EOSQL
