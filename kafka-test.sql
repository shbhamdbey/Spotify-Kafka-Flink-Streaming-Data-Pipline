-- kafka-test.sql

-- 1) Define a Kafka source table
CREATE TABLE test_source (
  `value` STRING
) WITH (
  'connector' = 'kafka',
  'topic' = 'test-topic',
  'properties.bootstrap.servers' = 'kafka:9092',
  'scan.startup.mode' = 'earliest-offset',
  'format' = 'csv'
);

-- 2) Define a simple "print" sink
CREATE TABLE print_sink WITH (
  'connector' = 'print'
) LIKE test_source (EXCLUDING OPTIONS);

-- 3) Stream from Kafka to the console
INSERT INTO print_sink
SELECT *
FROM test_source;
