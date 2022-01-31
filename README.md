# unmined_docker

A Dockerfile for building a distroless image for the [uNmINeD](https://unmined.net/) CLI binary. uNmINeD is a closed-source project, and it is always good security practice to containerize things as much as possible.

This repo does not distribute the uNmINeD binary, which would be a violation of the [license](https://unmined.net/license/). This repo itself has an MIT license; I don't care what you do with it.

## building

```sh
./build.sh
```

## usage

```yaml
docker-compose run --rm unmined-cli web render \
    --world "/data/world/" --dimension overworld \
    --zoomin 3 --shadows true \
    --output "/data/output/overworld"
```
