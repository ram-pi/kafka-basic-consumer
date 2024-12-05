FROM maven:3.9.6-eclipse-temurin-17 as BUILD_IMAGE
ENV APP_HOME=/root/dev/myapp/
RUN mkdir -p $APP_HOME/src/main/java
WORKDIR $APP_HOME
COPY . .
RUN ls -alh
RUN mvn package

FROM openjdk:17
LABEL authors="ram-pi"
COPY  --from=BUILD_IMAGE /root/dev/myapp/target/kafka-basic-consumer-latest.jar app.jar
COPY ./jmx_prometheus_javaagent-1.1.0.jar jmx_prometheus_javaagent-1.1.0.jar
COPY ./client.properties client.properties
COPY ./exporter.yaml exporter.yaml
ENTRYPOINT ["java", "-javaagent:jmx_prometheus_javaagent-1.1.0.jar=1234:exporter.yaml", "-cp","app.jar","com.github.rampi.consumer.OkConsumer"]