# speedtest-prom

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/buschco/speedtest-prom?style=for-the-badge)

The [ internet-monitoring ](https://github.com/maxandersen/internet-monitoring) stack uses an outdated docker image for testing the internet speed.

Because of the lack of configuration, no use of the official [Ookla speedtest cli](https://www.speedtest.net/apps/cli) and no arm build for the raspberry pi, this image was created.

## usage

```yaml
services:
  speedtest:
    expose:
      - 9696
    ports:
      - 9696:9696
    image: buschco/speedtest-prom
    restart: always
    networks:
      - back-tier
```

## configuration

Currently you can only change the serverid like so:

```yaml
environment:
  - SERVER_ID=8099
```

To get the serverId run `speedtest -L`.

## build

idk how if there is an easier way to build the image for arm. I got it by running this command

```sh
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t buschco/speedtest-prom --push .
```

It works like a charm. But all the tools also have an arm build. Maybe I am just missing some configuration here 🤷
