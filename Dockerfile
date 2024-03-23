FROM ubuntu:latest

ARG USERNAME=lab
ARG PASSWORD=zaq1@WSX
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y openssh-server sudo xz-utils

RUN useradd --user-group --create-home --shell /bin/bash ${USERNAME}
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd
RUN adduser ${USERNAME} sudo

USER ${USERNAME}

WORKDIR /home/${USERNAME}
ENV PASS=${PASSWORD}

EXPOSE 22
ENTRYPOINT echo ${PASS} | sudo -S service ssh start && /bin/bash

# docker build -t so2_ubuntu .
# docker run -it -p 8888:22 -v "$(pwd)/common:/home/lab/common"  so2_ubuntu