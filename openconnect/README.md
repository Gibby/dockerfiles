# What is this?
A container that runs ssh and openconnect.
I use it for ssh'ing to servers through the vpn from the localhost(my laptop) running the container.

NOTE: Privileged mode is needed for the TUN adapter in the container.

## Environment variables needed
SSH_PUB - This is your public ssh key that will be allowed to ssh as root into the container.

PASSWORD - The password passed to openconnect.

OPTIONS - Options passed to openconnect. Example -e OPTIONS="-u awesome_admin --authgroup=ADMINS --no-cert-check"

SERVER - Server to connect to with openconnect.

## Docker run options needed
You should provide a port from localhost to the container to connect to ssh with.
-p 127.0.0.1:2222:22

## Example
docker run --privileged \

-p 127.0.0.1:2222:22 \

-e SSH_PUB="$(cat ~/.ssh/id_rsa.pub)" \

-e OPTIONS="-u awesome_admin --authgroup=ADMINS --no-cert-check" \

-e SERVER=vpnserver.local \

-e PASSWORD=9999187428 \

-t gibby/openconnect


## SSH Config on localhost
Put something like below in your .ssh/config with ProxyCommand for the hosts behind the vpn

ProxyCommand ssh -p 2200 root@localhost nc %h %p



## TODO
Add a socks proxy inside the container and drop using ssh.
