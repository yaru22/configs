# syntax=docker/dockerfile:1
FROM ubuntu:latest
LABEL org.opencontainers.image.authors="Brian Park <yaru22@gmail.com>"

# See https://stackoverflow.com/a/44683248
ARG USER_NAME=brianpark
ARG USER_PASSWORD=brianpark
ARG UID=1001
ARG GID=1001

# See https://stackoverflow.com/a/49848507
RUN groupadd --gid $GID --non-unique $USER_NAME  # allow to create groups with duplicate GID
RUN useradd --create-home --home-dir /home/$USER_NAME \
            --uid $UID --gid $GID --groups sudo \
            --shell /bin/bash $USER_NAME
# RUN echo "$USER_NAME:$USER_PASSWORD" | chpasswd

RUN apt-get update && \
    apt-get -y install curl emacs fd-find git ripgrep sqlite tmux
# Note that we stick to v1.3.0 because v1.5.0 (latest as of 2022/09) can't send meta key.
# See https://github.com/sorenisanerd/gotty/issues/44
RUN curl -L https://github.com/sorenisanerd/gotty/releases/download/v1.3.0/gotty_v1.3.0_linux_amd64.tar.gz -o /tmp/gotty.tar.gz
RUN tar xf /tmp/gotty.tar.gz -C /usr/local/bin
RUN rm /tmp/gotty.tar.gz

USER $USER_NAME 
WORKDIR /home/$USER_NAME

COPY .gotty .

# Had to manually install Doom Emacs since it's not easily automatable.
# git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
# ~/.emacs.d/bin/doom install

CMD gotty --term hterm tmux new -A -s emacs emacsclient --tty -a ''
EXPOSE 8080

