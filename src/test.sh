#!/bin/bash
dotnet test --no-build \
    /p:CollectCoverage=true \
    /p:Exclude=[xunit.*]* \
    /p:CoverletOutput=/src/sonarqube/coverage/codeCoverage.xml\
    /p:CoverletOutputFormat=opencover
