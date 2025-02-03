FROM openjdk:25-jdk-bookworm@sha256:9e2ce9c894fa34d70566dc1db69eda74ca4df85529d990fff56e13f36b4797da

ARG ALLURE_FILE_URL="https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/2.32.0/allure-commandline-2.32.0.tgz"
ARG ALLURE_FILE_SHA256="cdfa978b3eab9cf9f52489ea9284e431d8b0d2d859bcd56a791c320e803ce65c"

# RUN apt-get update && apt-get install -y wget unzip

RUN curl -s -o /tmp/allure.tgz $ALLURE_FILE_URL
# Check the sha256sum of the downloaded file
RUN echo "$ALLURE_FILE_SHA256  /tmp/allure.tgz" | sha256sum -c -

RUN tar -xzf /tmp/allure.tgz -C /tmp/ && \
    mv /tmp/allure-* /allure && \
    ln -s /allure/bin/allure /usr/bin/allure && \
    rm /tmp/allure.tgz

WORKDIR /app
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]