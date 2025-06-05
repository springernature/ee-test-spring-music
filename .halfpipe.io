team: engineering-enablement
pipeline: ee-test-spring-music

tasks:
  - type: run
    name: build
    script: ./build.sh
    docker:
      image: eu.gcr.io/halfpipe-io/build-openjdk21
    save_artifacts:
      - build/libs/spring-music-1.0.jar

  - type: pack
    name: test
    path: build/libs
    buildpack: docker.io/paketobuildpacks/java:18
    restore_artifacts: true
    image_name: eu.gcr.io/halfpipe-io/engineering-enablement/halfpipe-e2e-spring-music

  - type: deploy-cf
    manifest: manifest-docker.yml
    space: halfpipe-test
    api: ((cloudfoundry.api-snpaas))
    docker_tag: gitref