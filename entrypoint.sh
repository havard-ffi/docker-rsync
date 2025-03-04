#!/bin/sh
ALLOW=${ALLOW:-192.168.0.0/16 172.16.0.0/12 10.0.0.0/16}
UID=${UID:-1000}
GID=${GID:-1000}

mkdir -p /data
chown -R ${UID}:${GID} /data

cat <<EOF > /etc/rsyncd.conf
uid = ${UID}
gid = ${GID}
use chroot = no
log file = /dev/stdout
reverse lookup = no
hosts deny = *
hosts allow = ${ALLOW}
read only = false

[data]
    path = /data
    comment = Rsync data files
EOF

exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf
