team: engineering-enablement
pipeline: ee-test-spring-music

feature_toggles:
  - update-pipeline

tasks:
  - type: run
    name: build
    script: ./build.sh
    docker:
      image: eu.gcr.io/halfpipe-io/build-openjdk21
    save_artifacts:
      - build/libs/spring-music-1.0.jar

  - type: docker-compose
    name: test
    service: pack-builder
    restore_artifacts: true