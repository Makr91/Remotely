FROM ubuntu:focal

EXPOSE 5000

ENV ASPNETCORE_ENVIRONMENT="Production"
ENV ASPNETCORE_URLS="http://*:5000"
ENV COLUMNS 100
ENV KEY="SomeKey"
ENV USER="Makr91"
ENV URL="https://support.home.m4kr.net"
ENV REFERENCE="latest"


RUN \
  apt-get -y update && \
  apt-get -y install \
  apt-utils gawk wget git-core diffstat unzip texinfo gcc-multilib \
  build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
  xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
  xterm repo expect locales apt-transport-https acl git libssl1.0

RUN \
  wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb && \
  dpkg -i packages-microsoft-prod.deb && \
  apt-get -y update && \
  apt-get -y install aspnetcore-runtime-5.0

COPY ./DockerBuild.exp /tmp/

RUN \
  chmod a+x /tmp/setup.exp && \
  mkdir -p /var/www/remotely && \
  mkdir /config && \
  wget -q https://github.com/immense/Remotely/releases/download/v2021.08.26.1335/Remotely_Server_Installer && \
  chmod +x Remotely_Server_Installer && \
  mv Remotely_Server_Installer /var/www/Remotely_Server_Installer && \
  mkdir -p /remotely-data

VOLUME "/remotely-data"

WORKDIR /var/www/remotely

COPY DockerMain.sh /

RUN chmod 755 /DockerMain.sh

ENTRYPOINT ["/DockerMain.sh"]
