#!/bin/bash
if [ -z "$SONARQUBE_PROJECT_URL" ]; then
  echo 1>&2 "error: missing SONARQUBE_PROJECT_URL environment variable"
  exit 1
fi
if [ -z "$SONARQUBE_PROJECT_KEY" ]; then
  echo 1>&2 "error: missing SONARQUBE_PROJECT_KEY environment variable"
  exit 1
fi
docker build -t hightechict/sonarrunnerdotnet:latest . --build-arg PROJECT_URL=$SONARQUBE_PROJECT_URL --build-arg PROJECT_KEY=SONARQUBE_PROJECT_KEY
docker push hightechict/sonarrunnerdotnet:latest