FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    git \
    locales && \
    rm -rf /var/lib/apt/lists/*

# Fix locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
