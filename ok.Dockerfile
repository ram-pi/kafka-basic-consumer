FROM openjdk:17
LABEL authors="ram-pi"
COPY target/kafka-basic-consumer-latest.jar app.jar
COPY jmx_prometheus_javaagent-0.20.0.jar jmx_prometheus_javaagent-0.20.0.jar
COPY client.properties client.properties
COPY exporter.yaml exporter.yaml
ENTRYPOINT ["java","-javaagent:jmx_prometheus_javaagent-0.20.0.jar=1235:exporter.yaml", "-cp","app.jar","com.github.rampi.consumer.OkConsumer"]