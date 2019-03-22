FROM alpine:latest

RUN apk add --no-cache unbound

EXPOSE 53/tcp
EXPOSE 53/udp

CMD unbound -vv -d -c /etc/unbound/unbound.conf
