#!/usr/bin/env bash

function print_usage {
  echo -e "Usage: \n"
  echo -e "\t./ipsec_wrapper.sh command [args]"
  echo -e "command list:"
  echo -e "\tlist: list all avail connection names"
  echo -e "\tstart: start connection"
  echo -e "\tdown: down connection"
  echo -e "\tparse-nydus: read text from stdin , parse it, output the ipsec.conf to stdout"
}

function start_connection {
  conn_name=$1
  interface=$2
  ipsec up $conn_name && ipsec route $conn_name && \
    echo -e "nameserver\t8.8.8.8\nnameserver\t208.67.222.222" | resolvconf -a ${interface:=eth0}
}

function down_connection {
  conn_name=$1
  interface=$2
  ipsec unroute $conn_name && ipsec down $conn_name && \
    echo -e "nameserver\t114.114.114.114\nnameserver\t114.114.114.115" | resolvconf -a ${interface:=eth0}
}

function list_connection {
  grep -e  "^conn" /etc/ipsec.conf | sed -e 's/conn\s*//ig'
}

function parse_nydus {
  input_file=$1
  lines=$(grep "<td>" $input_file| sed -e '1,7d' | grep -viE "yes|running" | tr -d '\n' | sed -re 's@(/[^<]+</td>)(<td>)@\1\n\2@ig' | grep -i  "ikev2" | tr -s '[:blank:]' '-' |  sed -re 's@<td>\[.+\]-+([^<]+)</td><td>([^<]+)</td>.*@\1,\2@ig' | tr -s '[:upper:]' '[:lower:]')
  for l in $lines
  do
    cname=${l%,*}
    ip=${l#*,}
    echo -e "conn nydus-$cname\n\tright=$ip\n\talso=nydus-base"
  done
}

if [ 1 -gt $# ]; then
  print_usage
  exit 1
fi

cmd=$1
case $cmd in
list)
  list_connection
  ;;

start)
  if [ 2 -gt $# ]; then
    echo -e "Usage:\n"
    echo -e "\tstart connection [interface_name]"
    exit 1
  fi
  start_connection $2 $3
  ;;

down)
  if [ 2 -gt $# ]; then
    echo -e "Usage:\n"
    echo -e "\tdown connection [interface_name]"
    exit 1
  fi
  down_connection $2 $3
  ;;

parse-nydus)
  if [ 2 -gt $# ]; then
    echo -e "Usage:\n"
    echo -e "\tparse-nydus inputFile"
    exit 1
  fi
  parse_nydus $2
  ;;
esac
