#!/usr/bin/env bash

docker run --rm -it -v ~/html:/usr/share/nginx/html:ro -p 80:80 nginx:alpine
