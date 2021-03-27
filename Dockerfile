FROM centos:latest

MAINTAINER Logan Mancuso
ENV DEBIAN_FRONTEND noninteractive

ADD config.xml /usr/share/doc/fahclient/sample-config.xml
ADD config.xml /etc/fahclient/config.xml

RUN yum -y update && yum -y install wget  \
  && wget -O fahclient-7.6.21-1.x86_64.rpm "https://download.foldingathome.org/releases/public/release/fahclient/centos-6.7-64bit/v7.6/fahclient-7.6.21-1.x86_64.rpm" --no-check-certificate \
  && dpkg -i --force-depends fahclient-7.6.21-1.x86_64.rpm \
  && chown fahclient:root /etc/fahclient/config.xml

EXPOSE 7396

CMD /etc/init.d/FAHClient start && tail -F /var/lib/fahclient/log.txt
