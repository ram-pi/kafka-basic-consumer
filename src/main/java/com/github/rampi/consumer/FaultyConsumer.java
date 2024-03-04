package com.github.rampi.consumer;

import lombok.SneakyThrows;
import lombok.extern.log4j.Log4j2;
import org.apache.kafka.clients.consumer.Consumer;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.utils.Utils;

import java.util.Arrays;
import java.util.Properties;

@Log4j2
public class FaultyConsumer {

    private static final Integer SESSSION_TIMEOUT = 10000;

    @SneakyThrows
    public static void main(String[] args) {
        log.info("Consumer running...");

        Properties props = Utils.loadProps("client.properties");
        // set faulty configurations
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, false);
        props.put(ConsumerConfig.HEARTBEAT_INTERVAL_MS_CONFIG, 5000);
        props.put(ConsumerConfig.SESSION_TIMEOUT_MS_CONFIG, SESSSION_TIMEOUT);
        props.put(ConsumerConfig.MAX_POLL_INTERVAL_MS_CONFIG, 10000);

        Consumer<String, String> c = new KafkaConsumer<>(props);
        c.subscribe(Arrays.asList(props.get("topic").toString()));

        while (true) {
            c.poll(100).forEach(record -> {
                log.info("offset = {}, key = {}, value = {}", record.offset(), record.key(), record.value());
                doSomeProcessing(record.value());
                c.commitSync();
            });
        }
    }

    @SneakyThrows
    private static void doSomeProcessing(String value) {
        log.info("Processing: {}", value);
        Thread.sleep(SESSSION_TIMEOUT + 1000);
    }
}
