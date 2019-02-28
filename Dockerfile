FROM debian:stretch

USER root
WORKDIR /root/
RUN apt-get update && \
    apt-get -y install git python-pip autoconf bison build-essential pkg-config bison flex autoconf automake libtool make git python2.7 python-pip sqlite3 cmake sudo
RUN pip install flask flask-login pyserial

RUN useradd --create-home --shell /bin/bash openplc
RUN adduser openplc sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER openplc
WORKDIR /home/openplc

RUN git clone https://github.com/thiagoralves/OpenPLC_v3.git
WORKDIR /home/openplc/OpenPLC_v3
RUN sudo ./install.sh custom

RUN sudo apt-get clean

EXPOSE 8080
EXPOSE 502

ENTRYPOINT ["/home/openplc/OpenPLC_v3/start_openplc.sh"]