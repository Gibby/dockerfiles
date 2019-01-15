# What is this?
A container that runs ssh and openconnect.
I use it for ssh'ing to servers through the vpn from the localhost(my laptop) running the container.
It also runs a SOCKS 5 server on port 9000.. Finally yaaaaaa

NOTE: Privileged mode is needed for the TUN adapter in the container.

## Environment variables needed
SSH_PUB - This is your public ssh key that will be allowed to ssh as root into the container.

PASSWORD - The password passed to openconnect.

OPTIONS - Options passed to openconnect. Example -e OPTIONS="-u awesome_admin --authgroup=ADMINS --no-cert-check"

SERVER - Server to connect to with openconnect.

## Docker run options needed
You should provide a port from localhost to the container to connect to ssh with.
-p 127.0.0.1:10022:22

And a port for the socks 5 proxy
-p 127.0.0.1:9000:9000

## Example 1 password
docker run --privileged \

-p 127.0.0.1:10022:22 \

-p 127.0.0.1:9000:9000 \

-e SSH_PUB="$(cat ~/.ssh/id_rsa.pub)" \

-e OPTIONS="-u awesome_admin --authgroup=ADMINS --no-cert-check" \

-e SERVER=vpnserver.local \

-e PASSWORD=changeme\n \

-t gibby/openconnect

## Example 2 passwords (like 2FA)
docker run --privileged \

-p 127.0.0.1:10022:22 \

-p 127.0.0.1:9000:9000 \

-e SSH_PUB="$(cat ~/.ssh/id_rsa.pub)" \

-e OPTIONS="-u awesome_admin --authgroup=ADMINS --no-cert-check" \

-e SERVER=vpnserver.local \

-e PASSWORD=changeme\n 123456\n \

-t gibby/openconnect



## SSH Config on localhost
Put something like below in your .ssh/config with ProxyCommand for the hosts behind the vpn

ProxyCommand ssh -p 10022 root@localhost nc %h %p



## TODO
Add instructions for using redsocks on linux with iptables to route networks through iptables to redsocks to the socks 5 proxy on the container
