############################################################
# Dockerfile to run Kaltura Container
# Based on CentOS 6.7 Image
############################################################

# base image to use to CentOS
FROM centos:6.7

# maintainer
MAINTAINER Maintaner ngi644


# SSH Install
USER root
RUN yum update -y
RUN yum install -y sudo
RUN yum install -y passwd
RUN yum install -y openssh
RUN yum install -y openssh-server
RUN yum install -y openssh-clients

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN /etc/init.d/sshd start
RUN /etc/init.d/sshd stop

# User
RUN echo 'root:docker' |chpasswd

RUN useradd docker
RUN echo 'docker:docker' |chpasswd
RUN echo "docker    ALL=(ALL)       ALL" >> /etc/sudoers.d/docker

# Installing Kaltura CE
ADD scripts/oflaDemo-r4472-java6.war /oflaDemo-r4472-java6.war
ADD scripts/kaltura-install-config.sh /kaltura-install-config.sh
ADD scripts/kaltura-install.sh /kaltura-install.sh
RUN chmod +x /kaltura-install-config.sh
RUN chmod +x /kaltura-install.sh
RUN /kaltura-install.sh

EXPOSE 22 25 80 443 1935 8088 5080 1936 21

# set hostname
ENV HOSTNAME kaltura.local

# copy start script
ADD scripts/start.sh /start.sh
RUN chmod +x /start.sh

# Define default command.
CMD /start.sh && /usr/sbin/sshd -D