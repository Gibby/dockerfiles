#!/bin/bash

if [ "$UNBOUND" = "true" ]; then
	echo "Starting unbound..."
	unbound -vv -d -c /etc/unbound/unbound.conf &
	echo "nameserver 127.0.0.1" > /etc/resolv.conf
fi

if [[ (-n "${HTTP_PROXY_USERNAME:-}") && (-n "${HTTP_PROXY_PASSWORD:-}")  ]]; then
    echo "Setting up HTTP proxy with authentication ..."
    polipo proxyAddress=0.0.0.0 proxyPort=8123 socksParentProxy=localhost:9000 authCredentials=${HTTP_PROXY_USERNAME}:${HTTP_PROXY_PASSWORD} &
else
    echo "Setting up HTTP proxy without authentication ..."
    polipo proxyAddress=0.0.0.0 proxyPort=8123 socksParentProxy=localhost:9000 &
fi

sleep 5

echo "Starting openconect"
echo -n -e "${PASSWORD}" | /usr/sbin/openconnect -v --script-tun --script "/usr/bin/ocproxy -v -k 30 -g -D 9000"  ${OPTIONS} ${SERVER}
