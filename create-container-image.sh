#!/bin/sh

pack build spring-music \
  --path ./build/libs \
  --builder paketobuildpacks/builder-jammy-base \
  --buildpack paketobuildpacks/builder-jammy-base
docker tag spring-music eu.gcr.io/halfpipe-io/spring-music:latest
docker push eu.gcr.io/halfpipe-io/spring-music:latest
