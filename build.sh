#!/bin/bash

set -e

# we have to download the tarfile to get the tag name
TARGETARCH="$(uname -m)"
UNMINEDARCH="$(grep $TARGETARCH arch.txt | cut -d' ' -f1)"
TAG=$(curl -s "https://unmined.net/download/unmined-cli-linux-$UNMINEDARCH-sc/" | \
tar -tz | head -1 | sed -E 's|unmined-cli_(.*)_net(.*)-linux-'"$UNMINEDARCH"'_sc/|\1|')

# build with buildkit so that TARGETARCH arg is available
# build without cache so that the latest release is downloaded
DOCKER_BUILDKIT=1 docker build --no-cache -t unmined-cli:$TAG -t unmined-cli:latest .
