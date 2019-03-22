FROM gibby/base:debian8
MAINTAINER Chris Gibson <git@twoitguys.com>

COPY run.sh /run.sh
RUN chmod 0755 /run.sh
RUN mkdir -p /var/run/sshd
RUN apt-get update && \
    apt-get install -y openconnect openssh-server netcat-traditional ocproxy dnsutils telnet unbound gettext && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 53/tcp
EXPOSE 53/udp

ENTRYPOINT ["/run.sh"]
