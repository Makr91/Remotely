FROM ubuntu:focal

EXPOSE 5000

ENV ASPNETCORE_ENVIRONMENT="Production"
ENV ASPNETCORE_URLS="http://*:5000"

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

RUN \
  mkdir -p /var/www/remotely && \
  mkdir /config && \
  wget -q https://github.com/lucent-sea/Remotely/releases/latest/download/Remotely_Server_Linux-x64.zip && \
  unzip -o Remotely_Server_Linux-x64.zip -d /var/www/remotely && \
  rm Remotely_Server_Linux-x64.zip
  
RUN \
  mkdir -p /var/www/remotely && \
  mkdir /config && \
  wget -q https://github.com/immense/Remotely/releases/download/v2021.08.26.1335/Remotely_Server_Installer && \
  chmod +x Remotely_Server_Installer && \
  ./Remotely_Server_Installer -b false -u Makr91 -p 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 -c true -s https://support.home.m4kr.net -i /var/www/remotely  -w 0 -r latest && \
  rm Remotely_Server_Installer


RUN \
  mkdir -p /remotely-data && \
  sed -i 's/DataSource=Remotely.db/DataSource=\/remotely-data\/Remotely.db/' /var/www/remotely/appsettings.json

VOLUME "/remotely-data"

WORKDIR /var/www/remotely

COPY DockerMain.sh /

RUN chmod 755 /DockerMain.sh

ENTRYPOINT ["/DockerMain.sh"]
