#!/bin/bash

echo "Putting ssh keys in place"
mkdir -p /root/.ssh
echo "${SSH_PUB}" > /root/.ssh/authorized_keys
chmod 0700 /root/.ssh
chmod 0600 /root/.ssh/authorized_keys

echo "Starting SSH"
echo "UseDNS no" >> /etc/ssh/sshd_config
/usr/sbin/sshd
echo "Starting openconect"
echo -n -e "${PASSWORD}" | /usr/sbin/openconnect -v --script-tun --script "/usr/bin/ocproxy -v -k 30 -g -D 9000"  ${OPTIONS} ${SERVER} 
