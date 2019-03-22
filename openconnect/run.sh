#!/bin/bash


echo "Starting unbound..."
unbound -vv -d -c /etc/unbound/unbound.conf &

echo "Starting openconect"
echo -n -e "${PASSWORD}" | /usr/sbin/openconnect -v --script-tun --script "/usr/bin/ocproxy -v -k 30 -g -D 9000"  ${OPTIONS} ${SERVER}
