FROM gibby/base:ubuntu18.04

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y locales \
    build-essential \
    cmake \
    ffmpeg \
    gnuradio-dev \
    gr-osmosdr \
    lame \
    libboost-all-dev \
    libhackrf-dev \
    libssl-dev \
    libuhd-dev \
    libusb-1.0-0.dev && \
    rm -rf /var/lib/apt/lists/*

# Get and build trunk-recorder
RUN git clone https://github.com/robotastic/trunk-recorder.git /opt/trunk-recorder-src && \
    mkdir -p /opt/recorder && \
    cd /opt/recorder && \
    cmake /opt/trunk-recorder-src && \
    make && \
    rm -fr /opt/trunk-recorder-src
