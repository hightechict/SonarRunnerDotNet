FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env

RUN dotnet tool install --global dotnet-sonarscanner
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        default-jre

ARG PROJECT_URL
ARG PROJECT_KEY
COPY ./src/*.sh /scripts/
ENV PATH="/scripts:/root/.dotnet/tools:${PATH}"
RUN chmod +x /scripts/*.sh

WORKDIR /xyz
RUN dotnet-sonarscanner begin /k:$PROJECT_KEY /d:sonar.host.url=$PROJECT_URL \
	&& rm -rf /xyz

WORKDIR /src
CMD ["/scripts/complete.sh"]
