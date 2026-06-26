#!/bin/sh
set -eu

# Ensure docker group exists and socket will be accessible
sudo groupadd -f docker 2>/dev/null || true

sudo sh -c 'dockerd >/var/log/dockerd.log 2>&1' &

for i in $(seq 1 15); do
    if docker info >/dev/null 2>&1; then
        echo "Docker daemon ready" >&2
        break
    fi
    sleep 1
done

# Fix socket ownership so docker group members can use it
if [ -S /var/run/docker.sock ]; then
    sudo chgrp docker /var/run/docker.sock
    sudo chmod 660 /var/run/docker.sock
fi

exec /usr/local/bin/entrypoint.sh "$@"
