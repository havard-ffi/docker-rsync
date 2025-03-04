FROM debian:stable-backports
MAINTAINER Håvard Stien <havard.stien@ffi.no>

ENV TZ=Europe/Oslo
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
   apt install -yq --no-install-recommends rsync && \
  apt clean autoclean && \
  apt autoremove -y && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 873
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
