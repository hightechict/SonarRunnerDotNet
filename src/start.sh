#!/bin/bash
if [ -z "$SONARQUBE_PROJECT_KEY" ]; then
  echo 1>&2 "error: missing SONARQUBE_PROJECT_KEY environment variable"
  exit 1
fi
if [ -z "$GIT_BRANCH" ]; then
  echo 1>&2 "error: missing GIT_BRANCH environment variable"
  exit 1
fi
if [ -z "$HOST_URL" ]; then
  echo 1>&2 "error: missing HOST_URL environment variable"
  exit 1
fi
if [ -n "$GIT_PULLREQUEST_ID" ]; then
	if [ -z "$GIT_PULLREQUEST_SOURCEBRANCH" ]; then
	  echo 1>&2 "error: missing GIT_PULLREQUEST_SOURCEBRANCH environment variable"
	  exit 1
	fi
	if [ -z "$GIT_PULLREQUEST_TARGETBRANCH" ]; then
	  echo 1>&2 "error: missing GIT_PULLREQUEST_TARGETBRANCH environment variable"
	  exit 1
	fi
fi

if [ -z "$GIT_PULLREQUEST_ID" ]; \
then \
    dotnet-sonarscanner begin /k:"$SONARQUBE_PROJECT_KEY" /n:"$SONARQUBE_PROJECT_KEY" \
    /d:sonar.host.url=$HOST_URL \
    /d:sonar.cs.opencover.reportsPaths=/src/sonarqube/coverage/codeCoverage.xml \
    /d:sonar.branch.name=$GIT_BRANCH ; \
else \
    dotnet-sonarscanner begin /k:"$SONARQUBE_PROJECT_KEY" /n:"$SONARQUBE_PROJECT_KEY" \
    /d:sonar.host.url=$HOST_URL \
    /d:sonar.cs.opencover.reportsPaths=/src/sonarqube/coverage/codeCoverage.xml \
    /d:sonar.pullrequest.key=$GIT_PULLREQUEST_ID \
    /d:sonar.pullrequest.branch=$GIT_PULLREQUEST_SOURCEBRANCH \
    /d:sonar.pullrequest.base=$GIT_PULLREQUEST_TARGETBRANCH; \
fi