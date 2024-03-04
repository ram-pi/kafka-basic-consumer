# Consumer Examples with Moniting

## Run

```
java -javaagent:jmx_prometheus_javaagent-0.20.0.jar=1235:exporter.yaml -cp target/kafka-basic-consumer-latest.jar com.github.rampi.consumer.FaultyConsumer
java -javaagent:jmx_prometheus_javaagent-0.20.0.jar=1236:exporter.yaml -cp target/kafka-basic-consumer-latest.jar com.github.rampi.consumer.OkConsumer
```