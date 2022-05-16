#!/usr/bin/env bash

pm=podman
podname="pod-dev"

####
#### pgAdmin 9100:80
#### postgre 9101:5432
####

$pm pod exists $podname
if [ 0 -eq $? ]; then
  echo "pod $podname exists, remove all containers in it?[Y/N]:"
  read del_flag
  if [ "y" == "$del_flag" ] || [ "Y" == "$del_flag" ]; then
    echo "remove pod $podname"
    $pm pod rm -f $podname
  fi
fi
$pm pod create -n $podname \
  -p 9100:80 \
  -p 9101:5432


## pgAdmin container
c_name="pgAdmin"
if [ "" != "$($pm ps -a -f "name=$c_name" -q)" ]; then
  $pm stop $c_name
  $pm rm $c_name
fi

$pm run --name $c_name --pod $podname -d  \
  -e "PGADMIN_DEFAULT_EMAIL=linxray@gmail.com" \
  -e "PGADMIN_DEFAULT_PASSWORD=pgAdmin@1290" \
  docker.io/dpage/pgadmin4

## postgres container
c_name="postgres"
if [ "" != "$($pm ps -a -f "name=$c_name" -q)" ]; then
  $pm stop $c_name
  $pm rm $c_name
fi

$pm run --name $c_name --pod $podname -d  \
  -e "POSTGRES_PASSWORD=postgres@1290" \
  docker.io/library/postgres:14-alpine
