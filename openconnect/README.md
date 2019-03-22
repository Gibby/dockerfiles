# What is this?
A container that runs ssh and openconnect.
I use it for ssh'ing to servers through the vpn from the localhost(my laptop) running the container.
It also runs a SOCKS 5 server on port 9000.. Finally yaaaaaa

NOTE: Privileged mode is needed for the TUN adapter in the container.

## Environment variables needed
PASSWORD - The password passed to openconnect.

OPTIONS - Options passed to openconnect. Example -e OPTIONS="-u awesome_admin --authgroup=ADMINS --no-cert-check"

SERVER - Server to connect to with openconnect.

## File mount
custom.conf for Unbound.

## Docker run options needed
And a port for the socks 5 proxy
-p 127.0.0.1:9000:9000

## Example 1 password
docker run --privileged \

-p 127.0.0.1:9000:9000 \

-v custom.conf:/etc/unbound/unbound.conf.d/custom.conf \

-e OPTIONS="-u awesome_admin --authgroup=ADMINS --no-cert-check" \

-e SERVER=vpnserver.local \

-e PASSWORD=changeme\n \

-t gibby/openconnect

## Example 2 passwords (like 2FA)
docker run --privileged \

-p 127.0.0.1:9000:9000 \

-v custom.conf:/etc/unbound/unbound.conf.d/custom.conf \

-e OPTIONS="-u awesome_admin --authgroup=ADMINS --no-cert-check" \

-e SERVER=vpnserver.local \

-e PASSWORD=changeme\n 123456\n \

-t gibby/openconnect



## SSH Config on localhost
Put something like below in your .ssh/config with ProxyCommand for the hosts behind the vpn

ProxyCommand ssh -p 10022 root@localhost nc %h %p



## TODO
Add instructions for using redsocks on linux with iptables to route networks through iptables to redsocks to the socks 5 proxy on the container
