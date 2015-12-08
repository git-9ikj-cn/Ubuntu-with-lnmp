FROM ubuntu:latest
MAINTAINER Jiu Ai <admin@9ikj.cn> 

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

# Install wget tar screen packages
RUN apt-get -y install wget tar screen

# Download and install LNMP.
RUN wget -c http://static.suod.ga/lnmp/lnmp1.2-full.tar.gz && tar zxf lnmp1.2-full.tar.gz -C root && rm -rf lnmp1.2-full.tar.gz

#Change into 163 mirrors.
RUN wget -c http://mirrors.163.com/.help/sources.list.trusty && cp sources.list.trusty /etc/apt/sources.list && rm sources.list.trusty

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

VOLUME ["/home"]

EXPOSE 22 80 3306

CMD ["/run.sh"]
