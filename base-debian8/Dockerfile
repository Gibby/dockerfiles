# My base image.
FROM debian:jessie
MAINTAINER Chris Gibson <git@twoitguys.com>

RUN apt-get update && \
    apt-get install -y curl git vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
