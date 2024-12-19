team: engineering-enablement
pipeline: ee-test-spring-music

feature_toggles:
  - update-pipeline

tasks:
  - type: run
    name: build
    script: ./build.sh
    docker:
      image: eu.gcr.io/halfpipe-io/build-openjdk17
    save_artifacts:
      - build/libs/spring-music-1.0.jar

  - type: parallel
    tasks:
    - type: deploy-cf
      name: deploy-classic-app-to-cf
      api: ((cloudfoundry.api-snpaas))
      org: engineering-enablement
      space: test
      deploy_artifact: build/libs/spring-music-1.0.jar
      manifest: manifest-classic.yml
    - type: run
      name: create-container-image
      script: \pack build spring-music --path ./build/libs --builder paketobuildpacks/builder-jammy-base
      docker:
        image: buildpacksio/pack:latest
      restore_artifacts: true