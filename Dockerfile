### Base image ------------------------
FROM debian:buster as base-env

MAINTAINER tomabu

RUN apt update && apt install -y \
	libev-dev \
	build-essential \
	libcurl4-gnutls-dev \
	libncurses-dev \
	autoconf \
	git \
	wget \
	unzip

FROM base-env as ros-env
RUN wget https://github.com/roswell/roswell/archive/master.zip && unzip master.zip
RUN cd roswell-master && \
	./bootstrap && \
	./configure && \
	make && make install && \
	ros setup
RUN echo 'export PATH=$PATH:/root/.roswell/bin' >> /root/.bashrc
RUN ros install dbym4820/lem dbym4820/darkmatter

FROM ros-env as cl-execution
RUN mkdir /root/commonlisp && cd /root/commonlisp
WORKDIR /root/commonlisp
CMD ["/root/.roswell/bin/darkm"]

EXPOSE 8888


