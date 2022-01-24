FROM ubuntu:focal

EXPOSE 5000

ENV ASPNETCORE_ENVIRONMENT="Production"
ENV ASPNETCORE_URLS="http://*:5000"
ENV COLUMNS 100

RUN \
  apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive TZ=America/Chicago  apt-get -y install \
  apt-utils gawk wget curl acl git libssl1.0 git-core diffstat unzip texinfo gcc-multilib \
  build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
  xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
  xterm expect locales apt-transport-https 

RUN \
  wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb && \
  dpkg -i packages-microsoft-prod.deb && \
  apt-get -y update && \
  apt-get -y install aspnetcore-runtime-5.0

COPY ./DockerBuild.exp /

RUN \
  chmod a+x /DockerBuild.exp && \
  mkdir -p /var/www/remotely && \
  mkdir /config && \
  LATEST=$(curl -s https://api.github.com/repos/immense/Remotely/releases/latest | grep -v "*.exe" | awk -F\" '/Remotely_Server_Installer/{print $(NF-1)}' | egrep -v *.exe | egrep https) && \
  wget -q $LATEST -O /Remotely_Server_Installer && \
  chmod +x /Remotely_Server_Installer && 
  mkdir -p /remotely-data

VOLUME "/remotely-data"

WORKDIR /var/www/remotely

COPY DockerMain.sh /

RUN chmod 755 /DockerMain.sh

ENTRYPOINT ["/DockerMain.sh"]
