#!/bin/bash

echo "Putting ssh keys in place"
mkdir -p /root/.ssh
echo "${SSH_PUB}" > /root/.ssh/authorized_keys
chmod 0700 /root/.ssh
chmod 0600 /root/.ssh/authorized_keys

echo "Starting SSH"
echo "UseDNS no" >> /etc/ssh/sshd_config
/usr/sbin/sshd

FILE="/keys/duo"
if [! -a "$FILE" ]; then
    echo "Key file is missing"
    sleep 600
    exit 1
fi

LOC=$(wc -l "$FILE")

if [ $LOC < 50 ]; then
    echo "File is too small to pull from"
    sleep 600
    exit 1
fi

CODE=$(head -n1 "$FILE")
# Remove first line of a file
#tail -n +2 "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"

echo "Starting openconnect!"
#echo "Starting openconect"
(echo "${PASSWORD}"; echo "push") | /usr/sbin/openconnect --passwd-on-stdin ${OPTIONS} ${SERVER}
echo "Openconnect stopped echo $@"
sleep 60
echo "Done sleeping"
exit 255
