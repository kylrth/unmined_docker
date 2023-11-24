#!/bin/bash

set -e

# we have to download the tarfile to get the tag name
TARGETARCH="$(uname -m)"
UNMINEDARCH="$(grep $TARGETARCH arch.txt | cut -d' ' -f1)"
TAG=$(curl -s "https://unmined.net/download/unmined-cli-linux-$UNMINEDARCH-dev/" | \
tar -tz | head -1 | sed -E 's|unmined-cli_(.*)-dev_linux-'"$UNMINEDARCH"'/|\1|')

# build without cache so that the latest release is downloaded
docker build --no-cache -t unmined-cli:$TAG -t unmined-cli:latest .
