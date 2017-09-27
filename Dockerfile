FROM centos:7
MAINTAINER Andrea Manzi <manzolo@libero.it>

# Install packages

#INI COMUNEFI
ENV http_proxy 'http://proxyhttp.comune.intranet:8080/'
ENV https_proxy 'http://proxyhttps.comune.intranet:8080/'
ENV ftp_proxy 'proxyftp.comune.intranet:8080/'
ENV no_proxy 'localhost,127.0.0.1,.localhost,.comune.intranet'
ENV https_proxy_request_fulluri 0
ENV nss_ssl_cbc_random_iv 0
ENV HTTP_PROXY 'http://proxyhttp.comune.intranet:8080/'
ENV HTTPS_PROXY 'http://proxyhttps.comune.intranet:8080/'
ENV FTP_PROXY 'proxyftp.comune.intranet:8080/'
ENV NO_PROXY 'localhost,127.0.0.1,.localhost,.comune.intranet'
ENV https_proxy_request_fulluri 0
ENV nss_ssl_cbc_random_iv 0
#END COMUNEFI
ENV container docker

RUN yum clean all && \
  yum -y update &&  \
  yum -y install wget && \
  yum clean all
  
#Configurazione repositories (epel, ius)
RUN echo proxy=http://proxyhttp.comune.intranet:8080 >> /etc/yum.conf
COPY configura_repos.sh /tmp/configura_repos.sh
RUN chmod +x /tmp/configura_repos.sh
RUN /tmp/configura_repos.sh
#RUN cat /etc/yum.repos.d/gitlab_gitlab-ce.repo
 #Aggiornamento pacchetti
RUN yum clean all && \
  yum -y update
RUN yum -y install gitlab-ce

#docker build -t manzolo/gitlab .
#docker run -d -p 8080:80 -p 54320:5432 manzolo/gitlab
#docker run -p 8080:80 -p 54320:5432 -it manzolo/gitlab /bin/bash

#Entrare in un container in esecuzione con una shell
#docker exec -i -t $(docker ps -l -q) bash


#docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
#docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")

##PULIZIA TOTALE e Ricompilazione
####docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}"); docker rmi $(docker images -q); docker build -t manzolo/gitlab .
#5iveL!fe


##https://about.gitlab.com/downloads/#centos7
