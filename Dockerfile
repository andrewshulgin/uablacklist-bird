FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    iputils-ping \
    net-tools \
    lsb-base \
    software-properties-common \
    gpg \
    cron \
    curl && \
    add-apt-repository ppa:cz.nic-labs/bird && \
    apt-get update && \
    apt-get install bird && \
    apt-get autoclean && \
    apt-get clean

COPY reload /etc/cron.d/reload
COPY blacklist /root/blacklist

# Create volume for configuration files
VOLUME /etc/bird/

# Exposes BGP port by default. Expecify other protocol ports with 'docker run'
EXPOSE 179/tcp

CMD service cron start && \
    /usr/lib/bird/prepare-environment && \
    /usr/sbin/bird -f
