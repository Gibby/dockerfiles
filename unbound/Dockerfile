FROM alpine:latest

RUN apk add --no-cache unbound

EXPOSE 53/tcp
EXPOSE 53/udp

CMD unbound -v -d -c /etc/unbound/unbound.conf
