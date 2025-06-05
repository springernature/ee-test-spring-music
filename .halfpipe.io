team: engineering-enablement
pipeline: ee-test-spring-music

feature_toggles:
  - update-pipeline

tasks:
  - type: docker-compose
    name: test
    service: pack-builder