FROM adoptopenjdk/openjdk11:jdk-11.0.7_10-alpine-slim

ARG GITHUB_SHA
ARG GITHUB_REF
ENV SHA=$GITHUB_SHA
ENV REF=$GITHUB_REF

EXPOSE 8080-8082
WORKDIR /data/app
COPY target/poc-*.jar ./

RUN echo "GITHUB_SHA=$GITHUB_SHA" > version.properties && \
    echo "GITHUB_REF=$GITHUB_REF" >> version.properties && \
    addgroup -S jetty && adduser -S jetty -G jetty && \
	mkdir -p /data/app && \
	chown -R jetty:jetty /data/app
USER jetty

RUN java -version && \
	mv ./poc-*.jar ./poc.jar
CMD java \
    $EXTRA_PARAMETERS \
    -Dspring.profiles.active=$SPRING_PROFILES \
    -Dspring.jmx.enabled=true \
    -Dcom.sun.management.jmxremote.port=8082 \
    -Dcom.sun.management.jmxremote.rmi.port=8082 \
    -Dcom.sun.management.jmxremote.ssl=false \
    -Dcom.sun.management.jmxremote.authenticate=false \
    -Dcom.sun.management.jmxremote.local.only=false \
    -Djava.rmi.server.hostname=localhost \
    -jar poc.jar
