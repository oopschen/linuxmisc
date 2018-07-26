#!/bin/sh

if [ "$#" -lt 1 ]; then
	echo -e "mode: A add | D delete | T toggle temporary"
	exit 1
fi

basedir=$(dirname $0)
cfgfile=/etc/shadowsocks-libev/shadowsocks.json
socksserver=$(grep '"server":' $cfgfile | sed -re 's/.*\s*:\s*"([^"]+)".*/\1/ig')
localport=$(grep 'local_port' $cfgfile | sed -re 's/.*:\s*([^, ]+).*/\1/ig')
echo -e "sever=$socksserver,localport=$localport,cfg=$cfgfile"



chainName=SSOCKS
mode=$1
case $mode in
	A)
	# create rules
	echo "create chain $chainName"
	iptables -t nat -N $chainName
	iptables -t mangle -N $chainName

	# Ignore your $chainName server's addresses
	echo "chain $chainName: ignore socks server"
	iptables -t nat -A $chainName -d $socksserver -j RETURN

	# Ignore lan
	echo "chain $chainName: ignore LAN"
	iptables -t nat -A $chainName -d 0.0.0.0/8 -j RETURN
	iptables -t nat -A $chainName -d 10.0.0.0/8 -j RETURN
	iptables -t nat -A $chainName -d 127.0.0.0/8 -j RETURN
	iptables -t nat -A $chainName -d 169.254.0.0/16 -j RETURN
	iptables -t nat -A $chainName -d 172.16.0.0/12 -j RETURN
	iptables -t nat -A $chainName -d 192.168.0.0/16 -j RETURN
	iptables -t nat -A $chainName -d 224.0.0.0/4 -j RETURN
	iptables -t nat -A $chainName -d 240.0.0.0/4 -j RETURN
	iptables -t nat -A $chainName -d 101.224.0.0/13 -j RETURN
	iptables -t nat -A $chainName -d 114.114.0.0/14 -j RETURN
	iptables -t nat -A $chainName -d 183.128.0.0/11 -j RETURN
	iptables -t nat -A $chainName -d 117.24.0.0/13 -j RETURN
	iptables -t nat -A $chainName -d 61.144.0.0/14 -j RETURN
	iptables -t nat -A $chainName -d 122.224.0.0/12 -j RETURN
	iptables -t nat -A $chainName -d 140.205.0.0/16 -j RETURN

  # ignore ip in files
  ignoreFile=${basedir}/.shadowsocks-redir-ignore
  if [ -f "$ignoreFile" ]; then
    echo "ignoring ips:  $(wc -l $ignoreFile)"
    for line in $(cat $ignoreFile)
    do
      iptables -t nat -A $chainName -d $line -j RETURN
    done
  fi

	# redirect to local port
	echo "chain $chainName: redirect all tcp"
	iptables -t nat -A $chainName -p tcp -j REDIRECT --to-ports $localport

	# Add any UDP rules
	echo "chain $chainName: udp chains"
	ip route add local default dev lo table 100
	ip rule add fwmark 1 lookup 100
	iptables -t mangle -A $chainName -p udp --dport 53 -j TPROXY --on-port $localport --tproxy-mark 0x01/0x01

	# Apply the rules
	echo "chain $chainName: apply rules"
	# for server
	#iptables -t nat -A PREROUTING -p tcp -j $chainName
	#iptables -t mangle -A PREROUTING -j $chainName
	# for desktop
	iptables -t nat -A OUTPUT -p tcp -j $chainName
	iptables -t mangle -A PREROUTING -j $chainName
	echo "Done......"

	;;

	D)
	echo "chain $chainName: flush chains"
	iptables -t nat -F $chainName
	iptables -t mangle -F $chainName

	echo "chain $chainName: delete udp chains"
	ip route del local default dev lo table 100
	ip rule del fwmark 1 lookup 100

	echo "chain $chainName: delete chains"
	# for server
	#iptables -t nat -D PREROUTING -p tcp -j $chainName
	#iptables -t mangle -D PREROUTING -j $chainName
	# for desktop
	iptables -t nat -D OUTPUT -p tcp -j $chainName
	iptables -t mangle -D PREROUTING -j $chainName

	iptables -t nat -X $chainName
	iptables -t mangle -X $chainName
	echo "Done......"

	;;

	T)
		inText=$(iptables -t nat -L OUTPUT -n| grep $chainName)
		msg=
		if [ -z "$inText" ]; then
			iptables -t nat -A OUTPUT -p tcp -j $chainName
			iptables -t mangle -A PREROUTING -j $chainName
			msg=UP
		else
			iptables -t nat -D OUTPUT -p tcp -j $chainName
			iptables -t mangle -D PREROUTING -j $chainName
			msg=DOWN
		fi
		echo "$msg Done......"
	;;

	S)
		inText=$(iptables -t nat -L OUTPUT -n| grep $chainName)
		if [ -z "$inText" ]; then
			echo "Status Done..."
		else
			echo "Status UP..."
		fi
	;;

	*)
	echo -e "mode: A add | D delete"
	;;
esac
