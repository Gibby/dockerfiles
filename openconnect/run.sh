#!/bin/bash

echo "Starting unbound..."
unbound -vv -d -c /etc/unbound/unbound.conf &
echo "nameserver 127.0.0.1" > /etc/resolv.conf
sleep 5

echo "Starting openconect"
echo -n -e "${PASSWORD}" | /usr/sbin/openconnect -v --script-tun --script "/usr/bin/ocproxy -v -k 30 -g -D 9000"  ${OPTIONS} ${SERVER}
