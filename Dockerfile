FROM ubuntu:xenial
LABEL maintainer="Jean-Avit Promis docker@katagena.com"
LABEL org.label-schema.vcs-url="https://github.com/nouchka/docker-openjardin"
LABEL version="latest"

ARG FILE_SHA256SUM=3dad9d2f2fa5e0386d51d5b7b5778b4fea26806e5313b26c9d7bdb71c9cd33d5
ARG FILE_VERSION=1.04
ARG FILE_URL=https://openjardin.eu/download/openjardin_${FILE_VERSION}_amd64.deb

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install wget && \
	wget -O /tmp/package.deb ${FILE_URL} && \
	echo "${FILE_SHA256SUM}  /tmp/package.deb"| sha256sum -c - && \
	apt install -y /tmp/package.deb && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	export uid=1000 gid=1000 && \
	mkdir -p /home/user/openjardin/ && \
	echo "user:x:${uid}:${gid}:User,,,:/home/user:/bin/bash" >> /etc/passwd && \
	echo "user:x:${uid}:" >> /etc/group && \
	chown ${uid}:${gid} -R /home/user

USER user
ENV HOME /home/user
VOLUME /home/user/openjardin/

CMD /usr/bin/openjardin
