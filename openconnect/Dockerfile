FROM gibby/base:debian8
MAINTAINER Chris Gibson <git@twoitguys.com>

RUN apt-get update && \
    apt-get install -y openconnect netcat-traditional ocproxy dnsutils telnet unbound gettext && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod 0755 /run.sh

ENTRYPOINT ["/run.sh"]
