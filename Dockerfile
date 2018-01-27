FROM ubuntu:16.04
MAINTAINER jdb

ENV CALDERA /tmp/caldera/

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

USER root
RUN apt-get -qq update && \ 
	apt-get install -qq -y \
		build-essential \
		git \
		python3-dev \
		mongodb \
		python3-pip \
		crudini \
		wget \
		supervisor

RUN pip3 install --upgrade setuptools 

RUN git clone https://github.com/mitre/caldera $CALDERA

RUN pip3 install -r $CALDERA/caldera/requirements.txt


#systemctl restart mongodb


RUN mkdir -p $CALDERA/dep/crater/crater && \
	 wget -O $CALDERA/dep/crater/crater/CraterMain.exe https://github.com/mitre/caldera-crater/releases/download/v0.1.0/CraterMainWin7.exe


EXPOSE 8888 
COPY supervisord.conf /etc/supervisor/conf.d/caldera.conf
ADD firstboot.sh /firstboot.sh
RUN touch /firstboot.tmp


ENTRYPOINT /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
