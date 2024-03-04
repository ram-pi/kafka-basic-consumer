FROM openjdk:17
LABEL authors="ram-pi"
ARG JAR_FILE=./target/*.jar
COPY ${JAR_FILE} app.jar
COPY ./jmx_prometheus_javaagent-0.20.0.jar jmx_prometheus_javaagent-0.20.0.jar
COPY ./client.properties client.properties
COPY ./exporter.yaml exporter.yaml
ENTRYPOINT ["java","-cp","app.jar","com.github.rampi.consumer.FaultyConsumer"]