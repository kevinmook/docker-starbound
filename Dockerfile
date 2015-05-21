FROM phusion/baseimage:0.9.16
MAINTAINER Kevin Mook <kevin@kevinmook.com>

# Set correct environment variables.
ENV HOME /home/starbound

VOLUME ["/data"]

RUN apt-get update && \
    apt-get install -y wget

RUN apt-get update && \
    apt-get install -y lib32gcc1

RUN useradd -m starbound

RUN exec /sbin/setuser starbound mkdir ~/steamcmd
RUN exec /sbin/setuser starbound wget -O ~/steamcmd/steamcmd_linux.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN cd ~/steamcmd && \
    exec /sbin/setuser starbound tar -xvzf steamcmd_linux.tar.gz


COPY /container_scripts/init.d/* /etc/my_init.d/
COPY /container_scripts/services/starbound/run /etc/service/starbound/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Forward apporpriate ports
EXPOSE 21025/tcp 21025/udp

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
