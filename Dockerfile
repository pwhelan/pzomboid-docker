FROM ubuntu:16.04

ARG TZ="America/Santiago"
ENV DATA /data
ENV APP /app
ENV ADMIN_PASSWORD changeme

RUN apt-get update  && apt-get dist-upgrade -y &&\
	apt-get install -y unzip p7zip-full curl wget \
		lib32gcc1 iproute2 vim-tiny bzip2 jq \
		software-properties-common apt-transport-https \
		lib32stdc++6 && \
	apt-get clean

RUN echo "$TZ" > /etc/timezone
RUN  ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

RUN useradd -m steam

RUN mkdir -p /steam/steamcmd_linux
RUN chown -R steam /steam

RUN mkdir $DATA $APP && \
	chown -R steam $DATA $APP

USER steam

WORKDIR /steam/steamcmd_linux

RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz 
RUN tar -xf steamcmd_linux.tar.gz

# Create the servertest.ini before we even generate the
# data so we can modify values on startup.
RUN mkdir -p $DATA/Server
COPY --chown=steam:steam \
	servertest.ini.default $DATA/Server/servertest.ini

COPY start.sh /start.sh
COPY ini.py /ini.py

ENTRYPOINT ["/start.sh"]
