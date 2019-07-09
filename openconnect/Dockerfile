FROM debian:stretch
MAINTAINER Drew Wells <drew.wells00@gmail.com>

RUN mkdir -p /var/run/sshd
RUN apt-get update && \
    apt-get install -y openconnect openssh-server netcat-traditional \
    ocproxy dnsutils telnet python3-pip curl && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

COPY vpn-slice-1d45bd2e978fa4350b9746b74289972a083dbd80.zip /vpn-slice.zip
RUN pip3 install /vpn-slice.zip
COPY run.sh /run.sh
RUN chmod 0755 /run.sh

ENTRYPOINT ["/run.sh"]
